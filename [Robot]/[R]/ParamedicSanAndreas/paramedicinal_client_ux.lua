addEvent(g_SHOW_HOSPITAL_EVENT, true)
addEventHandler(g_SHOW_HOSPITAL_EVENT, localPlayer, function(id)
	local hospital = g_HOSPITAL_POSITIONS[id]
	local x = getElementData(hospital, "posX")
	local y = getElementData(hospital, "posY")
	local z = getElementData(hospital, "posZ")
	createMarker(x, y, z - 0.6, "cylinder", g_HOSPITAL_MARKER_SIZE, 254, 0, 0, 73)
	createMarker(x, y, z - 0.6, "cylinder", g_HOSPITAL_MARKER_SIZE + 0.5, 254, 0, 0, 65)
	createMarker(x, y, z - 0.6, "cylinder", g_HOSPITAL_MARKER_SIZE + 1, 254, 0, 0, 51)
	createBlip(x, y, z, 22, 1, 0, 0, 0, 255, 1, 1500)
end)

g_PatientMarkers = {}
addEvent(g_SHOW_PATIENT_EVENT, true)
addEventHandler(g_SHOW_PATIENT_EVENT, localPlayer, function(id)
	if g_PatientMarkers[id] then return end

	local x = getElementData(g_PATIENT_PICKUP_POSITIONS[id], "posX")
	local y = getElementData(g_PATIENT_PICKUP_POSITIONS[id], "posY")
	local z = getElementData(g_PATIENT_PICKUP_POSITIONS[id], "posZ")

	g_PatientMarkers[id] = {
		marker = createMarker(x, y, z - 0.6, "checkpoint", g_PATIENT_PICKUP_MARKER_SIZE, 0, 0, 200, 255),
		blip = createBlip(x, y, z, 0, 3.5, 0, 0, 200, 255, 2)
	}
end)

addEvent(g_HIDE_PATIENT_EVENT, true)
addEventHandler(g_HIDE_PATIENT_EVENT, localPlayer, function(id)
	-- possible to use x, y, z to remove the element instead of keeping track of?
	if not g_PatientMarkers[id] then return end

	destroyElement(g_PatientMarkers[id].marker)
	destroyElement(g_PatientMarkers[id].blip)

	g_PatientMarkers[id] = nil
end)

addEvent(g_PATIENTS_DROPPED_OFF_EVENT, true)
addEventHandler(g_PATIENTS_DROPPED_OFF_EVENT, localPlayer, function(numPatients)
	playSound("bloop.wav")
	drawText(g_RESCUED_TEXT, 3500)
	local ambuLance = getPedOccupiedVehicle(localPlayer)
    setElementHealth(ambuLance, getElementHealth(ambuLance) + numPatients * 50)
end)

addEvent(g_PATIENT_PICKED_UP, true)
addEventHandler(g_PATIENT_PICKED_UP, localPlayer, function()
	playSound("blip.wav")
end)

addEvent(g_AMBULANCE_FULL_EVENT, true)
addEventHandler(g_AMBULANCE_FULL_EVENT, localPlayer, function(alreadyFull)
	drawText(g_AMBULANCE_FULL_TEXT, 3500)
end)

g_SpeedCheckTimer = nil
addEvent(g_START_SPEEDCHECK_EVENT, true)
addEventHandler(g_START_SPEEDCHECK_EVENT, localPlayer, function(timer)
	g_SpeedCheckTimer = timer
end)

addEvent(g_SUCCEED_SPEEDCHECK_EVENT, true)
addEventHandler(g_SUCCEED_SPEEDCHECK_EVENT, localPlayer, function()
end)

addEvent(g_FAIL_SPEEDCHECK_EVENT, true)
addEventHandler(g_FAIL_SPEEDCHECK_EVENT, localPlayer, function()
end)

addEvent(g_EXIT_SPEEDCHECK_EVENT, true)
addEventHandler(g_EXIT_SPEEDCHECK_EVENT, localPlayer, function()
	g_SpeedCheckStart = nil
end)

g_DrawStates = {}
g_GAMEMODE_DESCRIPTION_TEXT = "mawfeen sux" --no u
g_AMBULANCE_FULL_TEXT = "me: 12 levels seems like too much"
g_RESCUED_TEXT = "him: but original paramedic has 12 levels"

