math.randomseed(math.floor(os.time()/getTickCount()*math.random(1, getTickCount())))

local webBrowser = false
local screenX, screenY = guiGetScreenSize()
local cinemaSkipTimer
local fuelSkip = math.random(1, 2)

local fuelMessage, homeMessage, fuelTimer = false, false, false

function dxDrawImage3D(x,y,z,w,h,m,...)
	return dxDrawMaterialLine3D(x, y, z+h,x,y,z, m, w,tocolor(255,255,255,255),...)
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

addEventHandler("onClientBrowserCreated", getRootElement(), function()
	loadBrowserURL(webBrowser, "https://www.youtube.com/embed/jYlosSo79YY?&autoplay=1&showinfo=0&rel=0&controls=0&disablekb=1")
	
	addEventHandler("onClientRender", root, function()
		dxDrawImage3D(110.7, 1024.1, 14.9, 16, 8.2, webBrowser, 110.7, 1056, 14.9)
		
		if getPedOccupiedVehicle(localPlayer) then
			if not muted and isMTAWindowFocused() then
				local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
				setBrowserVolume(math.max((120 - getDistanceBetweenPoints3D(x, y, z, 109, 1076, 14))*(1/120), 0)*0.8)
			else setBrowserVolume(0) end
		end
	end )
end )

addEventHandler("onClientRender", root, function()
	-- Spec check
	local u, w, v = getElementPosition(localPlayer)
	if v > 20000 or not getPedOccupiedVehicle(localPlayer) then return end 
	
	-- Messages 
	if fuelMessage then dxDrawBorderedText(1, "I should go to the gas station, not much fuel left in the truck", 0, 0, screenX, screenY*0.9, tocolor (255, 255, 255, 255), 1.5, "pricedown", "center", "bottom", true, false) end
	if homeMessage then dxDrawBorderedText(1, "What a shit movie anyway... It's time for me to go home.", 0, 0, screenX, screenY*0.9, tocolor (255, 255, 255, 255), 1.5, "pricedown", "center", "bottom", true, false) end
	
	-- Events
	if tonumber(getElementData(localPlayer, "race.checkpoint")) then
		-- Create screen source
		if tonumber(getElementData(localPlayer, "race.checkpoint")) == 18 and not webBrowser then 
			webBrowser = createBrowser(1920, 1080, false, false)
			setBrowserVolume(0)
		end
		
		-- Create cinema timer
		if tonumber(getElementData(localPlayer, "race.checkpoint")) == 21 and not isTimer(cinemaSkipTimer) then 
			local time = 62000
			if fuelSkip == 2 then time = 69000 end
			if getElementModel(getPedOccupiedVehicle(localPlayer)) == 447 then time = 47000 end
			
			cinemaSkipTimer = setTimer(function()
				for i = 1, 2 do
					local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
					if #colshapes > 0 then triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer)) end
				end
				
				homeMessage = true
				setTimer(function() homeMessage = false end, 4000, 1)
			end, time, 1)
			
			outputChatBox("Press M to mute the movie")
		end
		
		-- Fuel message
		if tonumber(getElementData(localPlayer, "race.checkpoint")) == 9 and not isTimer(fuelTimer) and not (fuelSkip == 2 or getElementModel(getPedOccupiedVehicle(localPlayer)) == 447) then
			fuelMessage = true
			fuelTimer = setTimer(function() fuelMessage = false end, 6000, 1)
		end
		
		-- Fueling skip
		if tonumber(getElementData(localPlayer, "race.checkpoint")) == 10 and (fuelSkip == 2 or getElementModel(getPedOccupiedVehicle(localPlayer)) == 447) then
			for i = 1, 5 do
				local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
				if #colshapes > 0 then triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer)) end
			end
		end
	
		-- checkpoints
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 447 then
			local markers = getElementsByType("marker", getResourceDynamicElementRoot(getResourceFromName("race")))
			for i, marker in ipairs(markers) do
				if getMarkerType(marker) ~= "ring" then
					setMarkerType(marker, "ring")
					local x, y, z = getElementPosition(marker)
					setElementPosition(marker, x, y, z + 15)
				end
			end
		end
	end
end )

bindKey("m", "down", function() muted = not muted end )