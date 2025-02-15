local change = 0
screenX, screenY = guiGetScreenSize()
if screenX / screenY >= 1.7 then offsets = {0.75, 0.92} 	
else offsets = {0.65, 0.9} end

addEventHandler("onClientResourceStart", resourceRoot, function()
	engineImportTXD(engineLoadTXD("models/virgo.txd"), 491)
	engineReplaceModel(engineLoadDFF("models/virgo.dff"), 491)
	
	engineImportTXD(engineLoadTXD("models/blistac.txd"), 496)
	engineReplaceModel(engineLoadDFF("models/blistac.dff"), 496)
	
	engineImportTXD(engineLoadTXD("models/tahoma.txd"), 566)
	engineReplaceModel(engineLoadDFF("models/tahoma.dff"), 566)	
	
	engineImportTXD(engineLoadTXD("models/stretch.txd"), 409)
	engineReplaceModel(engineLoadDFF("models/stretch.dff"), 409)	
	
	engineImportTXD(engineLoadTXD("models/blade.txd"), 536)
	engineReplaceModel(engineLoadDFF("models/blade.dff"), 536)	
	
	engineImportTXD(engineLoadTXD("models/dinghy.txd"), 473)
	engineReplaceModel(engineLoadDFF("models/dinghy.dff"), 473)	
	
	engineImportTXD(engineLoadTXD("models/vortex.txd"), 539)
	engineReplaceModel(engineLoadDFF("models/vortex.dff"), 539)	
	
	engineImportTXD(engineLoadTXD("models/vincent.txd"), 540)
	engineReplaceModel(engineLoadDFF("models/vincent.dff"), 540)	
	
	engineImportTXD(engineLoadTXD("models/enforcer.txd"), 427)
	engineReplaceModel(engineLoadDFF("models/enforcer.dff"), 427)	
	
	engineImportTXD(engineLoadTXD("models/willard.txd"), 529)
	engineReplaceModel(engineLoadDFF("models/willard.dff"), 529)	
	
	engineImportTXD(engineLoadTXD("models/merit.txd"), 551)
	engineReplaceModel(engineLoadDFF("models/merit.dff"), 551)	
	
	engineImportTXD(engineLoadTXD("models/emperor.txd"), 585)
	engineReplaceModel(engineLoadDFF("models/emperor.dff"), 585)	
	
	engineImportTXD(engineLoadTXD("models/monster.txd"), 444)
	engineReplaceModel(engineLoadDFF("models/monster.dff"), 444)	
	
	engineImportTXD(engineLoadTXD("models/hotknife.txd"), 434)
	engineReplaceModel(engineLoadDFF("models/hotknife.dff"), 434)	
	
	engineImportTXD(engineLoadTXD("models/bfinject.txd"), 424)
	engineReplaceModel(engineLoadDFF("models/bfinject.dff"), 424)	
	
	engineImportTXD(engineLoadTXD("models/taxi.txd"), 420)
	engineReplaceModel(engineLoadDFF("models/taxi.dff"), 420)		
	
	engineImportTXD(engineLoadTXD("models/bloodra.txd"), 504)
	engineReplaceModel(engineLoadDFF("models/bloodra.dff"), 504)
	
	engineImportTXD(engineLoadTXD("models/copcarvg.txd"), 598)
	engineReplaceModel(engineLoadDFF("models/copcarvg.dff"), 598)
	
	engineImportTXD(engineLoadTXD("models/zebra.txd"), 474)
	engineReplaceModel(engineLoadDFF("models/zebra.dff"), 474)
	
	engineImportTXD(engineLoadTXD("models/sultan.txd"), 560)
	engineReplaceModel(engineLoadDFF("models/sultan.dff"), 560)
	
	engineImportTXD(engineLoadTXD("models/savanna.txd"), 567)
	engineReplaceModel(engineLoadDFF("models/savanna.dff"), 567)
	
	engineImportTXD(engineLoadTXD("models/newsvan.txd"), 582)
	engineReplaceModel(engineLoadDFF("models/newsvan.dff"), 582)
	
	engineReplaceModel(engineLoadDFF("models/benson.dff"), 499)
	engineReplaceModel(engineLoadDFF("models/rancher.dff"), 489)
end)

