local getbmx = 0

function checkhandler ( message, checkpoint )
	if getbmx == 0 then
		triggerServerEvent("myEvent", getLocalPlayer(), checkpoint)
	end
end
addEvent( "onHitCheckpoint", true )
addEventHandler( "onHitCheckpoint", localPlayer, checkhandler )

function markerHit ()
	getbmx = 1
end
addEvent( "hitmarker", true )
addEventHandler( "hitmarker", getRootElement(), markerHit )