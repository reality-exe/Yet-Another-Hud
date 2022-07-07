config = {
    speedUnit = 'mph', -- MPH or KPH (Defaults to MPH) --
    useNearestPostal = true -- Weather or not to use the Nearest Postal script.
}

-- No touchy these --
street = ''
streetName = ''
x, y, z = 0, 0, 0
local heading = ''
directions = {
    N = 360, 0,
    NE = 315,
    E = 270,
    SE = 225,
    S = 180,
    SW = 135,
    W = 90,
    NW = 45
    --  N = 0, <= will result in the HUD breaking above 315deg
  }

Citizen.CreateThread(function() -- Get current street
    while true do
        Citizen.Wait(100)
        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
        street = GetStreetNameAtCoord(x, y, z)
        streetName = GetStreetNameFromHashKey(street)
		zone = GetNameOfZone(x, y, z);
		zoneLabel = GetLabelText(zone);
    end
end)


-- Code below --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        -- Street Label --
        SendNUIMessage({
            name = streetName.. ' - '..heading.. ' | '.. exports["nearestpostal"]:getPostal() ,
            action = "streetLabel"
        })

        -- Time --
        getGameTime()
        SendNUIMessage({
            time = hour .. ':' .. minute,
            action = 'setTime'
        })

        -- Zone --
        SendNUIMessage({
            zone = zoneLabel,
            action = 'setZone'
        })
    end
end)

function getGameTime()
    hour = GetClockHours()
	minute = GetClockMinutes()
    if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedInAnyVehicle(GetPlayerPed(PlayerId())) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()))
            local entitySpeed = GetEntitySpeed(vehicle)
            if config.speedUnit == 'KPH' or config.speedUnit == 'kph' then
                SendNUIMessage({
                    speed = "KPH: " .. tostring(math.ceil(entitySpeed * 3.6)),
                    fuel = math.floor(exports["LegacyFuel"]:GetFuel(GetVehiclePedIsIn(GetPlayerPed(PlayerId())))),
                    action = "updateCarHud"
                })
            else
                SendNUIMessage({
                    speed = "MPH: " .. tostring(math.ceil(entitySpeed * 2.237)),
                    fuel = math.floor(exports["LegacyFuel"]:GetFuel(GetVehiclePedIsIn(GetPlayerPed(PlayerId())))),
                    action = "updateCarHud"
                })
            end
        end
    end
end)


-- Car Hud --

local vehicleDisplay = false
Citizen.CreateThread(function()
    local playerloc = GetEntityCoords(GetPlayerPed(-1))
    local streethash = GetStreetNameAtCoord(playerloc.x, playerloc.y, playerloc.z)
    street = GetStreetNameFromHashKey(streethash)
    while true do
        Citizen.Wait(100)
        if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
            SetCarHudDisplay(true)
            
        else
            SetCarHudDisplay(false)
        end
    end
end)


function SetCarHudDisplay(bool)
    vehicleDisplay = bool
    SendNUIMessage({
        type = 'carHud',
        status = bool
    })
end

-- Car Hud End --


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
        street = GetStreetNameAtCoord(x, y, z)
    end
end)

Citizen.CreateThread(function()

	while true do
		local ped = GetPlayerPed(-1);
		local veh = GetVehiclePedIsIn(ped, false);

		local coords = GetEntityCoords(PlayerPedId());
		local zone = GetNameOfZone(coords.x, coords.y, coords.z);
		local zoneLabel = GetLabelText(zone);

		if(true) then 
			local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
			hash1 = GetStreetNameFromHashKey(var1);
			hash2 = GetStreetNameFromHashKey(var2);
			heading = GetEntityHeading(PlayerPedId());
			
			for k, v in pairs(directions) do
				if (math.abs(heading - v) < 22.5) then
					heading = k;
		  
					if (heading == 1) then
						heading = 'N';
						break;
					end

					break;
				end
			end
		else
		end
		
		-- Wait for half a second.
		Citizen.Wait(500);
		
	end
end)
