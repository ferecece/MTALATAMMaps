-- Clientside script for The Heist, by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script

-- Things handled by this script:
-- - Cutscene at start
-- - Actions for special checkpoints
-- - 
-- - 

localDimension = math.random(1,65535)

--counter = 1
function makeinvisible() -- creates the getaway vehicle, and makes you an invisible observer
	-- if (counter == 1) and (thePlayer == localPlayer) then -- make sure this only happens when you enter a vehicle at the start
		-- counter = 2
		
		RaceVehicle = createVehicle (603,1480,-1742,13.5,0,0,90) -- make getaway car
		setElementFrozen(source,true)	--(comment this line when testing to skip)
		addEventHandler ( "onClientRender", root, fixCameraOnBank ) 	 --(comment this line when testing to skip)
		-- create the barrels for the bridge part
		-- UPDATE NEEDED, ALSO INCLUDE POLICE PEDS AND VEHICLES --
		rancher1 = createVehicle(599,71.5,-1543,5.3,0,0,190)
		rancher2 = createVehicle(599,71,-1535,5.3)
		rancher3 = createVehicle(599,72,-1528,5.3,0,0,157)
		thebridge = createObject(18450,-1627.1999511719,-1620.9000244141,34.900001525879,0,0,22.747192382813) -- the bridge that will be destroyed later on.
	--end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), makeinvisible) 

function fixCameraOnBank ()
	setCameraMatrix (1473.4000244141,-1701.5999755859,23.5,1480,-1725,15.2)
end


function clientstart()
	if (getElementData(root,"racestate")== "Running") and getElementData(localPlayer,"justjoined") then -- is syncrhonised from the serverside, this will only happen if the player has joined when the map already started.
		--outputChatBox("race cutscene triggered for latecommer")
		setElementData(localPlayer,"justjoined",false,true)
		functiontostart()
	end
end
addEvent("onClientScreenFadedIn")
addEventHandler("onClientScreenFadedIn",root,clientstart)

-- make sure you stay in the observer position when the race starts (triggered from serverside)
function stayinvisiblefunction()
	setElementFrozen(getPedOccupiedVehicle(localPlayer),true)
	-- for index,theVehicle in ipairs (getElementsByType("vehicle")) do
		-- if (getVehicleOccupant(theVehicle)) then -- if a vehicle is occupied, and another player is inside, change the model to a police car
			-- if ( getElementType(getVehicleOccupant(theVehicle)) == "player" ) and (getVehicleOccupant(theVehicle) ~= localPlayer) then
				-- setElementModel(theVehicle,596)
				-- setVehicleColor(theVehicle,0,0,0,255,255,255)			
			-- end
		-- end
	-- end
end
addEvent ( "stayinvisible", true )
addEventHandler ( "stayinvisible", getRootElement(), stayinvisiblefunction )	

addEventHandler("onClientVehicleEnter",root,function(thePlayer,seat) -- change model on respawn, because it resets
	if ( getElementType(thePlayer) == "player" ) and (thePlayer ~= localPlayer) then -- if player that entered is a player and not the local player, change the model to a police car
		local theVehicle = source
		setTimer(function()
			setVehicleSirensOn(theVehicle,true)
			setElementModel(theVehicle,596)
			setVehicleColor(theVehicle,0,0,0,255,255,255)
		end,200,1)
	end
end)

function functiontostart() -- function to start the cutscene triggered from serverside
	setElementFrozen(getPedOccupiedVehicle(localPlayer),true) -- freeze the player so that you can't start driving
-- creates cj with money and makes him run
	pedcj = createPed (0,1481,-1769,18.799999237061)
	moneybag = createObject(1550,1481,-1769,19,0,0,0,true)
	attachElements(moneybag,pedcj,0,-0.2,0.5)
	setPedControlState(pedcj,"forwards",true) 

--shooting police at start
	for index,thePed in ipairs (getElementsByType("ped")) do
		setPedControlState(thePed,"fire",true)
		setPedAimTarget(thePed,1481,-1769,18.799999237061)
		local model = getElementModel(thePed)
		if (model == 300) or (model == 270) or (model == 269) then
			else
			addEventHandler( "onClientElementStreamIn", getRootElement( ), --regive the weapon serverside to stop it from glitching. If this is not done the peds will only fire one bullet and then stop
			function ( )
				triggerServerEvent ( "regiveweapon", localPlayer, thePed) 
			end
			);
		end
	end

