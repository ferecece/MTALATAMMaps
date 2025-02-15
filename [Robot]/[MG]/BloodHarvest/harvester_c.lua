local bodyparts = {2908, 2907, 2906, 2906, 2905, 2905} -- Element IDs of body parts that come out of the combine

function collectCheckpoints(target)
    local checkpoint = getElementData(localPlayer, "race.checkpoint")
    if (checkpoint > target) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (isElementFrozen(vehicle)) then return end
    for i=checkpoint, target do
		local raceresource = getResourceFromName("race")
    	local racedynamics = getResourceDynamicElementRoot(raceresource)
		local colshapes = getElementsByType("colshape", racedynamics)
		if (#colshapes == 0) then
			break
		end
		triggerEvent("onClientColShapeHit", colshapes[#colshapes], vehicle)
		--iprint(checkpoint, target, #colshapes, result )
    end
end

setElementData (localPlayer,"Zkills",0,true)
function collision (hitElement,force, bodyPart, x, y, z, nx, ny, nz)
	if (hitElement == nil) then 
		return 
	end	
	if (getElementType(hitElement) == "ped") and (getElementModel(source) == 532) and (getElementAlpha(hitElement) == 255) then
			local x, y, z = getElementPosition(hitElement)
			local x2, y2, z2= getPositionFromElementOffset(source, 0, 5.5, 0)
		if getDistanceBetweenPoints2D(x, y, x2, y2) <= 3.5 then
			setElementAlpha(hitElement,0)
			setElementHealth(hitElement,0)
			setElementData (hitElement, "status", "dead" )
			if (getVehicleOccupant(source) == localPlayer) then
				local zombieCount = getElementData(localPlayer,"Zkills")
				if not(zombieCount) then 
					zombieCount = 1
				else
					zombieCount = zombieCount + 1
				end
				collectCheckpoints(zombieCount)
				setElementData (localPlayer,"Zkills",zombieCount,true)
	
				-- if (zombieCount%10 == 0) then -- drop barrels every 10 zombies killed
				-- 	local x, y, z = getPositionFromElementOffset(source, -1.3, -3, 1.2) -- position of the chute
				-- 	triggerServerEvent ( "dropBarrel", localPlayer, x,y,z ) 
				-- end
			end
			playSFX("script", 152, 2, false) -- blood sound
			fxAddBlood(x, y, z, 0, 0,-.2, 5, 1)
			spawnBodyParts(source)
		end
	end
end
addEventHandler("onClientVehicleCollision", root, collision)

function spawnBodyParts(harvester)
	if harvester then
		local bodies = {}
		local vx, vy, vz = getElementVelocity(harvester)
		
		for index, obj in pairs(bodyparts) do
			setTimer(function()
				local x, y, z = getPositionFromElementOffset(harvester, -1.3, -3, 1.2) -- location of the chute
				local o = createObject(obj, x, y, z)
				setElementRotation(o, math.random(1, 140), math.random(1, 140), math.random(1, 140))
				table.insert(bodies, o)
				if index > 1 then
					setElementCollidableWith(o, bodies[index-1], false)
					setElementCollidableWith(bodies[index-1], o, false)
				end
				setTimer(setElementVelocity, 50, 1, o, -vx, -vy, math.random(0.01, 0.1))
			end, 50*index, 1)
		end
		
		local x, y, z = getPositionFromElementOffset(harvester, -1.3, -3, 1.2)
		fxAddBlood(x, y, z, 0, 0, 0, 5, 1)

		setTimer(function()
			for i, obj in pairs(bodies) do destroyElement(obj) end
		end, 10000, 1)
	end
end

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

function comp(a,b)
	if not getElementData(a,"Zkills") then return false end
	if not getElementData(b,"Zkills") then return true end
	
	if (getElementData(a,"Zkills")) > (getElementData(b,"Zkills")) then
		return true
	else
		return false
	end
end



-- screenx,screeny = guiGetScreenSize()
-- function displayWinners()
-- 	local players = getElementsByType("player")
-- 	table.sort(players,comp)
	
-- 	for i,player in ipairs(players) do
-- 		if (i<11) then
-- 			local score = getElementData(player,"Zkills")
-- 			if not score then return end
-- 			if (score > 0)then
-- 				-- if (i == 0) then
-- 					-- r,g,b = 0,255,0
-- 				-- else
-- 					-- r,g,b = 255,255,255
-- 				-- end
-- 				dxDrawText(i .. ". " .. getPlayerName(player) .. "#FFFFFF     ",screenx*2/3,screeny/4+i*30,screenx*2/3,screeny/4+i*30,tocolor(255,255,255,255),1,"pricedown","left","center",false,false,false,true)
-- 				dxDrawText(score,screenx*2/3+350,screeny/4+i*30,screenx*2/3+350,screeny/4+i*30,tocolor(255,0,0,255),1,"pricedown","center","center",false,false,false,true)
-- 			end
-- 		end
-- 	end
-- end 
-- addEventHandler ("onClientRender",root,displayWinners)
 
 
 
 
 
 
 