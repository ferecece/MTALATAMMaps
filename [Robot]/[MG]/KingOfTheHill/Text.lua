function startText()
    outputChatBox("Fight other players to stay at the top and become king of the hill!",0,255,0,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)