-- police car part, creates two moving police cars towards the bank
	setTimer(function()
		policecar1 = createVehicle(596,1594.6999511719,-1724.0999755859,13.3,0,0,101)
		policeofficer1 = createPed(288, 1600,-1720,13)
		warpPedIntoVehicle ( policeofficer1, policecar1)
		setVehicleSirensOn(policecar1, true)
		policecar2 = createVehicle(596,1591.9000244141,-1719.3000488281,13.3,0,0,101)
		policeofficer2 = createPed(288, 1600,-1720,13)
		warpPedIntoVehicle ( policeofficer2, policecar2)
		setVehicleSirensOn(policeofficer2,true)
		setPedControlState(policeofficer1,"accelerate",true)
		setPedControlState(policeofficer2,"accelerate",true)
		setElementData ( policecar1, 'race.collideothers', 1 )
		setElementData ( policecar2, 'race.collideothers', 1 )
	
	-- pop the wheels for extra randomness
		setTimer( function()
			setVehicleWheelStates(policecar1,1,1,1,1)
			setVehicleWheelStates(policecar2,1,1,1,1)
		end,4000,1)
	end,1000,1)

	racercar = getPedOccupiedVehicle(localPlayer)

--create explosions and fires near the bank
	setTimer( function()
		local offset1 = math.random(-10,10)
		local offset2 = math.random(-5,5)
		createExplosion(1482+offset1,-1770+offset2,18,2,true,1,false)
		createFire(1482+offset1,-1760,18,5.5)
	end,500,14)

-- timer to start the driveaway part
	setTimer ( function()
		--create an extra moneybag and place them both in the back of the car
		setElementDoubleSided(moneybag,true)
		moneybag2 = createObject(1550,1481,-1769,19,0,0,0,true)
		attachElements(moneybag,racercar,0,-1.2,0.25,0,90,0)
		attachElements(moneybag2,racercar,0,-1.2,0.25,0,90,180)
		
		-- makes cj drive away
		setPedControlState(pedcj,"forwards",false)
		warpPedIntoVehicle ( pedcj, RaceVehicle)
		setPedControlState(pedcj,"accelerate",true) 
		
		--setTimer( function() -- blow the policecars
			blowVehicle(policecar1)
			blowVehicle(policecar2)
		--end,200,1)
		
		setTimer( function() -- destroys cj and the car dummy and replaces it with the actual player
			destroyElement(pedcj)
			destroyElement(RaceVehicle)
			removeEventHandler ( "onClientRender", root, fixCameraOnBank )
			setElementFrozen(getPedOccupiedVehicle(localPlayer),false)
			setElementVelocity(getPedOccupiedVehicle(localPlayer),-0.5,0,0)
			setCameraTarget(localPlayer)
			for index,thePed in ipairs (getElementsByType("ped")) do
				setPedControlState(thePed,"fire",false)
			end
		end, 3000,1)
	end, 6000, 1 )
end
addEvent ( "startthemap", true )
addEventHandler ( "startthemap", getRootElement(), functiontostart )


-- function for the triggers, triggers on checkpoints
function markertriggers(markercounter)

if (markercounter == 3) then -- first trigger to activate the chopper
	choppercop = createPed (288,1007,-1804,0)
	policechopper = createVehicle(497,1000.5999755859,-1808.1999511719,16,0,0,80)
	warpPedIntoVehicle ( choppercop, policechopper)
	setPedControlState(choppercop,"horn",true)
	setTimer(function()
		setPedControlState(choppercop,"horn",false)
	end,200,1)
	setVehicleRotorSpeed (policechopper,0.2)
	setVehicleSirensOn(policechopper,true)
	setPedControlState(choppercop,"accelerate",true)
	setPedControlState(choppercop,"steer_forward",true)
	
	
	-- blow up the chopper when it hits the billboard
	setTimer(function()
		blowVehicle(policechopper)
	end,14000,1)
end

-- if (markercounter ==4) then
	-- setElementData ( getPedOccupiedVehicle(localPlayer), 'race.collideothers', 1 ) -- turn on ghostmode
