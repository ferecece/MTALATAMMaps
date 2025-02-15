-- Car.Health(34@) = 3000

-- 023C: load_special_actor 'TRUTH' as 2 // models 290-299
-- 93@ = Actor.Create(CivMale, #SPECIAL02, -2031.252, 164.0169, 27.8429)
-- Actor.Angle(93@) = 180.0

-- Jethro fixin' tow truck
-- 94@(134@,4i) = Actor.Create(CivMale, #SPECIAL03, 72@(134@,5f), 77@(134@,5f), 82@(134@,5f))
-- Actor.Angle(94@(134@,4i)) = 228.0
-- 0812: AS_actor 94@(134@,4i) perform_animation "FIXN_CAR_LOOP" IFP "CAR" framedelta 4.0 loopA 1 lockX 0 lockY 0 lockF 1 time 0 // versionB 

-- 03E5: show_text_box 'GAR1_23'  // Press ~k~~VEHICLE_HORN~ to sound car horn.

-- Towtruck bit :GARAG1_18536
-- Hotdog bit :GARAG1_18974
-- Zero bit :GARAG1_19464

-- Spawning Hotdog at end :GARAG1_19953

-- Towtruck marker bit :GARAG1_20131
-- Hospital marker :GARAG1_20515
-- Police marker :GARAG1_20612
-- Final marker :GARAG1_20709

-- Start-ish of mission :GARAG1_5423

-- Variables :GARAG1_268
-- 105, 106 state checks

-- angle > 90 and 270 > angle set to 180.0 otherwise 0.0
-- police station angle > 0.0 and 180.0 > angle set to 90.0 otherwise 270.0
-- zero angle check is angle > 90.0 and 270.0 > angle set to 180.0 otherwise 0.0

-- 
local Checkpoint = {}
local Marker = {}
local Vehicle

local checkX, checkY, checkZ
local markerX, markerY, markerZ

local Progress = 0

function checkForMovement()
	if not isElementMoving(getPedOccupiedVehicle ( getLocalPlayer()) ) then
		setTimer(checkForMovement, 500, 1)
	else
		for i=1, 6 do
			Checkpoint[i] = getElementByID("Checkpoint" .. tostring(i))
			Marker[i] = getElementByID("Marker" .. tostring(i))
		end
		setTimer(update, 100, 1)
	end
end

function update()
	Vehicle = getPedOccupiedVehicle(getLocalPlayer())
	honk = false

	if Vehicle == false then
		setTimer(update, 100, 1)
		return
	end

	local playerX, playerY, playerZ = getElementPosition(Vehicle)
	local rotX, rotY, rotZ = getElementRotation(Vehicle)

	Progress = getElementData(getLocalPlayer(), "race.checkpoint")

	markerX, markerY, markerZ = getElementPosition(Marker[Progress])

	if isElementWithinMarker(Vehicle, Marker[Progress]) then
		checkX, checkY, checkZ = getElementPosition(Checkpoint[Progress])

		if Progress == 1 and getPedControlState(getLocalPlayer(), "horn") 
			and not isElementMoving(Vehicle) then
			HitCheckpointAndRotate(80)
		elseif Progress == 2 then
			if rotZ >= 0 and rotZ < 180 then
				HitCheckpointAndRotate(90)
			else
				HitCheckpointAndRotate(270)
			end
		elseif Progress == 3 and getPedControlState(getLocalPlayer(), "horn") 
			and not isElementMoving(Vehicle) then
			if rotZ >= 90 and rotZ < 270 then
				HitCheckpointAndRotate(180)
			else
				HitCheckpointAndRotate(0)
			end
		elseif Progress == 4 then
			if rotZ >= 0 and rotZ < 180 then
				HitCheckpointAndRotate(90)
			else
				HitCheckpointAndRotate(270)
			end
		elseif Progress == 5 and getPedControlState(getLocalPlayer(), "horn") 
			and not isElementMoving(Vehicle) then
			if rotZ >= 90 and rotZ < 270 then
				HitCheckpointAndRotate(180)
			else
				HitCheckpointAndRotate(0)
			end
		elseif Progress == 6 then
			-- If it's not rotated right, don't do anything
			if rotZ >= 0 and rotZ < 180 then
				HitCheckpointAndRotate(90)
			end
		elseif Progress % 2 == 1 then
			honk = true
		end
	end

	--outputChatBox(tostring(rotZ))
	for i=1, 6 do
		if i ~= (Progress) then
			setElementDimension(Marker[i], 2)
		else
			setElementDimension(Marker[i], 0)
		end
	end

	setTimer(update, 100, 1)
end

function HitCheckpointAndRotate(rotation)
	setElementPosition(Vehicle, checkX, checkY, checkZ)

	setElementPosition(Vehicle, markerX, markerY, markerZ)
	setElementRotation(Vehicle, 0, 0, rotation)
	setElementVelocity(Vehicle, 0, 0, 0)
	setElementAngularVelocity(Vehicle, 0, 0, 0)
end

function ClientStart()
	setTimer(checkForMovement, 500, 1)

	getDistanceBetweenPoints3D(clientPositionX, clientPositionY,
					clientPositionZ, otherPlayerPositionX, otherPlayerPositionY, otherPlayerPositionZ)
end
addEventHandler("onClientResourceStart",root,ClientStart)

function isElementMoving(theElement)
    if isElement(theElement)then --First check if the given argument is an element
        local x, y, z = getElementVelocity(theElement) --Get the velocity of the element given in our argument
            return x ~= 0 or y ~= 0 or z ~= 0 --When there is a movement on X, Y or Z return true because our element is moving
    end
    return false
end

function drawing()	
	if honk then
		dxDrawText ("USE HORN", 250, 250, 1000, 1000, tocolor ( 255, 50, 50, 255 ), 1.5, "pricedown")
	end
end
addEventHandler ("onClientRender", root, drawing)