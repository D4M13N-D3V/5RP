--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
 
-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}
local KeyOpenClose = 289
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
--====================================================================================
--  
--====================================================================================
 
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if menuIsOpen == true then
      DeadCheck()
      for _, value in ipairs(KeyToucheCloseEvent) do
        if IsControlJustPressed(1, value.code) then
          --Citizen.Trace('Event: ' .. value.event)
          SendNUIMessage({keyUp = value.event})
        end
      end
    end
  end
end)
 
function DeadCheck() 
  local dead = IsEntityDead(GetPlayerPed(-1))
  if dead ~= isDead then 
    isDead = dead
    SendNUIMessage({event = 'updateDead', isDead = isDead})
  end
end

--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateYyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList", function(_contacts)
  Citizen.Trace('contactList')
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage", function(_messages)
  Citizen.Trace('allMessage')
  SendNUIMessage({event = 'updateMessages', messages = _messages})
  messages = _messages
end)

RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage", function(message)
  table.insert(messages, message)
  SendNUIMessage({event = 'updateMessages', messages = messages})
  if message.owner == 0 then 
    SetNotificationTextEntry("STRING")
    AddTextComponentString('~o~New message')
    DrawNotification(false, false)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
  end
end)
--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num) 
  TriggerServerEvent('gcPhone:addContact', display, num)
end

function deleteContact(num) 
  TriggerServerEvent('gcPhone:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('gcPhone:sendMessage', num, message)
end

function deleteMessage(msgId)
  Citizen.Trace('deleteMessage' .. msgId)
  TriggerServerEvent('gcPhone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcPhone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
  Citizen.Trace('setReadMessageNumber :d:eded')
  TriggerServerEvent('gcPhone:setReadMessageNumber', num)
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end
--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  Citizen.Trace('NUI Log | ' .. json.encode(data))
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)

RegisterNUICallback('blur', function(data, cb)
  cb()
end)

RegisterNUICallback('reponseText', function(data, cb)
Citizen.Trace('call reponseText | ' .. json.encode(data))
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  Citizen.Trace('call getMessages | ' .. json.encode(messages))
  cb(json.encode(messages))
end)

RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(GetPlayerPed(-1))
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)

RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)

RegisterNUICallback('deleteMessageNumber', function (data, cb)
Citizen.Trace('deleteMessageNumber' .. data.number)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)

RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb)
  Citizen.Trace('addContact: ' .. json.encode(data))
  TriggerServerEvent('gcPhone:addContact', data.display, data.phoneNumber)
end)

RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcPhone:updateContact', data.id, data.display, data.phoneNumber)
end)

RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcPhone:deleteContact', data.id)
end)

RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)

RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)
RegisterNUICallback('callEvent', function(data, cb)
  if data.data ~= nil then 
    TriggerEvent(data.eventName, {type = data.data})
  else
    TriggerEvent(data.eventName)
  end
  cb()
end)

RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gcPhone:deleteALL')
  cb()
end)

-- Just For reload 
TriggerServerEvent('gcPhone:allUpdate')

RegisterNetEvent("phone:open")
AddEventHandler("phone:open",function()
  menuIsOpen = true
  SendNUIMessage({show = menuIsOpen})
  ePhoneInAnim()
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  TriggerEvent("phone:closed")
  ePhoneOutAnim()
  SendNUIMessage({show = false})
  cb()
end)

RegisterNetEvent("phone:r")
AddEventHandler("phone:r",function()
  TriggerServerEvent('gcPhone:allUpdate')
end)
-- @author https://github.com/EmmanuelVlad/ephone

local inAnim = "cellphone_text_in"
local outAnim = "cellphone_text_out"
local outInCallAnim = "cellphone_call_out"
local callAnim = "cellphone_call_listen_base"
local idleAnim = "cellphone_text_read_base"

local phoneProp = 0
local phoneModel = "prop_npc_phone_02"

