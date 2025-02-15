--------
--Cows--
--------

local distance = 80

function startCowSound ()
	setRadioChannel (0)

	sound01 = playSound3D ("moo1.wav", -425.021484375, 187.2021484375, 6.2618017196655, true)
	setSoundMaxDistance (sound01, distance)

	sound02 = playSound3D ("moo1.wav", -671.42578125, 194.970703125, 22.583274841309, true)
	setSoundMaxDistance (sound02, distance)

	sound03 = playSound3D ("moo2.wav", -762.2431640625, -165.5458984375, 67.152763366699, true)
	setSoundMaxDistance (sound03, distance)

	sound04 = playSound3D ("moo1.wav", -113.421875, 197.5693359375, 5.0889267921448, true)
	setSoundMaxDistance (sound04, distance)

	sound05 = playSound3D ("moo2.wav", 664.23046875, -119.796875, 22.116752624512, true)
	setSoundMaxDistance (sound05, distance)

	sound06 = playSound3D ("moo1.wav", 1400.9580078125, -305.822265625, 3.7534399032593, true)
	setSoundMaxDistance (sound06, distance)

	sound07 = playSound3D ("moo2.wav", 1759.5556640625, 282.6875, 19.03258895874, true)
	setSoundMaxDistance (sound07, distance)

	sound08 = playSound3D ("moo1.wav", 1513.4814453125, 265.7490234375, 19.566257476807, true)
	setSoundMaxDistance (sound08, distance)

	sound09 = playSound3D ("moo2.wav", 760.375, -154.8818359375, 19.558650970459, true)
	setSoundMaxDistance (sound09, distance)

	sound10 = playSound3D ("moo1.wav", 589.400390625, -642.4912109375, 23.096485137939, true)
	setSoundMaxDistance (sound10, distance)

	sound11 = playSound3D ("moo2.wav", 665.3203125, -1075.3544921875, 49.435253143311, true)
	setSoundMaxDistance (sound11, distance)

	sound12 = playSound3D ("moo2.wav", 798.2626953125, -1162.0029296875, 24.58451461792, true)
	setSoundMaxDistance (sound12, distance)

end
addEvent( "startclientcowstartsound", true )
addEventHandler("startclientcowstartsound", getRootElement(), startCowSound)


-------------------
--Finaly CP Sound--
-------------------

function startFinalCPSound ()
	setRadioChannel (0)
	finalcpsound = playSound ("finalcp.wav", false)
end
addEvent("onClientPlayerFinish")
addEventHandler ("onClientPlayerFinish", getRootElement(), startFinalCPSound)
