screen_width, screen_height = guiGetScreenSize()
scale = screen_height/1080
text_top = screen_height - 250*scale

handling_values = false
handling_presets = false

handling_defaults = {
	engineInertia = 10,
	suspensionHighSpeedDamping = 0,
	suspensionDamping = 0.2,
	suspensionLowerLimit = -0.2,
	suspensionUpperLimit = 0.27,
	suspensionAntiDiveMultiplier = 0.35,
	suspensionFrontRearBias = 0.5,
	suspensionForceLevel = 1,
	engineAcceleration = 8.4,
	numberOfGears = 5,
	brakeDeceleration = 7.5,
	maxVelocity = 180,
	brakeBias = 0.65,
	tractionLoss = 0.65,
	tractionMultiplier = 0.75,
	tractionBias = 0.52,
	mass = 1850,
	turnMass = 5000,
	steeringLock = 30,
	percentSubmerged = 75,
	seatOffsetDistance = 0.24,
	dragCoeff = 2.2,
	centerOfMass = {0, 0, -0.1},
	collisionDamageMultiplier = 0.6,
	handlingFlags = 0x10400000,
	modelFlags = 0,
}

----------------------------------------
-- Events
----------------------------------------

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("onClientRequestHandlingPresets", localPlayer)
end)

addEventHandler("onClientRender", root, function()
	if handling_values then
		
		dxDrawText("Mass",                 0, text_top,           screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Steering angle",       0, text_top+20*scale, screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Engine power",         0, text_top+40*scale,  screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Brake power",          0, text_top+60*scale,  screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Wheel grip",           0, text_top+80*scale,  screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Turning grip",         0, text_top+100*scale,  screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Suspension height",    0, text_top+120*scale, screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		dxDrawText("Suspension tightness", 0, text_top+140*scale, screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		--dxDrawText("Suspension bias",      0, text_top+140*scale, screen_width/2 - 5*scale, text_top + 50, 0xFFFFFFFF, scale*1.5, "default-bold", "right", "top")
		
		
		local pct, color
		
		-- Mass
		pct = math.ceil(handling_values.mass/handling_defaults.mass*100)
		color = getColor(handling_values.mass, handling_presets.mass[1], handling_presets.mass[2], handling_defaults.mass)
		dxDrawText(color .. handling_values.mass .. "kg (" .. pct .. "%)", screen_width/2 + 5*scale, text_top, screen_width, text_top+50, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Steering angle
		pct = math.ceil(handling_values.steeringLock/handling_defaults.steeringLock*100)
		color = getColor(handling_values.steeringLock, handling_presets.steeringLock[1], handling_presets.steeringLock[2], handling_defaults.steeringLock)
		dxDrawText(color .. round(handling_values.steeringLock,0) .. "°", screen_width/2 + 5*scale, text_top+20*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Engine power
		pct = math.ceil(handling_values.engineAcceleration/handling_defaults.engineAcceleration*100)
		color = getColor(handling_values.engineAcceleration, handling_presets.engineAcceleration[1], handling_presets.engineAcceleration[2], handling_defaults.engineAcceleration)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+40*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Brake power
		pct = math.ceil(handling_values.brakeDeceleration/handling_defaults.brakeDeceleration*100)
		color = getColor(handling_values.brakeDeceleration, handling_presets.brakeDeceleration[1], handling_presets.brakeDeceleration[2], handling_defaults.brakeDeceleration)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+60*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Wheel grip
		pct = math.ceil(handling_values.tractionLoss/handling_defaults.tractionLoss*100)
		color = getColor(handling_values.tractionLoss, handling_presets.tractionLoss[1], handling_presets.tractionLoss[2], handling_defaults.tractionLoss)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+80*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Turning grip
		pct = math.ceil(handling_values.tractionMultiplier/handling_defaults.tractionMultiplier*100)
		color = getColor(handling_values.tractionMultiplier, handling_presets.tractionMultiplier[1], handling_presets.tractionMultiplier[2], handling_defaults.tractionMultiplier)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+100*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Suspension Height
		local height = -range(handling_values.suspensionLowerLimit, -0.5, -0.01, -1, 0)
		pct = math.ceil(handling_values.suspensionLowerLimit/handling_defaults.suspensionLowerLimit*100)
		color = getColor(handling_values.suspensionLowerLimit, handling_presets.suspensionLowerLimit[1], handling_presets.suspensionLowerLimit[2], handling_defaults.suspensionLowerLimit)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+120*scale, screen_width, text_top+50, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Suspension tightness
		pct = math.ceil(handling_values.suspensionForceLevel/handling_defaults.suspensionForceLevel*100)
		color = getColor(handling_values.suspensionForceLevel, handling_presets.suspensionForceLevel[1], handling_presets.suspensionForceLevel[2], handling_defaults.suspensionForceLevel)
		dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+140*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		-- Suspension bias
		--pct = math.ceil(handling_values.suspensionFrontRearBias/handling_defaults.suspensionFrontRearBias*100)
		--color = getColor(handling_values.suspensionFrontRearBias, handling_presets.suspensionFrontRearBias[1], handling_presets.suspensionFrontRearBias[2], handling_defaults.suspensionFrontRearBias)
		--dxDrawText(color .. pct .. "%", screen_width/2 + 5*scale, text_top+160*scale, screen_width, text_top+100, 0xFFFFFFFF, scale*1.5, "default-bold", "left", "top", false, false, true, true)
		
		
		
		-- Rear wheel/handbrake steering
		if handling_values.handlingFlags == 0x20 then
			dxDrawText("+ Rear steering!", 0, text_top+160*scale, screen_width, text_top+100, 0xFFFFFF00, scale*1.5, "default-bold", "center", "top")
		elseif handling_values.handlingFlags == 0x40 then
			dxDrawText("+ Handbrake steering!", 0, text_top+160*scale, screen_width, text_top+100, 0xFFFFFF00, scale*1.5, "default-bold", "center", "top")
		end
		
		-- Fun stuff (center of mass -5m underground)
		if handling_values.centerOfMass and handling_values.centerOfMass[3] == -5 then
			dxDrawText("+ Fun stuff!", 0, text_top+180*scale, screen_width, text_top+100, 0xFFFFFF00, scale*1.5, "default-bold", "center", "top")
		end
	end
end)

addEvent("onServerSendHandlingPresets", true)
addEventHandler("onServerSendHandlingPresets", root, function(presets)
	handling_presets = presets
	
	-- Divide by divisor, if it exists
	for property,values in pairs(handling_presets) do
		if values[3] then
			values[1] = values[1] / values[3]
			values[2] = values[2] / values[3]
		end
	end
	
	handling_values = handling_defaults
end)

addEvent("onServerSendHandlingValues", true)
addEventHandler("onServerSendHandlingValues", root, function(values)
	handling_values = values
end)

----------------------------------------
-- Functions
----------------------------------------

function range(oldValue,oldMin,oldMax,newMin,newMax)
	local newValue = (((oldValue - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) + newMin
	
	if newValue > newMax then newValue = newMax
	elseif newValue < newMin then newValue = newMin
	end
	
	return newValue
end

function getColor(val, min_, max_, middle)
	local r = 0
	local g = 0
	local pct = 0
	
	if val >= middle then
		pct = range(val, middle, max_, 0.5, 1)
	else
		pct = range(val, min_, middle, 0, .5)
	end
	
	r = 510 * (1-pct)
	g = 510 * (pct)
	return rgbToHex(r,g,0)
end

function rgbToHex(r,g,b)
	if r > 255 then r = 255 end
	if g > 255 then g = 255 end
	if b > 255 then b = 255 end
	return "#" .. string.format("%.2x",r) .. string.format("%.2x",g) .. string.format("%.2x",b)
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
