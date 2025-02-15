local predefinedHandling = {
	[494] = {
		["maxVelocity"] = 280,
		["dragCoeff"] = 0.7,
		["brakeDeceleration"] = 1000,
		["engineAcceleration"] = 30.0,
		["engineInertia"] = 120.0,
		["suspensionHighSpeedDamping"] = 0.0,
	},
	[502] = {
		["maxVelocity"] = 280,
		["dragCoeff"] = 0.7,
		["brakeDeceleration"] = 1000,
		["engineAcceleration"] = 30.0,
		["engineInertia"] = 120.0,
		["suspensionHighSpeedDamping"] = 0.0,
	},
	[503] = {
		["maxVelocity"] = 280,
		["dragCoeff"] = 0.7,
		["brakeDeceleration"] = 1000,
		["engineAcceleration"] = 30.0,
		["engineInertia"] = 120.0,
		["suspensionHighSpeedDamping"] = 0.0,
	},
}
outputChatBox("Pickups in pit lane for a car with default handling", getRootElement(), 255, 20, 20, true)

addEventHandler ( "onPlayerVehicleEnter", getRootElement(),
function()
	for i,v in pairs (predefinedHandling) do
		if i then
			for handling, value in pairs (v) do
				if not setModelHandling (i, handling, value) then
					outputDebugString ("* Predefined handling '"..tostring(handling).."' for vehicle model '"..tostring(i).."' could not be set to '"..tostring(value).."'")
				end
			end
		end
	end

	for _,v in ipairs (getElementsByType("vehicle")) do
		if v and predefinedHandling[getElementModel(v)] then
			for k,vl in pairs (predefinedHandling[getElementModel(v)]) do
				setVehicleHandling (v, k, vl)
			end
		end
	end
end
)

function resetHandling()
	for model in pairs (predefinedHandling) do
		if model then
			for k in pairs(getOriginalHandling(model)) do
				setModelHandling(model, k, nil)
			end
		end
	end

	for _,v in ipairs (getElementsByType("vehicle")) do
		if v then
			local model = getElementModel(v)
			if predefinedHandling[model] then
				for k,h in pairs(getOriginalHandling(model)) do
					setVehicleHandling(v, k, h)
				end
			end
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, resetHandling)