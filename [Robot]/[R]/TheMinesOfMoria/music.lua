SONGNAME = "mixofmoria.mp3"


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






function blowOnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 4182) then 
            blowVehicle(source)
        end 
    end 
end 
addEventHandler("onClientVehicleCollision",getRootElement(),blowOnCollisionWithModel_Handler)

function text1OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 16410) then
			outputChatBox("The withered gravestone reads...",171,171,171,true)
			outputChatBox("Forever to slowly erode,",255,0,0,true)
			outputChatBox("The fate of nobody of note.",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text1OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text1OnCollisionWithModel_Handler)

function text2OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 1786) then
		    local covidMarker = createMarker(0,0,0,"corona",2,255,250,222,30)
			attachElements(covidMarker,localPlayer,0,0,0)
			local ringMarker = createMarker(0,0,0,"ring",.02,255,250,222,255)
			attachElements(ringMarker,localPlayer,0.3,0.5,0.3)
			outputChatBox("SPUGOL:#FFFFFF ARRGHGHGBLLB!!!! my precious... give tat... NOWE... back!!",101,189,210,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text2OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text2OnCollisionWithModel_Handler)

function text3OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 3524) then 
			outputChatBox("This being must have been worshipped for its W finger...",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text3OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text3OnCollisionWithModel_Handler)

function text4OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 1598) then 
			outputChatBox("There are no no Easter Eggs inside here. Go away.",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text4OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text4OnCollisionWithModel_Handler)

function text5OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 1795) then 
			outputChatBox("What on Middle-Earth are you looking at?",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text5OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text5OnCollisionWithModel_Handler)

function text6OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 1276) then 
			outputChatBox("The forgotten dwarven pakot has been found...",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text6OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text6OnCollisionWithModel_Handler)

function text7OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 13120) then 
			outputChatBox("Do not disturb the water.",255,0,0,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text7OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text8OnCollisionWithModel_Handler)

function text8OnCollisionWithModel_Handler(hitElement) 
    if (source == getPedOccupiedVehicle(localPlayer)) then 
        if (isElement(hitElement) and getElementModel(hitElement) == 7392) then 
			outputChatBox("Wanna become famous? Buy followers on twitch.tv/kyledoesit/subscribe",50,255,50,true)
			removeEventHandler("onClientVehicleCollision",getRootElement(),text8OnCollisionWithModel_Handler)
        end 
    end 
end
addEventHandler("onClientVehicleCollision",getRootElement(),text8OnCollisionWithModel_Handler)



