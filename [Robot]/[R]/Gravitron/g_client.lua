-- Clientside
-- Script by Ali Digitali
-- Anyone reading this has permission to copy parts of this script

setAircraftMaxVelocity (1)
g_markercounter = 0
-- function for the triggers, triggers on checkpoints
function markertriggers(markercounter)
	g_markercounter = markercounter
	
	if (markercounter == 2) then
		setWorldSpecialPropertyEnabled("aircars",true)
	end
	
	if (markercounter == 9) then
		if (upsideDown) then
			upsideDown = false
		else
			upsideDown = true
		end
		local veh = getPedOccupiedVehicle(localPlayer)
		local velx,vely,velz = getElementVelocity(veh)
		local x,y,z = getElementPosition(veh)
		setElementFrozen(veh,true)
		setElementRotation(veh,0,0,335)
		
		local cam1,cam2,cam3 = getPositionFromElementOffset(veh,0,-15,0)
		
		setTimer(function() -- rotate the vehicle and the camera upside down
			local yRot = 0
			setTimer(function()
				yRot = yRot+3.6
				setElementRotation(veh,0,yRot,335)
				setCameraMatrix(cam1,cam2,cam3,x,y,z,-yRot)	
			end,50,50)
		end,1200,1)
		
		setTimer(function() -- unfreeze vehicle
			setVehicleGravity (veh,0,0,1)
			setElementFrozen(veh,false)
			setElementVelocity(veh,velx,vely,velz)
		end,3700,1)
		
		setTimer(function()
			setCameraTarget(localPlayer)
		end,4700,1)
	end
	
	if (markercounter == 12) then
		upsideDown = false
		local veh = getPedOccupiedVehicle(localPlayer)
		local velx,vely,velz = getElementVelocity(veh)
		local x,y,z = getElementPosition(veh)
		setElementFrozen(veh,true)
		setElementRotation(veh,0,180,328)
		
		local cam1,cam2,cam3 = getPositionFromElementOffset(veh,0,-15,0)
		
		setTimer(function() -- rotate the vehicle and the camera upside down
			local yRot = 180
			setTimer(function()
				yRot = yRot+3.6
				setElementRotation(veh,0,yRot,328)
				setCameraMatrix(cam1,cam2,cam3,x,y,z,-yRot)	
			end,50,50)
		end,1200,1)
		
		setTimer(function() -- unfreeze vehicle
			setVehicleGravity (veh,0,0,-1)
			setElementFrozen(veh,false)
			setElementVelocity(veh,velx,vely,velz)
		end,3700,1)
		
		setTimer(function()
			setCameraTarget(localPlayer)
		end,4700,1)
	end
	
	if (markercounter == 16) then
		setAircraftMaxVelocity (10)
	end
end
addEvent("markertriggers",true)
addEventHandler ( "markertriggers", getRootElement(), markertriggers )

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

function rotateVehicle ( )
	
	if (upsideDown) then
		setTimer(function()
			local veh = getPedOccupiedVehicle(localPlayer)
			local rotx,roty,rotz = getElementRotation(veh)
			setElementRotation(veh,rotx,180,rotz)
		end,500,1)
	end
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), rotateVehicle )

once = true
function enterVehicle2 ( theVehicle, seat, jacked )
	if once then
		once = false
		setTimer(function()
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh then
				setVehicleDamageProof(theVehicle,true)
			end
		end,500,0)
	end
end
addEventHandler ( "onClientPlayerVehicleEnter", localPlayer, enterVehicle2 )