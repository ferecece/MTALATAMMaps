-- SERVERSIDE
-- Script by Ali Digitali
-- Anyone reading this has permission to copy parts of this script


-- Generating the downwards Ramp
function generalramps(startitem,stopitem,d,e,f,scale,draw)
	start = getElementByID(startitem)
	x,y,z = getElementPosition(start)
	rotx,roty,rotz = getElementRotation(start)

	stop = getElementByID(stopitem)
	a,b,c = getElementPosition(stop)
	rota,rotb,rotc = getElementRotation(stop)

	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/draw
		local xoffset =((scale-i)*(x-a)/scale)/draw
		local yoffset =(i*(b-y)/scale)/draw
		createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)	
	end
end
generalramps("b1","b2",0,-70,0,30,1)
generalramps("b3","b4",0,-70,0,30,1)
generalramps("b5","b6",0,-70,0,30,1)

function createBuildings()
	up1 = createObject(4585,-2626.8000488281,919.2001953125,296.79998779297)
	up2 = createObject(4585,-2586.8979492188,919.2001953125,296.79998779297)
	up3 = createObject(4585,-2626.8000488281,872.2001953125,296.79998779297)
	up4 = createObject(4585,-2586.8000488281,872.2001953125,296.79998779297)
end
createBuildings()

function removeBuildings()
	destroyElement(up1)
	destroyElement(up2)
	destroyElement(up3)
	destroyElement(up4)
end


function start(newstate,oldstate) --function to update the race states
	setElementData(root,"racestate",newstate,true) -- used to synchronise with the client
	currentstate = newstate
	if (newstate == "GridCountdown") then
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		setTimer(function() -- set player gravity to 0 and move the supporting towers down
			for index,thePlayer in ipairs (getElementsByType("player")) do
				setPedGravity(thePlayer,0)
			end
			
			local x,y,z = getElementPosition(up1)
			moveObject(up1,9000,x,y,z-300,0,0,360,"InQuad")
			local x,y,z = getElementPosition(up2)
			moveObject(up2,9000,x,y,z-300,0,0,360,"InQuad")
			local x,y,z = getElementPosition(up3)
			moveObject(up3,9000,x,y,z-300,0,0,360,"InQuad")
			local x,y,z = getElementPosition(up4)
			moveObject(up4,9000,x,y,z-300,0,0,360,"InQuad")
		end,7500,1)
		
		setTimer(function() -- remove buildings and reinstate gravity
			removeBuildings()
			for index,thePlayer in ipairs (getElementsByType("player")) do
				setPedGravity(thePlayer,0.006)
			end
		end,20000,1)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )


-- Remove the wheels when a player enters a vehile (Carpet mod applied to buffalo still shows the wheels)
function enterVehicle ( theVehicle, seat, jacked )
	local upgr = getVehicleUpgradeOnSlot(theVehicle,12)
	removeVehicleUpgrade(theVehicle,upgr)
	-- setTimer(function()
		-- outputChatBox(tostring(setVehicleDamageProof(theVehicle,true)))
		-- --outputChatBox("dmg proof")
	-- end,2000,1)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )

function checkpointcounter(checkpoint,time_)
	triggerClientEvent(source,"markertriggers",source,checkpoint) -- trigger marker triggers clientside
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)
