local ramps, garages, wall, wall2, circle
local totalAlivePlayer = 64

local state = 1
-- 1 - garages up, 	 circle - up,   - ramps - up, wall - down
-- 2 - garages down, circle - up,   - ramps - up,   wall - up
-- 3 - garages up,   circle - up,   - ramps - down, wall - down
-- 4 - garages up,   circle - down, - ramps - down, wall - down
local timings     = {3000, 10000, 5500, 8000}
local currentTime = 0

local downPosZ = -14
local upPosZ   = 12

local wallRotSpeed = 10
local wallDirection = 1

function update()
	currentTime = currentTime + 500
	-- if time for given state is not elapsed => update objects
	if currentTime < timings[state] then
		-- if state == 1 then
		-- end
		if state == 2 then
			local origX, origY, origZ = getElementPosition(wall)
			local orirX, orirY, orirZ = getElementRotation(wall)
			
			moveObject(wall, 500, origX, origY, origZ, orirX, orirY, wallDirection * wallRotSpeed)
			
			local origX, origY, origZ = getElementPosition(wall2)
			local orirX, orirY, orirZ = getElementRotation(wall2)
			
			moveObject(wall2, 500, origX, origY, origZ, orirX, orirY, wallDirection * wallRotSpeed)
		end
		-- if state == 3 then
		-- end
		-- if state == 4 then
		-- end
	else
	-- state changed
		currentTime = 0
		state = state + 1
		if state > 4 then
			state = 1
		end
		
		if state == 1 then
			local origX, origY, origZ = getElementPosition(circle)
			moveObject(circle, 1000, origX, origY, upPosZ) --move the object to this position in 1 seconds.
			local origX, origY, origZ = getElementPosition(ramps)
			moveObject(ramps, 1000, origX, origY, upPosZ)
			triggerClentsWithState(true)
		end if state == 2 then
			local origX, origY, origZ = getElementPosition(garages)
			moveObject(garages, 1000, origX, origY, downPosZ)
			local origX, origY, origZ = getElementPosition(wall)
			moveObject(wall, 450, origX, origY, upPosZ)
			if totalAlivePlayer <= 12 then
				local origX, origY, origZ = getElementPosition(wall2)
				moveObject(wall2, 450, origX, origY, upPosZ)
			end
			timings[2] = math.random(8000, 25000)
			-- change the direction of wall rotating
			if math.random(0, 100) > 50 then
				wallDirection = 1;
			else
				wallDirection = -1;
			end
		end if state == 3 then
			removeSpareGarages()
			moveMyObjectsInState3()
			timings[3] = 5000 + 110 * (64 - totalAlivePlayer)
			triggerClentsWithState(false)
		end if state == 4 then
			local origX, origY, origZ = getElementPosition(circle)
			moveObject(circle, 1000, origX, origY, downPosZ)
		end
		-- outputChatBox("state" .. state)
	end
end

function triggerClentsWithState(newState)
	for i,player in pairs(getAlivePlayers()) do
		triggerClientEvent("seChangeNoteState", player, newState)
	end
	for i,player in pairs(getDeadPlayers()) do
		triggerClientEvent("seChangeNoteState", player, newState)
	end
end

function removeSpareGarages()
	totalAlivePlayer = getAliveRacers()
	totalGaragesLeft = #getAttachedElements(garages)
	
	for i,children in pairs(shuffleTable(getAttachedElements(garages))) do
		if (totalAlivePlayer - 1) < totalGaragesLeft then
			destroyElement(children)
			totalGaragesLeft = totalGaragesLeft - 1
		end
	end
end

function getAliveRacers() 
    local count = 0 
    for i, v in ipairs(getElementsByType('player')) do 
        if getElementData(v, 'state') == 'alive' then 
            count = count + 1 
        end 
    end 
    return count 
end

function moveMyObjectsInState3()
	local origX, origY, origZ = getElementPosition(garages)
	moveObject(garages, 1000, origX, origY, upPosZ)
	local origX, origY, origZ = getElementPosition(wall)
	moveObject(wall, 1000, origX, origY, downPosZ)
	local origX, origY, origZ = getElementPosition(wall2)
	moveObject(wall2, 1000, origX, origY, downPosZ)
	local origX, origY, origZ = getElementPosition(ramps)
	moveObject(ramps, 1000, origX, origY, downPosZ)
