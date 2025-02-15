addEventHandler("onClientResourceStart", getRootElement(), function()	
	engineImportTXD(engineLoadTXD("rcbandit.txd"), 441)
	engineReplaceModel(engineLoadDFF("rcbandit.dff"), 441)
end )

addEventHandler("onClientRender", getRootElement(), function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	
	setVehicleHandling(vehicle, "numberOfGears", 2)
	setVehicleHandling(vehicle, "maxVelocity", 45.0)
	setVehicleHandling(vehicle, "engineAcceleration", 10.0)
end )

addEventHandler("onClientPlayerSpawn", getLocalPlayer(), function()
	setCameraViewMode(3)
end )