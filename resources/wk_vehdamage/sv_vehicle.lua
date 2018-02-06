--[[------------------------------------------------------------------------
	Fix Vehicle 
------------------------------------------------------------------------]]--
AddEventHandler( 'chatMessage', function( source, n, message )
    TriggerEvent("f:getPlayer", source, function(user)
        if(user.getPermissions() > 4 and message == "/sparkplug" ) then 
            TriggerClientEvent( 'wk:fixVehicle', source )
        end
    end)
end )