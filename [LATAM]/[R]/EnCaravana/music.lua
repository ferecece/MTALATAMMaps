
function startMusic()
    setRadioChannel(0)
    song = playSound("song.mp3",true)
	outputChatBox("Toggle music with key 'M'")
end

function replaceModel()
	txd = engineLoadTXD('solair.txd', 458)
	engineImportTXD(txd, 458)
	dff = engineLoadDFF('solair.dff', 458)
	engineReplaceModel(dff, 458)
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),replaceModel)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")
addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startMusic)