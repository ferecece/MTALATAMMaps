function startText()
	outputChatBox("")
	outputChatBox("Congratulations, citizen.",240,70,70,true)
	outputChatBox("You have been selected for off-world relocation.",240,70,70,true)
	outputChatBox("")
end

function sky()
	setSkyGradient(150,0,0,50,10,10)
	setFogDistance(3)
	setCloudsEnabled(true)
end
 
addEventHandler("onClientResourceStart",resourceRoot,sky)
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)

addEventHandler("onClientExplosion",root,function(x, y, z, t)
	if t == 4 then
		cancelEvent()
	end
end)



SONGNAME = "neospugtopiaost.mp3"


function startMusic()
    -- setRadioChannel(0)
    songOn = false
    song = playSound(SONGNAME,true)
    setSoundVolume(song,0)
	outputChatBox("Press M to turn the music ON/OFF")
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
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")
-- addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startMusic)





function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,500)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)