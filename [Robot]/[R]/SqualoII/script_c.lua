screenX, screenY = guiGetScreenSize()

function getPositionFromElementOffset(element, offX, offY, offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
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

addEventHandler("onClientResourceStart", resourceRoot, function()
	engineImportTXD(engineLoadTXD("squalo.txd"), 446)
	engineReplaceModel(engineLoadDFF("squalo.dff"), 446)
	
	viceFont = dxCreateFont("rageitalic.ttf", 150)
	setWorldProperty("LowCloudsColor", 20, 0, 40)
	setWorldProperty("BottomCloudsColor", 20, 0, 40)
	setColorFilter(246, 149, 220, 255, 0, 0, 0, 190)
end )

addEventHandler("onClientScreenFadedIn", getRootElement(), function()
	viceTimer = setTimer(function() end, 6000, 1)
end )

addEventHandler("onClientRender", getRootElement(), function()
	if not getPedOccupiedVehicle(localPlayer) then return end
	local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
	if z > 10000 then return end -- Spec check
	
	local speed = Vector3(getElementVelocity(getPedOccupiedVehicle(localPlayer))).length
	local newPosX, newPosY, newPosZ = getPositionFromElementOffset(getPedOccupiedVehicle(localPlayer), 0, -12, 5-speed*1.5)
	
	if ry > 180 then ry = 360 - ry end
	setCameraMatrix(newPosX, newPosY, newPosZ, x, y, z+1.5, ry / 1.8, 70)
	
	if isTimer(viceTimer) then
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 446 then
			dxDrawBorderedText(1, "Squalo", 0, 0, screenX*0.7, screenY*1.3, tocolor (246, 149, 220), screenX/1920, screenY/1080, viceFont, "right", "bottom", false, false, true, false, false, -20, 0.0, 0.0, 0.0)
		elseif getElementModel(getPedOccupiedVehicle(localPlayer)) == 413 then 
			dxDrawBorderedText(1, "Pony", 0, 0, screenX*0.7, screenY*1.3, tocolor (246, 149, 220), screenX/1920, screenY/1080, viceFont, "right", "bottom", false, false, true, false, false, -20, 0.0, 0.0, 0.0)
		elseif getElementModel(getPedOccupiedVehicle(localPlayer)) == 460 then
			dxDrawBorderedText(1, "Skimmer", 0, 0, screenX*0.7, screenY*1.3, tocolor (246, 149, 220), screenX/1920, screenY/1080, viceFont, "right", "bottom", false, false, true, false, false, -20, 0.0, 0.0, 0.0)
		end
	end
end )