SONGNAME = "music.mp3"
--EXTRAMESSAGE = "If you press M you will get banned"

function startMusic()
    -- setRadioChannel(0)
    songOn = false
    song = playSound(SONGNAME,true)
    setSoundVolume(song,0)
	outputChatBox("Toggle music on/off using M")
    --if (EXTRAMESSAGE) then
		--outputChatBox(EXTRAMESSAGE,255,255,255,true)
	--end
end

function makeRadioStayOff(cancel)
    if (not songOn) then
        return
    end
    setRadioChannel(0)
    if (cancel) then
        cancelEvent()
    end
end

function toggleSong()
	if songOn then
    	setSoundVolume(song,0)
    	songOn = false
    else
    	setSoundVolume(song,1)
    	songOn = true
    	setRadioChannel(0)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff,true)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff,false)
addCommandHandler("togglemusic",toggleSong)
bindKey("m","down","togglemusic")