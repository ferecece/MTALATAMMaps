local markersPos = {
	{1955.0118, -1367.7200, 24.7354},
	{1954.6088, -1376.9637, 24.2187},
	{1887.3917, -1362.9537, 19.4329},
	{1914.1375, -1427.0991, 15.5805},
	{1908.5515, -1388.3890, 10.3294},
	{1882.3623, -1427.6859, 10.3294},
	{1953.3492, -1426.5858, 10.3294},
	{1878.1891, -1388.8102, 15.2464},
	{1878.1838, -1388.8392, 18.1461},
	{1872.3269, -1451.0511, 15.7645},
	{1905.1785, -1413.6747, 13.5322},
	{1949.5026, -1411.5458, 15.1837},
	{1867.1531, -1410.0066, 13.5322},
	{1909.3409, -1369.8458, 16.7966},
	{1939.2430, -1388.1323, 19.2615},
	{1904.8877, -1360.6219, 13.5322},
	{1930.2335, -1398.6198, 16.8554},
	{1888.7649, -1399.3260, 17.2408},
	{1900.9476, -1397.8297, 15.6868}
}
local markers = {}
local blips = {}
local cols = {}
local ringRotation = 0
local timer = 10
local failed = false
local passed = false
local secs = false
local finishedtime = 0

screenX, screenY = guiGetScreenSize()
if math.floor(screenX / screenY) >= 1.7 then offsets = {0.8, 0.92} -- 16:9 screen ratio 
else offsets = {0.72, 0.9} end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i = 1, 19 do
		markers[i] = CPrm3DRingAp:create(Vector3(markersPos[i][1], markersPos[i][2], markersPos[i][3]), Vector3(90, 45, 0), Vector3(1.4, 1.4, 1.4), Vector4(255, 0, 0, 80))
		blips[i] = createBlip(markersPos[i][1], markersPos[i][2], markersPos[i][3])
		cols[i] = createColSphere(markersPos[i][1], markersPos[i][2], markersPos[i][3], 3)
	end
end )

addEvent("startTimer", true)
addEventHandler("startTimer", getRootElement(), function()
	if not isTimer(TimerS) then TimerS = setTimer(updatePlayersTimer, 1000, 0) end
end )

addEvent("playerFinished", true)
addEventHandler("playerFinished", getRootElement(), function(time)
	finishedtime = time
	passed = true
	setTimer(function() passed = false end, 6000, 1)
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	for i = 1, 19 do 
		if markers[i] ~= nil then markers[i]:destroy() end
	end
end )

addEventHandler("onClientPreRender", root, function()
	ringRotation = ringRotation + 10
	if ringRotation > 360 then ringRotation = 0 end	
	
	for i = 1, 19 do
		if markers[i] ~= nil then 
			markers[i]:setRotation(Vector3(0, 0, ringRotation))
			markers[i]:draw()
		end
	end 
end )

addEventHandler("onClientRender", root, function()
	-- mission failed text
	if failed then 
		dxDrawBorderedText(1, "Mission Failed!", 0, 0, screenX, screenY*0.75, tocolor (157, 22, 27, 255), 3, "pricedown", "center", "center", true, false) 
		dxDrawBorderedText(2, "You ran out of time!", 0, 0, screenX, screenY*0.98, tocolor (157, 22, 27, 255), 1.2, "bankgothic", "center", "bottom", true, false)
	end
	
	if passed then
		local m = math.floor(finishedtime / 1000 / 60)
		local s = math.floor((finishedtime / 1000) - m*60)
		if s < 10 then s = "0" ..s end
	
		dxDrawBorderedText(1, "Mission Passed!", 0, 0, screenX, screenY*0.75, tocolor (145, 103, 21, 255), 3, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "New Best Time! "..m.. ":" ..s, 0, 0, screenX, screenY*0.9, tocolor (194, 194, 194, 255), 3, "pricedown", "center", "center", true, false)
	end
	
	if secs then dxDrawBorderedText(2, "+10 seconds", 0, 0, screenX, screenY*0.83, tocolor(194, 194, 194, 255), 1.2, "bankgothic", "center", "bottom") end
	
	if timer == 0 then return end
	local m = math.floor(timer / 60)
	local s = timer - m*60
		
	-- timer
	dxDrawBorderedText(2,"TIME LEFT", screenX * offsets[1], screenY * 0.22, screenX, screenY, tocolor(194, 194, 194, 255), 1, "bankgothic")
	if s < 10 then dxDrawBorderedText(2, m.. ":0" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(194, 194, 194, 255), 1, "bankgothic")	
	else dxDrawBorderedText(2, m.. ":" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(194, 194, 194, 255), 1, "bankgothic") end
end )

function updatePlayersTimer()
	timer = timer - 1
	if timer <= 0 then 
		-- Mission failed
		killTimer(TimerS)
		setElementHealth(localPlayer, 0)
		failed = true
		setTimer(function() failed = false end, 6000, 1)
	end
end

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" then
        scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
    end
    local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
    local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

addEventHandler("onClientElementColShapeHit", getRootElement(), function(shape, dim)
	if source == localPlayer then
		for i = 1, 19 do
			if markers[i] ~= nil and shape == cols[i] then 
				setTimer(function()
					local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
					if #colshapes > 0 then 
						triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
					end
				end, 100, 1, 1)
				timer = timer + 10
				
				markers[i]:destroy()
				markers[i] = nil
				destroyElement(cols[i])
				destroyElement(blips[i])
				
				secs = true
				setTimer(function() secs = false end, 2000, 1)
				
				break
			end
		end
	end
end )