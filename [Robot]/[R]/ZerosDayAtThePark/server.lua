local currentTarget = "Zero"
local ZeroPed
function ServerStart()
	setTimer(function()
		ZeroPed = createPed(306, 1959, -1201.1, 26.7, 90)
		setElementFrozen(ZeroPed, true)
		--setPedGravity(ZeroPed, 0)
		setPedAnimation(ZeroPed, "crib", "ped_console_loop", 10000, true, false, false, true, 0)
		giveWeapon(ZeroPed, 40, 1, true)
	end, 1000, 1)
end
addEventHandler("onResourceStart",root,ServerStart)

function setHandling ( thePlayer, seat, jacked ) -- assign players to a team (if they are not already) and paint their vehicle accordingly
	--destroyAttachedElements(source) -- remove all attached objects from possible upgrades
	
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	
	setVehicleHandling (theVehicle, "percentSubmerged", 150)
end
addEventHandler ( "onVehicleEnter", getRootElement(), setHandling )

function playerJustJoined()
	if (currentTarget == "Car") then
		triggerClientEvent(client, "targetCar", client)
	end
end
addEvent( "justJoined", true )
addEventHandler( "justJoined", resourceRoot, playerJustJoined )

function raceStateChanged(newStateName, oldStateName)

	--outputChatBox("newStateName = "..newStateName)
	
	if (newStateName == "GridCountdown") then
		triggerClientEvent("targetCar", resourceRoot)
		currentTarget = "Car"
		setTimer(function()
			destroyElement(ZeroPed)
			ZeroPed = createPed(306, 1960.5, -1201.1, 26.7, 270)
			setElementFrozen(ZeroPed, true)
			setPedAnimation(ZeroPed, "crib", "ped_console_loop", 10000, true, false, false, true, 0)
			giveWeapon(ZeroPed, 40, 1, true)
		end, 10000, 1)
	end
end
addEvent( "onRaceStateChanging", true )
addEventHandler( "onRaceStateChanging", resourceRoot, raceStateChanged )