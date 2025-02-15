g_PatientStates = {}
g_OpenSeats = g_MAX_PATIENTS_IN_VEHICLE
g_SpeedCheckState = nil -- we can only pick up once or drop off at a time

function getNewPatients()
	local level = getElementData(localPlayer, "race.checkpoint") or 1 -- relying on base race impl
	g_PatientStates = {}

	local range = #g_PATIENT_PICKUP_POSITIONS
	local maxPatients = g_PATIENTS_FOR_LEVEL(level)
	local numPatients = 0

	while numPatients < maxPatients do
		local rand = math.random(range)
		if g_PatientStates[rand] == nil then
			g_PatientStates[rand] = false
			triggerEvent(g_SHOW_PATIENT_EVENT, localPlayer, rand)
			numPatients = numPatients + 1
		end
	end
end

function triggerSpeedCheck(onSuccessFn)
	if g_SpeedCheckState then
		removeSpeedCheck()
	end

	g_SpeedCheckState = setTimer(function()
		local x, y, z = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		local completeVelocity = x * x + y * y + z * z
		if completeVelocity < g_PICKUP_SPEED_LIMIT then
			triggerEvent(g_SUCCEED_SPEEDCHECK_EVENT, localPlayer)
			removeSpeedCheck()
			onSuccessFn()
			return
		end
		triggerEvent(g_FAIL_SPEEDCHECK_EVENT, localPlayer)
	end, g_SPEED_CHECK_INTERVAL, 0)

	triggerEvent(g_START_SPEEDCHECK_EVENT, localPlayer, g_SpeedCheckState)
end

function removeSpeedCheck()
	if not g_SpeedCheckState then return end

	killTimer(g_SpeedCheckState)
	g_SpeedCheckState = nil

	triggerEvent(g_EXIT_SPEEDCHECK_EVENT, localPlayer)
end

function isPlayerVehicle(element)
	return getElementType(element) == "vehicle" and
		getPedOccupiedVehicle(localPlayer) == element
end

function validCollision(id, element)
	return isPlayerVehicle(element) and
		g_PatientStates[id] == false
end

function initializeHospital(id)
	local hospital = g_HOSPITAL_POSITIONS[id]

	triggerEvent(g_SHOW_HOSPITAL_EVENT, localPlayer, id, hospital)

	local col = createColCircle(getElementData(hospital, "posX"), getElementData(hospital, "posY"), g_HOSPITAL_MARKER_SIZE)
	addEventHandler("onClientColShapeHit", col, function(element)
		if not isPlayerVehicle(element) then return end
		if g_OpenSeats == g_MAX_PATIENTS_IN_VEHICLE then return end

		triggerSpeedCheck(function()
			triggerEvent(g_PATIENTS_DROPPED_OFF_EVENT, localPlayer, g_MAX_PATIENTS_IN_VEHICLE - g_OpenSeats)
			g_OpenSeats = g_MAX_PATIENTS_IN_VEHICLE

			for id, p in pairs(g_PatientStates) do
				if p == false then return end
			end

			triggerEvent("onClientCall_race", root, "checkpointReached", element)

			local level = getElementData(localPlayer, "race.checkpoint") or 1
			if level <= g_NUM_LEVELS then
				getNewPatients()
			end
		end)
	end)

	addEventHandler("onClientColShapeLeave", col, function(element)
		if not isPlayerVehicle(element) then return end
		removeSpeedCheck()
	end)
end

function initializePatient(id)
	local patient = g_PATIENT_PICKUP_POSITIONS[id]
	local col = createColCircle(getElementData(patient, "posX"), getElementData(patient, "posY"), g_PATIENT_PICKUP_MARKER_SIZE)

	addEventHandler("onClientColShapeHit", col, function(element)
		if not validCollision(id, element) then return end
		if g_OpenSeats == 0 then
			triggerEvent(g_AMBULANCE_FULL_EVENT, localPlayer, true)
			return
		end

		triggerSpeedCheck(function()
			g_PatientStates[id] = true

			triggerEvent(g_PATIENT_PICKED_UP, localPlayer, id)
			triggerEvent(g_HIDE_PATIENT_EVENT, localPlayer, id)

			g_OpenSeats = math.max(g_OpenSeats - 1, 0)
			if g_OpenSeats == 0 then
				triggerEvent(g_AMBULANCE_FULL_EVENT, localPlayer, false)
			end
		end)
	end)

	addEventHandler("onClientColShapeLeave", col, function(element)
		if not validCollision(id, element) then return end
		removeSpeedCheck()
	end)
end

function resetPickups()
	g_OpenSeats = g_MAX_PATIENTS_IN_VEHICLE
	-- dying several times in a row w/o hitting a checkpoint puts you back without
	-- resetting patients so you'll have to pick up level + 1 patients for level
	for id in pairs(g_PatientStates) do
		g_PatientStates[id] = false
		triggerEvent(g_SHOW_PATIENT_EVENT, localPlayer, id)
	end
end

addEvent(g_CLIENT_SPECTATORED_EVENT, true)
addEventHandler(g_CLIENT_SPECTATORED_EVENT, localPlayer, resetPickups)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for id = 1, #g_HOSPITAL_POSITIONS do
		initializeHospital(id)
	end

	for id = 1, #g_PATIENT_PICKUP_POSITIONS do
		initializePatient(id)
	end

	getNewPatients()
end)

addEventHandler("onClientPlayerWasted", localPlayer, resetPickups)

addEventHandler("onClientExplosion", root, function(x, y, z, t)
	if t == 4 then
		cancelEvent()
	end
end)