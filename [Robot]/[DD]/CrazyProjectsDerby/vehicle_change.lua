local models = {
	491, 496, 566, 409, 536, 540, 427, 529, 551, 585, 444, 434, 424, 420, 504, 598, 474, 560, 567, 582, 499, 489
}

addEvent("vehicleChange", true)
addEventHandler("vehicleChange", getRootElement(), function()
	setElementModel(getPedOccupiedVehicle(source), models[math.random(#models)])
	local x, y, z = getElementPosition(getPedOccupiedVehicle(source))
	setElementPosition(getPedOccupiedVehicle(source), x, y, z + 1)
	setElementHealth(getPedOccupiedVehicle(source), 900)
end )