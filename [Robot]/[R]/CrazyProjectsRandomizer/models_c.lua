local oldZ = 0.89
local screenX, screenY = guiGetScreenSize()
local displayTimer, slowmoTimer

local vehicleNames = {    
    [491] =	"Virgo Cabrio",
    [496] =	"Blista 3-Wheeler",
    [566] =	"Glenoma",
    [409] =	"Manananananana",
    [536] =	"Blade-Boat",
    [473] =	"Feltzer Amphibia",
    [539] =	"Rumpo Hovercraft",
    [540] =	"Vincent Cabrio",
    [427] =	"Hotpig Van",
    [529] =	"Herard",
    [551] =	"Crashed Merit",
    [585] =	"Bobster",
    [444] =	"Oceanic Monster",
    [434] =	"Perennial Hotrod",
    [424] =	"Rustlet",
    [420] =	"Taxi 6-Wheeler",
    [501] =	"News Heli on top",
    [488] =	"Goodluck with packages",
    [504] =	"Club+Clover",
	[567] = "Crazy Taxi", 
	[474] = "Zebra Cab",
	[560] = "Sultan Taxi",
	[582] = "Nas Swen",
	[499] = "Fear the Repo van",
	[489] = "Raaaaaancher",
	[598] = "Beta Police LV",
	[441] = "Micro Hotring",
	[556] = "Brown Streak Monster",
	[418] = "Tram?"
}

function drawBorderedText(text, borderSize, width, height, width2, height2, color, size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	text2 = string.gsub(text, "#%x%x%x%x%x%x", "")

	dxDrawText(text2, width+borderSize, height, width2+borderSize, height2, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height+borderSize, width2, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height-borderSize, width2, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height, width2-borderSize, height2, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height+borderSize, width2+borderSize, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height-borderSize, width2-borderSize, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height-borderSize, width2+borderSize, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height+borderSize, width2-borderSize, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text, width, height, width2, height2, color, size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
end

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
	
	engineImportTXD(engineLoadTXD("models/rcbandit.txd"), 441)
	engineReplaceModel(engineLoadDFF("models/rcbandit.dff"), 441)
	
	engineImportTXD(engineLoadTXD("models/train.txd"), 556)
	engineReplaceModel(engineLoadDFF("models/train.dff"), 556)
	
	engineImportTXD(engineLoadTXD("models/moonbeam.txd"), 418)
	engineReplaceModel(engineLoadDFF("models/moonbeam.dff"), 418)
	
	setVehicleModelWheelSize(556, "all_wheels", 3)
end )

addEventHandler("onClientRender", getRootElement(), function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end 
	
	for _, vehicles in ipairs(getElementsByType("vehicle")) do
		if getElementModel(vehicles) == 556 and getVehicleWheelScale(vehicles) ~= 2.3 then
			setVehicleWheelScale(vehicles, 2.3)
		elseif getElementModel(vehicles) ~= 556 and getVehicleWheelScale(vehicles) ~= 1 then
			setVehicleWheelScale(vehicles, 1)
		end
	end
	
	if getElementModel(vehicle) == 474 and getVehicleHandling(vehicle, "maxVelocity") ~= 180.0 then
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
	elseif getElementModel(vehicle) == 567 and getVehicleHandling(vehicle, "maxVelocity") ~= 300.0 then
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
	elseif getElementModel(vehicle) == 556 and getVehicleHandling(vehicle, "turnMass") ~= 1000000.0 then	
		setVehicleHandling(vehicle, "mass", 40000.0)
		setVehicleHandling(vehicle, "turnMass", 1000000.0)
	end
	
	if isTimer(slowmoTimer) then 
		local x, y, z = getElementPosition(vehicle)
		setCameraMatrix(529.09998, -1269.1, 16.2, x, y, z)
	end
	
	if not isTimer(displayTimer) then return end
	drawBorderedText(vehicleNames[getElementModel(getPedOccupiedVehicle(localPlayer))], 2, screenX*0.2, screenY*0.88, screenX*0.98, screenY, tocolor(54, 104, 44, 255), screenY/500, "bankgothic", "left", "top", false, false, true, true)
end )

addEvent("triggerSlowmo", true)
addEventHandler("triggerSlowmo", getRootElement(), function()
	setGameSpeed(0.3)
	if isTimer(slowmoTimer) then killTimer(slowmoTimer) end
	slowmoTimer = setTimer(function() 
		setGameSpeed(1)
		setCameraTarget(localPlayer)
	end, 8000, 1)
end )

addEventHandler("onClientElementModelChange", getRootElement(), function(oldModel, newModel)
	if getElementType(source) == "vehicle" and source == getPedOccupiedVehicle(localPlayer) then 
		local newZ = getElementDistanceFromCentreOfMassToBaseOfModel(getPedOccupiedVehicle(localPlayer))
		if newModel == 504 then newZ = 1 end
		
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		setElementPosition(getPedOccupiedVehicle(localPlayer), x, y, z + (newZ - oldZ))
		oldZ = newZ

		if isTimer(displayTimer) then killTimer(displayTimer) end
		displayTimer = setTimer(function() end, 4000, 1)
	end
end )

bindKey("num_0", "down", function()
	outputChatBox(getElementDistanceFromCentreOfMassToBaseOfModel(getPedOccupiedVehicle(localPlayer)))
end )