local cruisecontrol = {
    on = false,
    speed = nil,
    vehicle = nil
}



Citizen.CreateThread(function ()
	while true do
		Wait(10)
        if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
            if IsControlJustPressed(0, 113) then
                if cruisecontrol.on then
                    lib.notify({
                        title = "Cruise control",
                        description = "Off",
                        type = 'inform'
                    })
                    cruisecontrol.on = false
                    cruisecontrol.vehicle = nil
                else
                    lib.notify({
                        title = "Cruise control",
                        description = "On",
                        type = 'success'
                    })
                    cruisecontrol.on = true
                    cruisecontrol.vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    cruisecontrol.speed = GetEntitySpeed(cruisecontrol.vehicle)
                end
            end
            if IsControlPressed(2, 76) or IsControlPressed(2,71) or IsControlPressed(2,72) or IsControlPressed(2,75) then 
                stopCruise()
            end
            if not IsVehicleOnAllWheels(cruisecontrol.vehicle) then 
                stopCruise()
            end
        end

        if cruisecontrol.on then
            SetVehicleForwardSpeed(cruisecontrol.vehicle,cruisecontrol.speed)
        end    
	end
end)


function stopCruise()
    cruisecontrol.on = false
    cruisecontrol.vehicle = nil
    cruisecontrol.speed = 0
end
