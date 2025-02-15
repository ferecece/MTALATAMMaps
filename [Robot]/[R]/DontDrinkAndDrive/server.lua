function chkcheck(checkpoint, time)
	triggerClientEvent ( source, "onHitCheckpoint", source )
end
addEvent('onPlayerReachCheckpoint')
addEventHandler('onPlayerReachCheckpoint', getRootElement(), chkcheck)

