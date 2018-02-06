local displayTime = true
local useMilitaryTime = false
local displayDayOfWeek = true
local displayDate = false

local timeAndDateString = nil
local hour
local minute
local dayOfWeek
local month
local dayOfMonth
local year

-- Display Time and Date at top right of screen -- format: | 12:13 | Wednesday | January 17, 2017 |
Citizen.CreateThread(function()
	while true do
		Wait(1)
		timeAndDateString = ""
		
        if displayDayOfWeek == true then
			CalculateDayOfWeekToDisplay()
			timeAndDateString = timeAndDateString .. "~b~ " .. dayOfWeek .. " -"
		end
		if displayTime == true then
			CalculateTimeToDisplay()
			timeAndDateString = timeAndDateString .. "~w~ " .. hour .. ":" .. minute .. " ~s~ "
		end
		if displayDate == true then
			CalculateDateToDisplay()
			timeAndDateString = timeAndDateString .. " " .. month .. " " .. dayOfMonth .. ", " .. year .. " "
		end
		
		SetTextFont(4)
		SetTextProportional(0)
		SetTextScale(0.4, 0.4)
		SetTextColour(0, 255, 0, 255)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextDropShadow()
		SetTextRightJustify(false)
		SetTextWrap(0,0.95)
		SetTextEntry("STRING")
		
		AddTextComponentString(timeAndDateString)
		DrawText(0.475,0.001)
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDayOfWeekToDisplay()
	dayOfWeek = GetClockDayOfWeek()
	
	if dayOfWeek == 0 then
		dayOfWeek = "Sun"
	elseif dayOfWeek == 1 then
		dayOfWeek = "Mon"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Tues"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Wed"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Thurs"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Fri"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Sat"
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	year = GetClockYear()
	
	if month == 0 then
		month = "Jan"
	elseif month == 1 then
		month = "Feb"
	elseif month == 2 then
		month = "March"
	elseif month == 3 then
		month = "April"
	elseif month == 4 then
		month = "May"
	elseif month == 5 then
		month = "June"
	elseif month == 6 then
		month = "July"
	elseif month == 7 then
		month = "Aug"
	elseif month == 8 then
		month = "Sep"
	elseif month == 9 then
		month = "Oct"
	elseif month == 10 then
		month = "Nov"
	elseif month == 11 then
		month = "Dec"
	end
end
