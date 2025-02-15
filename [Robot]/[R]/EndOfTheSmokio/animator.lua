
local myPed1 = createPed(281,2363.8,-1323.5,24,0)
local myPed2 = createPed(280,2366.8,-1323.4,24,0)
local myPed3 = createPed(281,2374.8,-1324.4,24,0)
local myPed4 = createPed(246,2378.8,-1324.9,24,0)
local myPed5 = createPed(102,2366.8,-1313.3,24.3,178)
local myPed6 = createPed(104,2378.8,-1312.4,24.3,186)

givePedWeapon(myPed1, 29, 9999,true)
givePedWeapon(myPed2, 29, 9999,true)
givePedWeapon(myPed3, 29, 9999,true)
givePedWeapon(myPed4, 29, 9999,true)
givePedWeapon(myPed5, 29, 9999,true)
givePedWeapon(myPed6, 29, 9999,true)

setPedControlState(myPed1, "fire", true)
setPedControlState(myPed2, "fire", true)
setPedControlState(myPed3, "fire", true)
setPedControlState(myPed4, "fire", true)
setPedControlState(myPed5, "fire", true)
setPedControlState(myPed6, "fire", true)

-- setPedAnimation( myPed1, "uzi", "uzi_crouchfire",-1,true,false,true)
-- setPedAnimation( myPed2, "uzi", "uzi_crouchfire",-1,true,false,true)
-- setPedAnimation( myPed3, "uzi", "uzi_crouchfire",-1,true,false,true)
-- setPedAnimation( myPed4, "uzi", "uzi_crouchfire",-1,true,false,true)
-- setPedAnimation( myPed5, "uzi", "uzi_crouchfire",-1,true,false,true)
-- setPedAnimation( myPed6, "uzi", "uzi_crouchfire",-1,true,false,true)


-- function makeAnim()
	-- destroyElement(myMarker)
	-- createExplosion(2371,-1315.9004,22.9,8,true,-1.0,true)
	-- createExplosion(2371,-1320.9004,22.9,8,true,-1.0,true)
-- end

-- addEventHandler("onClientMarkerHit", myMarker, makeExplode)