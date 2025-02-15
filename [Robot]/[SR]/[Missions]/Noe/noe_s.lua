function hideMarker()
	triggerClientEvent("PlayerLoadedIn", resourceRoot)
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), hideMarker)

function StartDialogue(newState, oldState)
	if newState == "Running" and oldState == "GridCountdown" then
		triggerClientEvent (source, "PlayStartDialogue", getRootElement())
	end
end
addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", root, StartDialogue)

function CheckHeightServer(player)
	plane = getPedOccupiedVehicle(client)
	local xO,yO,zO = getElementPosition(plane)
	if ((zO > 60 and xO >= -1700) or (zO > 85 and xO <= -1700)) then
		triggerClientEvent(client, "PlayerAboveLimit", resourceRoot)
	else
		triggerClientEvent(client, "NotAboveLimit", resourceRoot)
	end
end
addEvent("HeightCheck", true)
addEventHandler("HeightCheck", getRootElement(), CheckHeightServer)

function SlowDownPlane()
	plane = getPedOccupiedVehicle(client)
	planeSpeed = getElementSpeed(plane, 2)
	if (planeSpeed > 100) then
		setElementSpeed(plane, 1, 100)
	end
end
addEvent("ReduceHandling", true)
addEventHandler("ReduceHandling", getRootElement(), SlowDownPlane)

function DeliveryComplete(checkpoint)
	if checkpoint == 1 then
		triggerClientEvent(source, "PlayerOnLastSection", getRootElement())
	end
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", root, DeliveryComplete)

function IsPlayerInBounds()
	plane = getPedOccupiedVehicle(client)
	local xO,yO,zO = getElementPosition(plane)
	local qO,rO,sO = getElementVelocity(plane)
	if ((xO > -76.4228 and xO < 433.6483) and (yO > 2478.64 and yO < 2525.658) and (zO > 14.2844 and zO < 18.6279)) then
		setElementPosition(plane, 178.61275, 2502.149, -50.4228)
		setElementPosition(plane, xO, yO, zO)
		setElementVelocity(plane, qO, rO, sO)
	end
end
addEvent("CheckLandingPos", true)
addEventHandler("CheckLandingPos", getRootElement(), IsPlayerInBounds)

function FinishDialogue()
	triggerClientEvent(source, "PlayEndDialogue", getRootElement())
end
addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish", root, FinishDialogue)

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function setElementSpeed(element, unit, speed)
    local unit    = unit or 0
    local speed   = tonumber(speed) or 0
	local acSpeed = getElementSpeed(element, unit)
	if acSpeed and acSpeed~=0 then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		if diff ~= diff then return false end -- if the number is a 'NaN' return false.
        	local x, y, z = getElementVelocity(element)
		return setElementVelocity(element, x*diff, y*diff, z*diff)
	end
	return false
end