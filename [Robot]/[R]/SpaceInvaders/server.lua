-- Space Invaders server script by Ali Digitali
-- Anyone reading this has permission to modify/copy parts of this script (as long as you don't take credit for it

-- Things handled in this script:
-- - Triggers for clientside

function start(newstate,oldstate)
	--outputChatBox(newstate)
	setElementData(root,"racestate",newstate,true) -- update racestate for clientside
	if (newstate == "Running" and oldstate == "GridCountdown") then
		triggerClientEvent("retargetcamera",getRootElement())
		for index,theVehicle in ipairs (getElementsByType("vehicle")) do
			if not getVehicleOccupant(theVehicle) then
				setVehicleDamageProof(theVehicle,true)
				if getElementModel(theVehicle) == 432 then -- freeze tanks
					setElementFrozen(theVehicle,true)
				end
				
				local x,y,z = getElementPosition(theVehicle)
				setElementData (theVehicle, 'race.collideothers', 1 )
				
				local thePed = createPed(math.random(1,300),x,y,z)
				if thePed then -- in case an invalid model is rolled
					warpPedIntoVehicle(thePed,theVehicle)
				end
			end
		end
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function checkpointcounter(checkpoint,time_)
	triggerClientEvent(source,"markertriggers",source,checkpoint) -- trigger marker triggers clientside
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)