-- end

if (markercounter == 6) then -- second trigger to start the shooting at the first blockade
	local x,y,z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	for index,thePed in ipairs (getElementsByType("ped")) do
		setPedControlState(thePed,"fire",true)
		setPedAimTarget(thePed,x,y,z)
		-- local model = getElementModel(thePed) (not needed, added in functiontostart
		-- if (model == 300) or (model == 270) or (model == 269) then
			-- else
			-- addEventHandler( "onClientElementStreamIn", getRootElement( ), --regive the weapon serverside to stop it from glitching. If this is not done the peds will only fire one bullet and then stop
			-- function ( )
				-- triggerServerEvent ( "regiveweapon", localPlayer, thePed) 
			-- end
			-- );
		-- end
	end
end

if (markercounter == 8) then -- third trigger to repair the tires if they have been shot
	setVehicleWheelStates(getPedOccupiedVehicle(localPlayer),0,0,0,0)
end

if (markercounter == 11) then -- slowmotion shooting at the second blockade
	if specialbarrel then
		respawnObject(specialbarrel)
		fixVehicle(rancher1)
		fixVehicle(rancher2)
		fixVehicle(rancher3)
		setElementPosition(rancher1,71.5,-1543,5.3)
		setElementRotation(rancher1,0,0,190)
		setElementPosition(rancher2,71,-1535,5.3)
		setElementRotation(rancher2,0,0,0)
		setElementPosition(rancher3,72,-1528,5.3)
		setElementRotation(rancher3,0,0,157)
	else
		specialbarrel = createObject(1225,73.5,-1545,4.6)
		addEventHandler("onClientObjectBreak", specialbarrel, objectBreak)
	end
	createObject(1225,73.5,-1541,4.6)
	createObject(1225,73.5,-1537,4.6)
	createObject(1225,73.5,-1533,4.6)
	createObject(1225,73.5,-1529,4.6)
	createObject(1225,73.5,-1525,4.6)
	setVehicleDamageProof(getPedOccupiedVehicle(localPlayer),true)
	setPedDoingGangDriveby(localPlayer,true)
	gmspd = 1
	setTimer(function()
		gmspd = gmspd - 0.1
		setGameSpeed(gmspd)
	end, 300,7) --repeat this 7 times
	setTimer(function()
		setTimer(function()
			gmspd = gmspd + 0.1
			setGameSpeed(gmspd)
		end, 300,7)
		setPedDoingGangDriveby(localPlayer,false)
		setVehicleDamageProof(getPedOccupiedVehicle(localPlayer),false)
	end,4000,1)
end

if (markercounter == 13) then -- create the surprise roadtrain comming from the right
	roadtrain = createVehicle(515,-60,-1145,2.2,0,0,65)
	setElementData (roadtrain, 'race.collideothers', 1 )  -- makes it collide with the vehicles
	trucker = createPed (288,-55,-1151,2.2)
	
	setElementDimension(roadtrain,localDimension)
	setElementDimension(trucker,localDimension)
	
	warpPedIntoVehicle ( trucker, roadtrain)
	setPedControlState(trucker,"accelerate",true)
	setPedControlState(trucker,"horn",true)

end

if (markercounter == 14) then -- trigger for slowmotion at truck collision
	setElementDimension(localPlayer,localDimension)
	setElementDimension(getPedOccupiedVehicle(localPlayer),localDimension)
	setElementData(getPedOccupiedVehicle(localPlayer),'race.collideothers', 1)
	setElementPosition(roadtrain,-83.4,-1134.8,2.2)
	setElementVelocity(roadtrain,6*-0.054214987903833,6*0.025281051173806,6*0.0040085157379508)
	setGameSpeed(0.3)
	setTimer(function()
		setGameSpeed(1)
	end,1500,1)
	
	setTimer(function()
		setElementData(getPedOccupiedVehicle(localPlayer),'race.collideothers', 0)
		setElementDimension(localPlayer,0)
		setElementDimension(getPedOccupiedVehicle(localPlayer),0)
	end,3000,1)
end

if (markercounter == 19) then  -- help from the homies trigger
	-- create driving police car behind the player
	bridgepolice1= createPed (288,-538.5,-1077.3000488281,23.1)
	bridgepolicecar1 = createVehicle(596,-530.79998779297,-1072.3000488281,23.4,0,0,148)
	setElementData ( bridgepolicecar1, 'race.collideothers', 1 )
	warpPedIntoVehicle ( bridgepolice1, bridgepolicecar1)
	setVehicleSirensOn(bridgepolicecar1,true)
	setPedControlState(bridgepolice1,"accelerate",true)
	local vel1,vel2,vel3 = getElementVelocity(getPedOccupiedVehicle(localPlayer))
	setElementVelocity(bridgepolicecar1,vel1*0.8,vel2*0.8,vel3*0.8)
	
	-- make the homies target the vehicle
	for index,thePed in ipairs (getElementsByType("ped")) do
		local model = getElementModel(thePed)
		if (model == 300) or (model == 270) or (model == 269) then
			setPedControlState(thePed,"fire",true)
			addEventHandler ( "onClientPreRender", root,
				function ()
					local x, y, z = getElementPosition (bridgepolicecar1)
					setPedAimTarget(thePed,x,y,z)
				end
				);
			addEventHandler( "onClientElementStreamIn", getRootElement( ), --regive the weapon serverside to stop it from glitching. If this is not done the peds will only fire one bullet and then stop
				function ( )
					triggerServerEvent ( "regiveweapon", localPlayer, thePed,30) 
				end
				);
		end
	end
	
	-- slowmotoin and camera movement
	setGameSpeed(0.5)
	local cameraX,cameraY,cameraZ,targetX,targetY,targetZ,roll,fov = getCameraMatrix ( )
	smoothMoveCamera(cameraX,cameraY,cameraZ,targetX,targetY,targetZ,-588.29998779297,-1166.9000244141,45.099998474121,-579.20001220703,-1143.0999755859,34.799999237061,2000) -- function at the top
	setTimer(function()
		setGameSpeed(1)
	end,2000,1)
	setTimer(function()
		blowVehicle(bridgepolicecar1)
	end,2500,1)
	setTimer(function()
		setCameraTarget(localPlayer)
	end,4000,1)
end

if (markercounter == 24) then -- create the falling rocks
	rock1 = createObject(1305,-767.7,-1565,121.2)
	rocktrigger1= createVehicle(564,-767.7,-1565,125.2) -- rocktrigger is the tiny rc rhino, this falls down on the boulder making it fall down
	setElementAlpha(rocktrigger1,0)

	rock2 = createObject(1305,-767.7,-1563,121.2)
	rocktrigger2= createVehicle(564,-767.7,-1563,125.2)
	setElementAlpha(rocktrigger2,0)

	rock3 = createObject(1305,-765.7,-1560,121.2)
	rocktrigger3= createVehicle(564,-765.7,-1560,125.2)
	setElementAlpha(rocktrigger3,0)

	setTimer(function()
		destroyElement(rocktrigger1)  -- destroy the trigger vehicles to stop them from also falling down on the road
		destroyElement(rocktrigger2)
		destroyElement(rocktrigger3)
	end,2000,1)
end

if (markercounter == 25) then -- trigger for slowmotion at rock fall
	setGameSpeed(0.3)
	setTimer(function()
		setGameSpeed(1)
	end,1500,1)
end
	
if (markercounter == 30) then --bridge collaps create explosions
	local cameraX,cameraY,cameraZ,targetX,targetY,targetZ,roll,fov = getCameraMatrix ( )
	smoothMoveCamera(cameraX,cameraY,cameraZ,targetX,targetY,targetZ,-1555,-1590,57.6,-1677.1999511719,-1642,35.3,1000)
	setTimer(function()
	local x,y,z = getElementPosition(getPedOccupiedVehicle(localPlayer)) -- create explosions
	createExplosion(x-3,y+7,z,2,true,1,false)
	createExplosion(x+3,y-5,z,2,true,1,false)
	end,200,10)
end

if (markercounter == 31) then -- remove the bridge and spawn police vehicles driving off
	local cameraX,cameraY,cameraZ,targetX,targetY,targetZ,roll,fov = getCameraMatrix ( )
	local xoffset = targetX - cameraX
	local yoffset = targetY - cameraY
	local zoffset = targetZ - cameraZ 
	destroyElement(thebridge)
	createExplosion(cameraX-(xoffset*0.1),cameraY-(yoffset*0.1),cameraZ-(zoffset*0.1),10,true,1,false)
	
	for index,theElement in ipairs (getElementsByType("object")) do -- shift the rubble back to dimension 0
		if (getElementDimension(theElement) == 1) then
		setElementDimension(theElement,0)
		end
	end
	
	local bridgepolice2= createPed (288,-1559.1999511719,-1593.5999755859,38.8)
	local bridgepolicecar2 = createVehicle(599,-1559.1999511719,-1593.5999755859,38.8,0,0,111)
	warpPedIntoVehicle ( bridgepolice2, bridgepolicecar2)
	setVehicleSirensOn(bridgepolicecar2,true)
	setPedControlState(bridgepolice2,"accelerate",true)
	
	setTimer(function()
		local bridgepolice2= createPed (288,-1559.1999511719,-1593.5999755859,38.8)
		local bridgepolicecar2 = createVehicle(599,-1559.1999511719,-1593.5999755859,38.8,0,0,113)
		warpPedIntoVehicle ( bridgepolice2, bridgepolicecar2)
		setVehicleSirensOn(bridgepolicecar2,true)
		setPedControlState(bridgepolice2,"accelerate",true)
	end,1000,2)	
end
end
addEvent("markertriggers",true)
addEventHandler ( "markertriggers", getRootElement(), markertriggers )

addEventHandler("onClientVehicleCollision", root,
    function(collider,force, bodyPart, x, y, z, nx, ny, nz,hitelementforce,model)
         if ( source == getPedOccupiedVehicle(localPlayer) ) and (model == 1305) then
         blowVehicle(source)  -- blow the vehicle if it gets hit by a rock
         end
    end
)

function objectBreak()
	if (source == specialbarrel) then
		blowVehicle(rancher1)
		blowVehicle(rancher2)
		blowVehicle(rancher3)
	end
end


screenWidth, screenHeight = guiGetScreenSize ( )
function displayText()
dxDrawText ("MISSION PASSED!", screenWidth,screenHeight/2-100,0,0, tocolor ( 230, 110, 0, 255 ), 3,"Pricedown","center")
dxDrawText ("$" .. earnings1 .. "," .. earnings2, screenWidth,screenHeight/2,0,0, tocolor ( 255, 255, 255, 255 ), 2,"Pricedown","center")
end

function missionPassed(player)
	earnings1 = math.random(100,999)
	earnings2 = math.random(100,999)
	addEventHandler("onClientRender",root,displayText)
	setTimer(function()
		removeEventHandler("onClientRender",root,displayText)
	end,5000,1)
end
addEvent("onClientPlayerFinish",true)
addEventHandler("onClientPlayerFinish",root,missionPassed)




----- SMOOTH CAMERA FUNCTION --- https://wiki.multitheftauto.com/wiki/SmoothMoveCamera
local sm = {}
sm.moov = 0
sm.object1, sm.object2 = nil, nil
 
function removeCamHandler ()
	if(sm.moov == 1) then
		sm.moov = 0
		removeEventHandler ( "onClientPreRender", getRootElement(), camRender )
	end
end
 
function camRender ()
	local x1, y1, z1 = getElementPosition ( sm.object1 )
	local x2, y2, z2 = getElementPosition ( sm.object2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
end
 
function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	if(sm.moov == 1) then return false end
	sm.object1 = createObject ( 1337, x1, y1, z1 )
	sm.object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( sm.object1, 0 )
	setElementAlpha ( sm.object2, 0 )
	setObjectScale(sm.object1, 0.01)
	setObjectScale(sm.object2, 0.01)
	moveObject ( sm.object1, time, x2, y2, z2, 0, 0, 0, "InOutQuad" )
	moveObject ( sm.object2, time, x2t, y2t, z2t, 0, 0, 0, "InOutQuad" )
 
	addEventHandler ( "onClientPreRender", getRootElement(), camRender )
	sm.moov = 1
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, sm.object1 )
	setTimer ( destroyElement, time, 1, sm.object2 )
	return true
end
---------------------------------------------------------------------