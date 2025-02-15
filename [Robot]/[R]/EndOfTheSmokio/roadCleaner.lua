local myMarker = createMarker(2371.2998, -1341.9004, 22.9,"cylinder",14,0,0,0,0)

function makeExplode(hitPlayer)
	-- destroyElement(myMarker)
	if hitPlayer == localPlayer then
		createExplosion(2371,-1315.9004,22.9,2,true,-1.0,false)
		createExplosion(2371,-1320.9004,22.9,4,true,-1.0,false)
	end
end

addEventHandler("onClientMarkerHit", myMarker, makeExplode)