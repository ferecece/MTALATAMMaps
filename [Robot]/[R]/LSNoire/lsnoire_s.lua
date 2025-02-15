addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish", root, 

function (FinishJingle)
    triggerClientEvent (source, "PlayFinishJingle", getRootElement())
end     

)