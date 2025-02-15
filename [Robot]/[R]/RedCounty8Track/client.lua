function markerHit ()
	local sound = playSound("m.mp3")
end
addEvent( "hitmarker", true )
addEventHandler( "hitmarker", getRootElement(), markerHit )

function markerHit2 ()
	local sound = playSound("n.mp3")
end
addEvent( "hitmarker2", true )
addEventHandler( "hitmarker2", getRootElement(), markerHit2 )

function markerHit3 ()
	local sound = playSound("o.mp3")
end
addEvent( "hitmarker3", true )
addEventHandler( "hitmarker3", getRootElement(), markerHit3 )

function markerHit4 ()
	local sound = playSound("p.mp3")
end
addEvent( "hitmarker4", true )
addEventHandler( "hitmarker4", getRootElement(), markerHit4 )