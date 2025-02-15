function checkpointcounter(checkpoint,time_)
	if checkpoint == 14 then
		triggerClientEvent(source,"activateLivePath",source)
	end
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)
