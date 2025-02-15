function startText()
    outputChatBox("GTA Vice City Stinger textures and model made by TheMadeMan",255,255,255,true)
    outputChatBox("Based on Turismo, but handling is customized",255,255,255,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)