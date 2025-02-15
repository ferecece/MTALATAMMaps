screenX, screenY = guiGetScreenSize()
basin = nil

addEventHandler("onClientResourceStart", resourceRoot, function()
	engineImportTXD(engineLoadTXD("zebra.txd"), 474)
	engineReplaceModel(engineLoadDFF("zebra.dff"), 474)
	
	viceFont = dxCreateFont("rageitalic.ttf", 150)
	setWorldProperty("LowCloudsColor", 20, 0, 40)
	setWorldProperty("BottomCloudsColor", 20, 0, 40)
	setColorFilter(246, 149, 220, 255, 0, 0, 0, 190)
	
	basin = createColSphere(-1528.6, 492.20001, 6.2, 5)
end )

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

addEventHandler("onClientScreenFadedIn", getRootElement(), function()
	viceTimer = setTimer(function() end, 6000, 1)
end )

addEventHandler("onClientColShapeHit", getRootElement(), function(element, dim)
	if element == getPedOccupiedVehicle(localPlayer) and source == basin then 
		for i = getElementData(localPlayer, "race.checkpoint"), 100 do
			local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
			if (#colshapes == 0) then break end
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
		end
	end
end )

addEventHandler("onClientRender", getRootElement(), function()
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	if isTimer(viceTimer) then
		dxDrawBorderedText(0, "Zebra Cab", 0, 0, screenX*0.7, screenY*1.3, tocolor (246, 149, 220), screenX/1920, screenY/1080, viceFont, "right", "bottom", false, false, true, false, false, -20, 0.0, 0.0, 0.0)
	end
	
	setVehicleColor(getPedOccupiedVehicle(localPlayer), 255, 255, 255, 255, 255, 255) -- white
					
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "mass", 1750.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "turnMass", 4351.7)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "dragCoeff", 2.9)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "centerOfMass", {0.0, 0.1, -0.15})
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "percentSubmerged", 75)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 0.75)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionLoss", 0.85)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionBias", 0.51)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "numberOfGears", 4)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "maxVelocity", 180.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "engineAcceleration", 12.0 )
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "engineInertia", 6.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "driveType", "rwd")
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "engineType", "petrol")
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", 7.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeBias", 0.44)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "steeringLock",  40.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionForceLevel", 0.7)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionDamping", 0.06)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionUpperLimit", 0.25)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionLowerLimit", -0.3)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionFrontRearBias", 0.5)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "suspensionAntiDiveMultiplier", 0.5)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "seatOffsetDistance", 0.2)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "collisionDamageMultiplier", 0.4)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "modelFlags", 0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "handlingFlags", 0)
end )