addEventHandler("onClientRender", getRootElement(), function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local x, y, z = getElementPosition(localPlayer)
	if z > 5000 or not vehicle then return end 

	if getElementModel(vehicle) == 474 then
		-- Zebra Cab
		setVehicleHandling(vehicle, "mass", 1750.0)
		setVehicleHandling(vehicle, "turnMass", 4351.7)
		setVehicleHandling(vehicle, "dragCoeff", 2.9)
		setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.1, -0.15})
		setVehicleHandling(vehicle, "percentSubmerged", 75)
		setVehicleHandling(vehicle, "tractionMultiplier", 0.75)
		setVehicleHandling(vehicle, "tractionLoss", 0.85)
		setVehicleHandling(vehicle, "tractionBias", 0.51)
		setVehicleHandling(vehicle, "numberOfGears", 4)
		setVehicleHandling(vehicle, "maxVelocity", 180.0)
		setVehicleHandling(vehicle, "engineAcceleration", 12.0 )
		setVehicleHandling(vehicle, "engineInertia", 6.0)
		setVehicleHandling(vehicle, "driveType", "rwd")
		setVehicleHandling(vehicle, "engineType", "petrol")
		setVehicleHandling(vehicle, "brakeDeceleration", 7.0)
		setVehicleHandling(vehicle, "brakeBias", 0.44)
		setVehicleHandling(vehicle, "steeringLock",  40.0)
		setVehicleHandling(vehicle, "suspensionForceLevel", 0.7)
		setVehicleHandling(vehicle, "suspensionDamping", 0.06)
		setVehicleHandling(vehicle, "suspensionUpperLimit", 0.25)
		setVehicleHandling(vehicle, "suspensionLowerLimit", -0.3)
		setVehicleHandling(vehicle, "suspensionFrontRearBias", 0.5)
		setVehicleHandling(vehicle, "suspensionAntiDiveMultiplier", 0.5)
		setVehicleHandling(vehicle, "seatOffsetDistance", 0.2)
		setVehicleHandling(vehicle, "collisionDamageMultiplier", 0.4)
		setVehicleHandling(vehicle, "modelFlags", 0)
		setVehicleHandling(vehicle, "handlingFlags", 0)
	elseif getElementModel(vehicle) == 567 then
		-- Crazy vehicle
		setVehicleHandling(vehicle, "engineInertia", 4.0)
		setVehicleHandling(vehicle, "collisionDamageMultiplier", 0.4)
		setVehicleHandling(vehicle, "turnMass", 3000.0)
		setVehicleHandling(vehicle, "brakeBias", 0.52)
		setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.0, -0.3})
		setVehicleHandling(vehicle, "tractionLoss", 1.2)
		setVehicleHandling(vehicle, "tractionBias", 0.53)
		setVehicleHandling(vehicle, "tractionMultiplier", 0.85)
		setVehicleHandling(vehicle, "maxVelocity", 300.0)
		setVehicleHandling(vehicle, "engineAcceleration", 20.0)
		setVehicleHandling(vehicle, "mass", 2500.0)
		setVehicleHandling(vehicle, "brakeDeceleration", 12.0)
	end
	
	-- tips
	dxDrawBorderedText(2,"Vehicle Change", screenX * offsets[1], screenY * 0.40, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
	dxDrawRectangle(screenX*offsets[2]-3.0, (screenY * 0.4103)-3.0, 106.0, 18.0, tocolor(0, 0, 0, 255)) -- border
	dxDrawRectangle(screenX*offsets[2], screenY*0.4103, 100.0, 12.0, tocolor(86, 101, 120, 255)) -- inside
	dxDrawRectangle(screenX*offsets[2], screenY*0.4103, 1.0*change, 12.0, tocolor(171, 203, 241, 255)) -- progress
	
	if change >= 100 then
		change = 0 
		triggerServerEvent("vehicleChange", getLocalPlayer())
	end
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

addEventHandler("onClientVehicleCollision", root, function(a, b)
	if getPedOccupiedVehicle(localPlayer) then
		if getPedOccupiedVehicle(localPlayer) == source then 
			local loss = b * getVehicleHandling(source).collisionDamageMultiplier * 0.1
			change = change + loss / 3
		end
	end
end )