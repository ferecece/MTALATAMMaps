addEvent( "starColours", true )

function starColours(thePlayer, secondsToFlash) 
	if secondsToFlash < 1 then
		return
	end
	
	setVehicleColor(thePlayer,255,255,0,255,255,0)     -- yellow		
	--setBlipColor(discoblips[thePlayer], 255,255,0,255)	
										
	setTimer ( function()
		setVehicleColor(thePlayer,0,255,255,0,255,255) -- cyan
		--setBlipColor(discoblips[thePlayer], 0,255,255,255)	
	end, 250, 1 )

	setTimer ( function()
		setVehicleColor(thePlayer,0,255,0,0,255,0)	   -- lime
		--setBlipColor(discoblips[thePlayer], 0,255,0,255)	
	end, 500, 1 )

	setTimer ( function()
		setVehicleColor(thePlayer,255,0,255,255,0,255) -- magenta
		--setBlipColor(discoblips[thePlayer], 255,0,255,255)	
	end, 750, 1 )

	setTimer ( function()
		--if getElementData(thePlayer,"disco") == true and getVehicleOccupant(thePlayer) then
		secondsToFlash = secondsToFlash - 1
		starColours(thePlayer, secondsToFlash)
		--else
		--setVehicleColor(thePlayer, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paints it green --
		--destroyElement(discoblips[thePlayer])
		--end
	end, 1000, 1 )
end
addEventHandler("starColours", root, starColours)


addEvent( "resetColour", true )
function resetColour(thePlayer) 
	setVehicleColor(thePlayer,148,157,159,171,152,143)
end
addEventHandler("resetColour", root, resetColour)


addEvent( "triggerVehicleBlow", true )
function triggerVehicleBlow(vehicle, player) 
	setClientMessage("You were blown by "..getPlayerName(player), getVehicleOccupant(vehicle))
	setClientMessage("You blew "..getVehicleOccupant(vehicle), getPlayerName(player))
	blowVehicle(vehicle)
end
addEventHandler("triggerVehicleBlow", root, triggerVehicleBlow)

addEvent( "getHomingTarget", true )
function getHomingTarget(player) 
	rankToGet = getElementData(player, "race rank") - 1
	
	alivePlayers = getAlivePlayers ()
	if ( alivePlayers ) then -- if we got the table
		-- Loop through the table
		for playerKey, playerValue in ipairs(alivePlayers) do
			if getElementData(playerValue, "race rank") == rankToGet then
				triggerClientEvent(player, "setHomingTarget", root, playerValue)
				setClientMessage("You were targeted by "..getPlayerName(player).."'s rocket", playerValue)
				break
			end
		end
	end
	triggerClientEvent(player, "setHomingTarget", root, nil)
end
addEventHandler("getHomingTarget", root, getHomingTarget)


addEvent( "popAllTires", true )
function popAllTires(player) 
	rankToCheck = getElementData(player, "race rank")
	
	alivePlayers = getAlivePlayers ()
	if ( alivePlayers ) then -- if we got the table
		-- Loop through the table
		for playerKey, playerValue in ipairs(alivePlayers) do
			if getElementData(playerValue, "race rank") < rankToCheck then
				triggerClientEvent(playerValue, "popTires", root)
				setClientMessage("Your tires were popped by "..getPlayerName(player), playerValue)
			end
		end
	end
end
addEventHandler("popAllTires", root, popAllTires)

addEvent( "popTargetTires", true )
function popTargetTires(player) 
	rankToCheck = getElementData(player, "race rank") - 1
	
	alivePlayers = getAlivePlayers ()
	if ( alivePlayers ) then -- if we got the table
		-- Loop through the table
		for playerKey, playerValue in ipairs(alivePlayers) do
			if getElementData(playerValue, "race rank") == rankToCheck then
				triggerClientEvent(playerValue, "popTires", root)
				setClientMessage("Your tires were popped by "..getPlayerName(player), playerValue)
				setClientMessage("You popped "..getPlayerName(playerValue).."'s tires", player)
				break
			end
		end
	end
end
addEventHandler("popTargetTires", root, popTargetTires)

addEvent( "setStormWeather", true )
function setStormWeather(player) 
	setWeather(16)
	triggerClientEvent("setFlower", root, player)
	setElementModel(getPedOccupiedVehicle(player), 557)
	setClientMessage("Watch out for "..getPlayerName(player), nil)
	setClientMessage("You made it rain!", player)
	setTimer(function()
		setWeather(2)
		setElementModel(getPedOccupiedVehicle(player), 571)
	end, 45000, 1)
end
addEventHandler("setStormWeather", root, setStormWeather)

addEvent( "changePlaces", true )
function changePlaces(player) 
	rankToGet = getElementData(player, "race rank") - 1
	
	alivePlayers = getAlivePlayers ()
	if ( alivePlayers ) then -- if we got the table
		-- Loop through the table
		for playerKey, playerValue in ipairs(alivePlayers) do
			if getElementData(playerValue, "race rank") == rankToGet then
				x1, y1, z1 = getElementPosition(getPedOccupiedVehicle(player))
				rx1, ry1, rz1 = getElementRotation(getPedOccupiedVehicle(player))
				cp1 = getElementData(player, "race.checkpoint")
				
				x2, y2, z2 = getElementPosition(playerValue)
				rx2, ry2, rz2 = getElementRotation(getPedOccupiedVehicle(playerValue))
				cp2 = getElementData(playerValue, "race.checkpoint")
				
				setElementPosition(getPedOccupiedVehicle(player), x2, y2, z2)
				setElementRotation(getPedOccupiedVehicle(player), rx2, ry2, rz2)
				setElementData(player, "race.checkpoint", cp2, true)
				setClientMessage("You swapped places with "..getPlayerName(playerValue), player)
				
				setElementPosition(getPedOccupiedVehicle(playerValue), x1, y1, z1)
				setElementRotation(getPedOccupiedVehicle(playerValue), rx1, ry1, rz1)
				setElementData(playerValue, "race.checkpoint", cp1, true)
				setClientMessage("You swapped places with "..getPlayerName(player), playerValue)
				break
			end
		end
	end
end
addEventHandler("changePlaces", root, changePlaces)

function setClientMessage(message, client)
	if client == nil then
		triggerClientEvent("setMessage", getRootElement(), message)
	else
		triggerClientEvent(client, "setMessage", getRootElement(), message)
	end
	
end


