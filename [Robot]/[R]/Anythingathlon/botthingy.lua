function onResourceStartbot()
	local newscopter = createVehicle(488,151.19999694824,-1891.6999511713,4)
	local ped = createPed(0,0,0,0)
	warpPedIntoVehicle(ped,newscopter)
	setVehicleEngineState(newscopter,true)
end
addEventHandler ( "onResourceStart", getRootElement(), onResourceStartbot )