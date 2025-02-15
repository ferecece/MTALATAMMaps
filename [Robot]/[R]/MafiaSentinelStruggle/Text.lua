function startText()
    outputChatBox("GTA III Mafia Sentinel textures and model made by Pauloso",255,255,255,true)
    outputChatBox("Based on regular SA Sentinel, but handling is customized",255,255,255,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)