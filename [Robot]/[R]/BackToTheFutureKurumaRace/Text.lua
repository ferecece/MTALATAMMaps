function startText()
    outputChatBox("GTA III Kuruma textures and model made by AiExcel",255,255,255,true)
    outputChatBox("Based on Admiral, but handling is customized",255,255,255,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)