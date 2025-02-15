function changeAndAlignVehicle(vehicle, vehicleID)
	local prevVehicleHeight = getElementDistanceFromCentreOfMassToBaseOfModel(vehicle)
	
	triggerServerEvent("onChangeVehicle", root, vehicle, vehicleID)
	setElementModel(vehicle, vehicleID)
	
	local newVehicleHeight = getElementDistanceFromCentreOfMassToBaseOfModel(vehicle)
	local vx, vy, vz = getElementPosition(vehicle)

	if prevVehicleHeight and newVehicleHeight > prevVehicleHeight then
		vz = vz - prevVehicleHeight + newVehicleHeight
	end
	setElementPosition(vehicle, vx, vy, vz)
end

addEvent("onRandomizerCheckpoint", true)

addEventHandler("onRandomizerCheckpoint", root, changeAndAlignVehicle)