--------------------------------------------------------------------------------
--
--                FUNCTIONS
--
--------------------------------------------------------------------------------
function newPhoneProp()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
  RequestModel(phoneModel)
  while not HasModelLoaded(phoneModel) do
    Citizen.Wait(100)
  end
  return CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)
end

function ePhoneInAnim()
  if IsPlayerDead(PlayerId()) then
    return
  end
  local bone = GetPedBoneIndex(GetPlayerPed(-1), 28422)
  local dict = "cellphone@"
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    dict = dict .. "in_car@ds"
  end

  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(100)
  end

  TaskPlayAnim(GetPlayerPed(-1), dict, inAnim, 4.0, -1, -1, 50, 0, false, false, false)
  Citizen.Wait(157)
  phoneProp = newPhoneProp()
  AttachEntityToEntity(phoneProp, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

-- function ePhoneIdleAnim()
--  if IsPlayerDead(PlayerId()) then
--    return
--  end
--  local dict = "cellphone@"
--  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
--    dict = dict .. "in_car@ds"
--  end
--  RequestAnimDict(dict)
--  while not HasAnimDictLoaded(dict) do
--    Citizen.Wait(100)
--  end
--  TaskPlayAnim(GetPlayerPed(-1), dict, idleAnim, 1.0, -1, -1, 50, 0, false, false, false)
-- end

function ePhoneOutAnim()
  if IsPlayerDead(PlayerId()) then
    return
  end
  local dict = "cellphone@"
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    dict = dict .. "in_car@ds"
  end

  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(1)
  end
  if GetCurrentPedWeapon == 1 then
    ClearPedSecondaryTask(GetPlayerPed(-1))
    return
  end
  if inCall then
    StopAnimTask(GetPlayerPed(-1), dict, callAnim, 1.0)
    TaskPlayAnim(GetPlayerPed(-1), dict, outAnim, 5.0, -1, -1, 50, 0, false, false, false)
    inCall = false
  elseif not inCall then
    StopAnimTask(GetPlayerPed(-1), dict, inAnim, 1.0)
    TaskPlayAnim(GetPlayerPed(-1), dict, outAnim, 5.0, -1, -1, 50, 0, false, false, false)
  end
  Citizen.Wait(700)
  DetachEntity(phoneProp, true, false) 
  DeleteEntity(phoneProp)
  Citizen.Wait(500)
  StopAnimTask(GetPlayerPed(-1), dict, outAnim, 1.0)
end

-- function ePhoneCallAnim()
--  if IsPlayerDead(PlayerId()) then
--    return
--  end
--  local dict = "cellphone@"

--  RequestAnimDict(dict)
--  while not HasAnimDictLoaded(dict) do
--    Citizen.Wait(1)
--  end
--  StopAnimTask(GetPlayerPed(-1), "cellphone@", inAnim, 1.0)
--  TaskPlayAnim(GetPlayerPed(-1), dict, callAnim, 3.0, -1, -1, 50, 0, false, false, false)
-- end

-- function ePhoneSelfieAnim()
--  if IsPlayerDead(PlayerId()) then
--    return
--  end
--  local dict = "cellphone@self"
--  local anim = "selfie"

--  RequestAnimDict(dict)
--  while not HasAnimDictLoaded(dict) do
--    Citizen.Wait(1)
--  end
--  TaskPlayAnim(GetPlayerPed(-1), dict, outAnim, 1.0, -1, -1, 49, 0, false, false, false)
-- end
local phone_numbers = {}
RegisterNetEvent("phone:generatenumber")
AddEventHandler("phone:generatenumber",function(table, number)
  phone_numbers = table
  while number == nil or number == 0 do
      local randomnumber = getPhoneRandomNumber()
      local unique = IsNumberUnique(randomnumber)
      if unique then
        number = randomnumber
        TriggerServerEvent("phone:generated", number)
      end
  end
end)

function getPhoneRandomNumber()
    return '0' .. math.random(600000000,699999999)
end

function IsNumberUnique(pnumber)
    local unique = true
    for k,v in pairs(phone_numbers) do
        if v == pnumber then
            unique = false
            break
        end
    end
    return unique
end