end

function anSetup()
	wallTmp    = getElementByID("object (bollardlight) (1)")
	wallTmp2   = getElementByID("object (bollardlight) (1a)")
	rampsTmp   = getElementByID("object (bollardlight) (2)")
	garagesTmp = getElementByID("object (bollardlight) (3)")
	circleTmp  = getElementByID("object (bollardlight) (4)")
	
	wall    = recursionAttatchment(wallTmp)
	wall2   = recursionAttatchment(wallTmp2)
	ramps   = recursionAttatchment(rampsTmp)
    garages = recursionAttatchment(garagesTmp)
	circle  = recursionAttatchment(circleTmp)
	
	local origX, origY, origZ = getElementPosition(wall)
	local orirX, orirY, orirZ = getElementRotation(wall)
	moveObject(wall2, 0, origX, origY, origZ, orirX, orirY, orirZ + 180)
	
	-- setElementID(wall, 'mmElementWall')
	-- setElementID(ramps, 'mmElementRamps')
	-- setElementID(garages, 'mmElementGarages')
	-- setElementID(circle, 'mmElementCircle')
	
	moveMyObjectsInState3()
	local origX, origY, origZ = getElementPosition(ramps)
	moveObject(ramps, 500, origX, origY, upPosZ)
end

addEventHandler('onResourceStart', resourceRoot, anSetup)
addEvent('onRaceStateChanging')
addEventHandler('onRaceStateChanging', resourceRoot,
function(newState, oldState)
	if newState == "Running" and oldState == "GridCountdown" then
		triggerClentsWithState(true)
		setTimer(function()
			update()
		end, 500, 0)
	end
end
)

-- Helpers
function shuffleTable(tbl)
	math.randomseed(os.time())
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end


function recursionAttatchment(rootObj)
	local garPosX, garPosY, garPosZ = getElementPosition(rootObj)
	local garRotX, garRotY, garRotZ = getElementRotation(rootObj)
    local rootNew = createObject(getElementData(rootObj, 'model'), garPosX, garPosY, garPosZ, garRotX, garRotY, garRotZ)
	
	for i,children in pairs(getElementChildren(rootObj)) do
		if getElementChildrenCount(children) > 0 then
			children = recursionAttatchment(children)
		end
		
		if getElementType(children) == "racepickup" then
			outputChatBox("Can't recreate racepickup :C")
			-- local chiPosX, chiPosY, chiPosZ = getElementPosition(children)
			-- subObject = createObject(chiPosX, chiPosY, chiPosZ, 3, 2222) -- getElementData(children, 'type')
		else
			local chiPosX, chiPosY, chiPosZ = getElementPosition(children)
			local chiRotX, chiRotY, chiRotZ = getElementRotation(children)
			subObject = createObject(getElementData(children, 'model'),chiPosX, chiPosY, chiPosZ, chiRotX, chiRotY, chiRotZ)
		end

        -- Attach so they look like what they do in the map editor
        attachRotationAdjusted(subObject, rootNew)
		destroyElement(children)
	end
	
	destroyElement(rootObj)
	return rootNew
end

function attachRotationAdjusted ( from, to )
    -- Note: Objects being attached to ('to') should have at least two of their rotations set to zero
    --       Objects being attached ('from') should have at least one of their rotations set to zero
    -- Otherwise it will look all funny

    local frPosX, frPosY, frPosZ = getElementPosition( from )
    local frRotX, frRotY, frRotZ = getElementRotation( from )
    local toPosX, toPosY, toPosZ = getElementPosition( to )
    local toRotX, toRotY, toRotZ = getElementRotation( to )
    local offsetPosX = frPosX - toPosX
    local offsetPosY = frPosY - toPosY
    local offsetPosZ = frPosZ - toPosZ
    local offsetRotX = frRotX - toRotX
    local offsetRotY = frRotY - toRotY
    local offsetRotZ = frRotZ - toRotZ

    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )

    attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
end


function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD

    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z

    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z

    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y

    return x, y, z
end
