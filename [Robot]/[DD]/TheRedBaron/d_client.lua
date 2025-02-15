gameSpeed = 2
turnTime = 500
fireRate = 3000
finishTime = 0

function target()
	
end
addEventHandler ( "onClientRender", getRootElement (), target )

function updateCamera ()
	local veh = getPedOccupiedVehicle(localPlayer)
	if 	veh then
		local x, y, z = getElementPosition (veh) -- keep everyone on the same line and set the camera
		if (z>180) and(z<300) then
			z = 180
		end
		setElementPosition(veh,1906,y,z)
		-- check if the player needs to be turned around
		local progress = (finishTime - getTickCount())/turnTime
		if progress > 0 then
			if rotz == 180 then
				sign = -1
			else 
				sign = 1 
			end
		else
			progress = 0
			sign = 0
		end
		local rotx,_,_ = getElementRotation(veh)
		setElementRotation(veh,rotx,0,rotz+sign*progress*180) --keep the rotation or make the player smoothly turn
		--rotx = pitch, roty = roll, rotz = yaw
	end
	
	local a = getCameraTarget() --if the camera target is switched make set the camera matrix to follow that target instead
	if a then
		t = a
	end
	
	if isElement(t) then
		local x,y,z = getElementPosition(t)
		if (z < 10000) then --make sure you cannot spectate players that are moved to 36000 when dead or spectating
			setCameraMatrix (x+30,y,z,x,y,z)
		end
	end
end
addEventHandler ( "onClientPreRender", getRootElement (), updateCamera )

rotz = 0
function funcInput ( key, keyState )
	rotz = (rotz+180)%360
	finishTime = getTickCount() + turnTime
end

function fireRocket(key) --fire rockets
	if justFired then
		return
	end
	
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		unbindKey("vehicle_look_left", "down", fireRocket)
		unbindKey("vehicle_look_right", "down", fireRocket)
		return
	end
	local x,y,z = getElementPosition(veh)                    
	local x2, y2, z2 = getPositionFromElementOffset(veh,0,1,0)
	local a,b,c = getElementVelocity(veh)
	local velx,vely,velz = x2-x+a,y2-y+b,z2-z+c
	
	local bomb
	if (key == "vehicle_look_left") then
		bomb = 19
	else 
		bomb = 21
	end
	local projectile = createProjectile(veh,bomb)--,x,y,z,0,nil,nil,nil,nil,velx/gameSpeed,vely/gameSpeed,velz/gameSpeed)
	if ((finishTime - getTickCount()) < 0) and (bomb == 19) then
		setProjectileCounter(projectile,750)
	end
	
	justFired = true
	setTimer(function()
		justFired = false
	end,fireRate,1)
end

function raceState(dataName,oldValue)
	if (dataName == "racestate") then
		local currentState = getElementData (source, "racestate")
		if (currentState == "Running" and oldValue == "GridCountdown") then
			setGameSpeed(gameSpeed)
			bindKey("handbrake","down",funcInput) --bind the handbrake to turning around
			
			
			for index,thePed in ipairs(getElementsByType("ped"))do
				setElementModel(thePed,math.random(1,312))
				setPedAnimation(thePed,"ON_LOOKERS","wave_loop")
			end
			
			setTimer(function()
				bindKey("vehicle_look_left", "down", fireRocket)
				bindKey("vehicle_look_right", "down", fireRocket)
				playSFX("script", 6, 1, false) -- airhorn sound
			end,11000,1)
		end
	end
end
addEventHandler("onClientElementDataChange", getRootElement(),raceState)


function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end