function EndingSequence ( )
	Sound = playSFX("script", 68, 0, false)
	setSoundVolume(Sound, 1)
end
addEvent("PlayEndSequence", true)
addEventHandler("PlayEndSequence", getRootElement(), EndingSequence)
