function setInterior ( )
	if getPedOccupiedVehicle(localPlayer) == false then
		setTimer(setInterior, 100, 1)
		return
	end
	setElementPosition(getPedOccupiedVehicle(localPlayer), -786.5, 481.6, 1371.4)
	setElementInterior(localPlayer, 1)
	setElementInterior(getPedOccupiedVehicle(localPlayer), 1)

end
addEventHandler ( "onClientResourceStart", getRootElement(), setInterior )

function EndingSequence ( )
	Sound = playSFX("script", 26, 38, false)
	setSoundVolume(Sound, 1)
			
	setTimer(function()
		Sound = playSFX("script", 26, 39, false)
		setSoundVolume(Sound, 1)
	end, 2750, 1)
end
addEvent("PlayEndSequence", true)
addEventHandler("PlayEndSequence", getRootElement(), EndingSequence)