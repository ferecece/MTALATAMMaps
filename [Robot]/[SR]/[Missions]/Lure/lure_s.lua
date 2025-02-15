function SetPlayer (checkpoint)
	local vehicle = getPedOccupiedVehicle(source)
	if checkpoint == 1 then
		setElementPosition(vehicle, -1957.67, -2443.7, 30.83)
		setElementRotation(vehicle, 0, 0, 241.85)
		setElementVelocity(vehicle, 0, 0, 0)
	end
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", root, SetPlayer)

function EndingSequence ( )
	triggerClientEvent (source, "PlayEndSequence", getRootElement())
end
addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish", root, EndingSequence)
