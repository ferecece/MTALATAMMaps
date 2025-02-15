doorsVehicle = {}

addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint)
	if not getPedOccupiedVehicle(source) then return end

	local x, y, z = getElementPosition(getPedOccupiedVehicle(source))
	local r = 400
	setElementData(getPedOccupiedVehicle(source), "sirensState", getVehicleSirensOn(getPedOccupiedVehicle(source)))

	repeat
		math.randomseed(math.floor(os.time()/getTickCount()*math.random(1, getTickCount())))
		r = math.random(400, 609)
		
	until (getVehicleType(r) == "Automobile" or getVehicleType(r) == "Monster Truck") and r ~= 596 and r ~= 598 and r ~= 599 and r ~= 597 and r ~= 407 and r ~= 427 and r ~= 416 and r ~= 485 and r ~= 525 and r ~= 408 and r ~= 544 and r ~= 432 and r ~= 601 and r ~= 532 and r ~= 486 and r ~= 406 and r ~= 588 and r ~= 443 and r ~= 530 and r ~= 564 and r ~= 441 --and r ~= 457

	setElementModel(getPedOccupiedVehicle(source), r)

	if isElement(doorsVehicle[source]) then destroyElement(doorsVehicle[source]) end
	doorsVehicle[source] = createVehicle(getElementModel(getPedOccupiedVehicle(source)), 0, 0, 0)
	setVehicleColor(doorsVehicle[source], 0, 0, 0, 0)
	setElementAlpha(doorsVehicle[source], getElementAlpha(getPedOccupiedVehicle(source)))
	attachElements(doorsVehicle[source], getPedOccupiedVehicle(source))

	setVehicleDoorState(getPedOccupiedVehicle(source), 2, 4, false)
	setVehicleDoorState(getPedOccupiedVehicle(source), 3, 4, false)
	setVehicleDoorState(getPedOccupiedVehicle(source), 4, 4, false)
	setVehicleDoorState(getPedOccupiedVehicle(source), 5, 4, false)
end )

addEventHandler("onVehicleEnter", getRootElement(), function(player, seat, jacked)
	addVehicleSirens(source, 2, 2, true, true, true, false)

	if isElement(doorsVehicle[player]) then destroyElement(doorsVehicle[player]) end
	doorsVehicle[player] = createVehicle(getElementModel(getPedOccupiedVehicle(player)), 0, 0, 0)
	setVehicleColor(doorsVehicle[player], 1, 1, 0, 0)
	setElementAlpha(doorsVehicle[player], getElementAlpha(getPedOccupiedVehicle(player)))
	attachElements(doorsVehicle[player], getPedOccupiedVehicle(player))
end )

addEventHandler("onVehicleExit", getRootElement(), function(player, seat, jacker, forcedByScript)
	removeVehicleSirens(source)
end )
