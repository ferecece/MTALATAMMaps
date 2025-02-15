-- Space Invaders client script by Ali Digitali
-- Anyone reading this has permission to modify/copy parts of this script (as long as you don't take credit for it

-- Things handled in this script:
-- - Barriers
-- - Load ufo textures
-- - Cutscenes and camera changes
-- - Turret & missiles
-- - UFO kills and triggers


addEventHandler('onClientResourceStart', resourceRoot, function()	-- load the custom UFO texture on the sparrow
	reloadafterdownload()
	setAircraftMaxHeight(30)
	bindonce = true
	marker10 = true
	barrier1 = createObject(972, 327.2,2529.9,10.9,0,0,90)
	barrier2 = createObject(972, 327.2,2550.1,10.9,0,0,90)
	barrier3 = createObject(8838,-757,2056.6,61.4,270,180,104)
	barrier4 = createObject(975,-1061.7,2171.5,87.8,0,0,191.5)
	mothership = createObject(1305,-961.8,2200.7,103.3)
	setObjectScale(mothership,15)
	engineSetModelLODDistance(1305,300)
	setElementCollisionsEnabled(mothership,false)
	
	if not (getElementData(root,"racestate") == "Running") then -- if not running already, set the camera to the ufo landing site (cutscene)
		addEventHandler ( "onClientRender", root, cutscene )
	end
	
	--engineSetModelLODDistance(469,400)
	
	missilecounter = 4
	setTimer(function()
		if missilecounter < 4 then
			missilecounter = missilecounter + 1 -- set timer for a missile every second with a cap of 4
		end
	end,1000,0)
end 
)

function cutscene()
	setCameraMatrix(0,2500,40,40,2500,36)
end

function retargetcamera() -- make the camera follow the player again when the map starts
	removeEventHandler ( "onClientRender", root, cutscene )
	setCameraTarget(localPlayer)
	--addEventHandler ("onClientRender", root, displayufocounter )
end
addEvent ( "retargetcamera", true )
addEventHandler ("retargetcamera", getRootElement(),retargetcamera )

firstFadeIn = true
function fadeIn() -- trigger the UFOs on the first fade in
	if (firstFadeIn == true) then
		firstFadeIn = false
		spawnUfoWave1()	
		setTimer(function() -- spawn the ufo's that are comming down at the start
			spawnUfoWave1()		
		end,2000,4)
	end
end
addEvent ( "onClientScreenFadedIn", true )
addEventHandler ("onClientScreenFadedIn", getRootElement(),fadeIn )

function spawnUfoWave1() -- spawn the actual UFOs
	local randomx = math.random(0,100)
	local randomy = math.random(-50,50)
	local thevehicle = createVehicle(469,40+randomx,2500+randomy,80)
	setElementData ( thevehicle, 'race.collideothers', 1 )
	setVehicleRotorSpeed (thevehicle,0.2)
	local theped= createPed (288,40+randomx,2500+randomy,60)
	warpPedIntoVehicle ( theped, thevehicle)
	setPedControlState(theped,"accelerate",true)
end

function reloadafterdownload() -- not sure if it needs to be done like this, because it might take some time to download the textures
	txd = engineLoadTXD ( "sparrow.txd" )
	dff = engineLoadDFF ( "sparrow.dff", 469 )
	if txd and dff then
		engineImportTXD ( txd, 469 )
		engineReplaceModel ( dff, 469 )
		engineImportTXD ( txd, 1305 )
		engineReplaceModel ( dff, 1305 )
	else
		setTimer(function()
			reloadafterdownload()
		end,1000,1)
	end
end

function respawnLauncher() -- respawn the launcher on top of the vehicle when you enter one (because it can explode and not be visible when you respawn)
	if launcher then
		respawnObject(launcher)
	end
end
addEventHandler("onClientVehicleEnter", root, respawnLauncher)

function funcInput ( key, keyState ) -- fires missiles
  if ( keyState == "down" ) then
	if (missilecounter > 0) then
		local veh = getPedOccupiedVehicle(localPlayer)
		local x,y,z = getPositionFromElementOffset(veh,0,-0.5,2)
		local velx,vely,velz = getElementVelocity(veh)
		local _,_,rotz = getElementRotation(veh)
		
		-- check the line of sight, if a ufo is hit, make the projectile focus the ufo, else make it focus the target
		local tx, ty, tz = x,y,z
		local px, py, pz = getElementPosition(target)
		local hit, hitx, hity, hitz, elementHit = processLineOfSight (tx, ty, tz,px+firex*100, py+firey*100, pz+firez*70,true,true,false,true,false,false,false,true,launcher)
		local missileTarget
		if elementHit then
			local obj = createObject(1337,hitx,hity,hitz) -- create dummy object, else the rocket will not collide with something to explode
			setElementAlpha(obj,0)
			attachElements(obj,elementHit)
			missileTarget = elementHit
			--outputChatBox("ufo")
		else
			missileTarget = target
			--outputChatBox("miss")
		end
		
		local projectile = createProjectile(getPedOccupiedVehicle(localPlayer),20,x,y,z,200,missileTarget,33,0,angle-rotz,firex+velx,firey+vely,0.3+velz) -- create the missile with compensation for vehicle speed and SAM facing angle
		missilecounter = missilecounter - 1
	end
  end
end

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

function rotateTurret () -- function to set SAM rotation and calculate missile target position
	if (getPedOccupiedVehicle(localPlayer)) and launcher and target then
		local x, y, z, lx, ly, lz = getCameraMatrix()
		local rotx,roty,rotz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		firex = lx-x
		firey = ly-y
		firez = lz-z
		
		if ((ly-y) < 0 ) and ((lx-x) < 0 ) then
			angle = math.deg(math.atan((ly-y)/(lx-x)))+90
		elseif ((lx-x) < 0 ) then
			angle = 90 - math.deg(math.atan(-(ly-y)/(lx-x)))
		elseif ((ly-y) < 0 ) then
			angle = 90 - math.deg(math.atan(-(ly-y)/(lx-x)))+180
		else 
			angle = math.deg(math.atan((ly-y)/(lx-x)))-90
		end
		setElementAttachedOffsets(launcher,0,-0.5,0.8,0,0,-rotz+angle) -- update the SAM attachment according to the calculated angle
		
		local locx,locy,locz = getElementPosition(getPedOccupiedVehicle(localPlayer))
		if (firez < -0.3) then firez = -0.3 end -- adjust the z look at height so aim is proper
		firez = firez+0.4
		setElementPosition(target,locx+firex*90,locy+firey*90,locz+2+firez*63) --update the target location where the missiles are aimed at
		setElementRotation(target,0,0,angle)
		
		-- debug, draws a line the missile will follow
		-- local x1, y1, z1 = getElementPosition(launcher)--getPositionFromElementOffset(getPedOccupiedVehicle(localPlayer),0,-0.5,0)            
		-- local x2, y2, z2 = locx+firex*100,locy+firey*100,locz+2+firez*70
		-- dxDrawLine3D (x1,y1-0.5, z1+2, x2, y2, z2, tocolor ( 0, 255, 0, 230 ), 2)
	end
end

ufocounter = 0
setElementData(localPlayer,"score",ufocounter,true)
function updateUFOcounter()
	ufocounter = ufocounter + 1
	setElementData(localPlayer,"score",ufocounter,true)
	if (ufocounter == 15) then
		destroyElement(barrier1)
		destroyElement(barrier2)
	end
	if (ufocounter == 40) then
		destroyElement(barrier3)
	end
end

-- screenWidth, screenHeight = guiGetScreenSize ( )
-- function displayufocounter()
-- dxDrawText ("UFO's destroyed:      " .. ufocounter, screenWidth,40,0,0, tocolor ( 0, 255, 0, 255 ), 2,"default","center")
-- end

wait = true
function ClientExplosionFunction(a,b,c,theType)
	cancelEvent()
	if (theType == 3) and (source == localPlayer) then -- only if the local player fired a missile it will do damage
		createExplosion(a,b,c,2,true,-1.0,true)
	elseif (theType == 3) then
		createExplosion(a,b,c,2,true,-1.0,false)
	end
	
	if (theType == 3) and (wait == true) and (source == localPlayer) then
		
		local newcolshape = createColSphere(a,b,c,15)
		setTimer(function() -- use timer to make sure the ufo has moved a bit from the explosion, else it will not find ufos in the colsphere (due to legacy issues)
			local vehicles = getElementsWithinColShape (newcolshape,"vehicle")
			for index, theVehicle in ipairs (vehicles) do
				if (getElementModel(theVehicle) == 469) then
					wait = false
					for index,theElement in ipairs (getAttachedElements(theVehicle)) do
						if getElementModel(theElement) == 1337 then
							destroyElement(theElement) -- destroy dummy objects attached from missile targeting
						end
					end
					
					if getVehicleOccupant(theVehicle) then
						destroyElement(getVehicleOccupant(theVehicle)) --destroy driver
					end
					local x,y,z = getElementPosition(theVehicle)
					blowVehicle(theVehicle) -- blow the vehicle
					local tempveh1 = theVehicle
					local tempveh2 = createVehicle(469,x,y,z)
					setTimer(function()
						if tempveh1 and tempveh2 then
							destroyElement(tempveh1)
							destroyElement(tempveh2)
						end
					end,3000,1)
					updateUFOcounter()
				end
			end
			destroyElement(newcolshape)
		end,50,1)
		
		setTimer(function()
			wait = true
		end,1000,1)
	end
end
addEventHandler("onClientExplosion",getRootElement(),ClientExplosionFunction)

function markertriggers(markercounter)
	if (markercounter == 1) and (bindonce == true) then
		bindonce = false
		
		local veh = getPedOccupiedVehicle(localPlayer)
		local x,y,z = getElementPosition(veh)
		launcher = createObject(3267,x,y,z+10) --create the SAM launcher on top of the car
		setElementCollisionsEnabled(launcher,false)
		setObjectBreakable(launcher,false)
		setObjectScale(launcher,0.5)
		attachElements(launcher,veh,0,-0.5,0.8,0,0,0) -- attach the SAM to the car
		
		target = createObject(9525,x,y,z+10) -- create the green goo target the missiles will follow
		setObjectScale(target,0.5)
		setElementAlpha(target,150)
		setElementCollisionsEnabled(target,false)
		addEventHandler ("onClientRender", root, rotateTurret ) -- function to update the launcher to face the position the player is looking at
		
		bindKey ( "vehicle_fire", "down", funcInput ) -- bind this function to the fire button to shoot missiles
		
		setTimer( function() -- spawn the second UFO wave
			local randomx = math.random(0,400)
			local randomy = math.random(-50,50)
			local thevehicle = createVehicle(469,40+randomx,2500+randomy,60)
			setElementData ( thevehicle, 'race.collideothers', 1 )
			setVehicleRotorSpeed (thevehicle,0.2)
			local theped= createPed (288,40+randomx,2500+randomy,60)
			warpPedIntoVehicle ( theped, thevehicle)
			setPedControlState(theped,"accelerate",true)
		end,50,15)
	end
	
	if (markercounter == 2) then
		for index, thePed in ipairs (getElementsByType("ped")) do
			local veh = getPedOccupiedVehicle(thePed)
			if veh then
				if getElementModel(veh) == 432 then
					setTimer(function()
						setPedControlState(thePed,"vehicle_fire",true)
						setTimer(function()
							setPedControlState(thePed,"vehicle_fire",false)
						end,1000,1)
					end,3000,0)
				end
			end
		end
	end
	
	if (markercounter == 10) and (marker10 == true) then
		marker10 = false
		dxDraw3DText("", 325.1, 2543.3, 30,10,"default",255,89,29,200,15) -- draw the number in the checkpoint
		addEventHandler("onClientRender",root,draw3D) 
	end
	
	if (markercounter == 12) then -- spawn the third UFO wave
		setTimer( function()
			local randomx = math.random(-800,800)
			local randomy = math.random(-400,400)
			local thevehicle = createVehicle(469,-384.6+randomx,2236.1+randomy,60)
			setElementData ( thevehicle, 'race.collideothers', 1 )
			setVehicleRotorSpeed (thevehicle,0.2)
			local theped= createPed (288,-384.6+randomx,2236.1+randomy,60)
			warpPedIntoVehicle ( theped, thevehicle)
			setPedControlState(theped,"accelerate",true)
		end,50,500)
	end
	
	if (markercounter == 18) then
		setAircraftMaxHeight(55)
	end
	
	if (markercounter == 21) then
		setAircraftMaxHeight(70)
	end
	
	if (markercounter == 21) then
		dxDraw3DText("", -773.2,2051.2, 65,10,"default",255,89,29,200,40) -- draw the number in the checkpoint
	end
	
	if (markercounter == 28) then
		hit = 0
		addEventHandler("onClientExplosion",getRootElement(),ClientExplosionMothershipFunction)
	end
	
	if (markercounter == 30) then
		removeEventHandler("onClientRender",root,draw3D) 
		unbindKey ( "vehicle_fire", "down", funcInput )
		removeEventHandler("onClientRender", root, rotateTurret )
		
		setElementPosition(getPedOccupiedVehicle(localPlayer),-1073.8,2225.1,400)
		local cameraX,cameraY,cameraZ,targetX,targetY,targetZ,roll,fov = getCameraMatrix ( )
		smoothMoveCamera(cameraX,cameraY,cameraZ,targetX,targetY,targetZ,-1072,2231.2,100,-1059.9,2226.1,95.4,1000)
		setTimer(function()
			for index,theVehicle in ipairs (getElementsByType("vehicle",root,true)) do
				if (getElementModel(theVehicle) == 469) then
					destroyElement(getVehicleOccupant(theVehicle))
					local x,y,z = getElementPosition(theVehicle)
					blowVehicle(theVehicle)
					createVehicle(469,x,y,z)
				end
			end
		end,1000,1)
		
		setTimer(function()
			setElementPosition(getPedOccupiedVehicle(localPlayer),-1073.8,2225.1,220)
		end,1500,1)
	end
end
addEvent("markertriggers",true)
addEventHandler ( "markertriggers", getRootElement(), markertriggers )

function ClientExplosionMothershipFunction(a,b,c,theType) -- explode the mothership after 10 hits and remove barrier4
	if (theType == 3)  and  (getDistanceBetweenPoints3D(a,b,c,-961.8,2200.7,103.3) < 50) and (source == localPlayer) then
		hit = hit + 1
		setTimer(function()
			createExplosion(-961.8+math.random(-50,50),2200.7+math.random(-50,50),103.3+math.random(-50,50),10)
		end,100,5)
	end
	
	if (hit == 10) then
		removeEventHandler("onClientExplosion",getRootElement(),ClientExplosionMothershipFunction)
		setElementCollisionsEnabled(mothership,true)
		createExplosion(-961.8,2200.7,103.3,10)
		setTimer(function()
			local x,y,z = getElementPosition(mothership)
			createExplosion(x,y,z+10,10)
		end,250,10)	
		destroyElement(barrier4)
	end
end

--------------------------
-- The following functions are modified from the mta wiki, and are not made by me


local fonts = { [ "default" ] = true, [ "default-bold" ] = true,[ "clear" ] = true,[ "arial" ] = true,[ "sans" ] = true,
	  [ "pricedown" ] = true, [ "bankgothic" ] = true,[ "diploma" ] = true,[ "beckett" ] = true
};

function dxDraw3DText( text, x, y, z, scale, font, r, g, b, maxDistance,ufo )
	-- checking required arguments
	assert( type( text ) == "string", "Bad argument @ dxDraw3DText" );
	assert( type( x ) == "number", "Bad argument @ dxDraw3DText" );
	assert( type( y ) == "number", "Bad argument @ dxDraw3DText" );
	assert( type( z ) == "number", "Bad argument @ dxDraw3DText" );
	-- checking optional arguments
	if not scale or type( scale ) ~= "number" or scale <= 0 then
		scale = 2
	end
	if not font or type( font ) ~= "string" or not fonts[ font ] then
		font = "default"
	end
	if not r or type( r ) ~= "number" or r < 0 or r > 255 then
		r = 255
	end
	if not g or type( g ) ~= "number" or g < 0 or g > 255 then
		g = 255
	end
	if not b or type( b ) ~= "number" or b < 0 or b > 255 then
		b = 255
	end
	if not maxDistance or type( maxDistance ) ~= "number" or maxDistance <= 1 then
		maxDistance = 12
	end
	if not ufo or type( ufo ) ~= "number" then
		ufo = 15
	end
	local textElement = createElement( "text" );
	-- checking if the element was created
	if textElement then 
		-- setting the element datas
		setElementData( textElement, "text", text );
		setElementData( textElement, "x", x );
		setElementData( textElement, "y", y );
		setElementData( textElement, "z", z );
		setElementData( textElement, "scale", scale );
		setElementData( textElement, "font", font );
		setElementData( textElement, "rgba", { r, g, b, 255 } );
		setElementData( textElement, "maxDistance", maxDistance );
		setElementData( textElement, "ufo", ufo );
		-- returning the text element
		return textElement
	end
	-- returning false in case of errors
	return false
end

function draw3D( )
		local texts = getElementsByType( "text" );
		if #texts > 0 then
			local pX, pY, pZ = getElementPosition( localPlayer );
			for i = 1, #texts do
				--local text = tonumber(getElementData( texts[i], "text" ));
				local ufo = getElementData( texts[i], "ufo" );
				local text = ufo - ufocounter
				if (ufocounter > (ufo-1)) then
					text = "" 
				end
				local tX, tY, tZ = getElementData( texts[i], "x" ), getElementData( texts[i], "y" ), getElementData( texts[i], "z" );
				local font = getElementData( texts[i], "font" );
				local scale = getElementData( texts[i], "scale" );
				local color = getElementData( texts[i], "rgba" );
				local maxDistance = getElementData( texts[i], "maxDistance" );
				if not text or not tX or not tY or not tZ then
					return
				end
				if not font then font = "default" end
				if not scale then scale = 2 end
				if not color or type( color ) ~= "table" then
					color = { 255, 255, 255, 255 };
				end
				if not maxDistance then maxDistance = 12 end
				local distance = getDistanceBetweenPoints3D( pX, pY, pZ, tX, tY, tZ );
				if distance <= maxDistance then
					local x, y = getScreenFromWorldPosition( tX, tY, tZ );
					if x and y then
						dxDrawText( text, x, y, _, _, tocolor( color[1], color[2], color[3], color[4] ), scale, font, "center", "center" );
					end
				end
			end
		end
end


-----------------------

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