function drawText(textKey, duration)
	g_DrawStates[textKey] = true
	setTimer(function ()
		g_DrawStates[textKey] = false
	end, duration, 1)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	drawText(g_GAMEMODE_DESCRIPTION_TEXT, 15000)

	addEventHandler("onClientRender", root, function()
		local screenWidth, screenHeight = guiGetScreenSize()
		local offsets
		
		if screenWidth / screenHeight >= 1.7 then
			-- 16:9 screen ratio
			offsets = {0.8, 0.92}
		else
			-- 4:3 and others screens
			offsets = {0.65, 0.9}
		end

		if g_DrawStates[g_GAMEMODE_DESCRIPTION_TEXT] then
			dxDrawBorderedText(0.5, "Drive the #3344DBpatients #C8C8C8to #DE1A1AHospital #C8C8C8CAREFULLY.\nEach bump reduces their chances of survival.", screenWidth / 2, screenHeight * 0.8, 800, screenHeight, tocolor(210, 210, 210, 255), screenHeight/350, "default-bold", "center", "top", false, false, false, true)
		end

		if g_DrawStates[g_AMBULANCE_FULL_TEXT] then
			dxDrawBorderedText(0.5, "Ambulance full!!", screenWidth / 2 - 120, screenHeight * 0.8,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 3, "default-bold")
		end

		if g_DrawStates[g_RESCUED_TEXT] then
			dxDrawBorderedText(0.7, "RESCUED!", screenWidth / 2 - 200, screenHeight * 0.2,  screenWidth, screenHeight, tocolor(150, 120, 0, 255), 6, "arial")
		end

		local level = getElementData(localPlayer, "race.checkpoint") or 1
		local patients = 0
		for _ in pairs(g_PatientMarkers) do
			patients = patients + 1
		end

		dxDrawBorderedText(2,"LEVEL", screenWidth * offsets[1], screenHeight * 0.25, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")
		dxDrawBorderedText(2, level .. "/" .. g_NUM_LEVELS, screenWidth * offsets[2], screenHeight * 0.25, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")

		dxDrawBorderedText(2,"PATIENTS", screenWidth * offsets[1], screenHeight * 0.28, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")
		dxDrawBorderedText(2, "" .. patients, screenWidth * offsets[2], screenHeight * 0.28, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")
		
		dxDrawBorderedText(2,"SEATS FREE", screenWidth * offsets[1], screenHeight * 0.33, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")
		dxDrawBorderedText(2,"" .. g_OpenSeats, screenWidth * offsets[2], screenHeight * 0.33, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 1, "bankgothic")

		if isTimer(g_SpeedCheckTimer) then -- pickup timer visualisationicator
			local timeLeft = getTimerDetails(g_SpeedCheckTimer)
			if not timeLeft then return end
			local percent = (g_SPEED_CHECK_INTERVAL - timeLeft) / g_SPEED_CHECK_INTERVAL

			local x, y, z = getElementVelocity(getPedOccupiedVehicle(localPlayer))
			local completeVelocity = x * x + y * y + z * z
			local redScale = math.min(math.max(completeVelocity - g_PICKUP_SPEED_LIMIT, 0) / (3 * g_PICKUP_SPEED_LIMIT), 1)
			local color = tocolor(200 * redScale, 200 * (1 - redScale), 0)

			dxDrawRectangle(screenWidth / 2 - 126, screenHeight * 0.85, 252, 27, tocolor(0, 0, 0))
			dxDrawRectangle(screenWidth / 2 - 122, screenHeight * 0.85 + 4, 244, 19, tocolor(40, 40, 40))
			dxDrawRectangle(screenWidth / 2 - 122, screenHeight * 0.85 + 4, 244 * percent, 19, color)
		end
	end)
end)

function textReminder()
    outputChatBox("")
    outputChatBox("#FFFFFFRemember, access the map by pressing #F05050F11.", 240, 80, 80, true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),textReminder)

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top - outline, right - outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top - outline, right + outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top + outline, right - outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top + outline, right + outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top, right - outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top, right + outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outline, right, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outline, right, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end