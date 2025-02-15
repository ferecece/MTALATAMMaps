function startText()
    outputChatBox("GTA III Diablo Stallion textures and model made by Pauloso",255,255,255,true)
    outputChatBox("Based on Slamvan, but handling is customized",255,255,255,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)