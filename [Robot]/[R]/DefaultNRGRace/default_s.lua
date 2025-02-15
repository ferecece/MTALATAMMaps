function update()
	local maxPlayers = 0
	for i, players in ipairs(getElementsByType("player")) do
		local x, y, z = getElementPosition(players)
		if not (z > 5000 or getElementData(players, "state") == "spectating") then
			maxPlayers = maxPlayers + 1
		end
	end
	
	if maxPlayers < 1 then return end
	local accDiff = 80/maxPlayers
	local tra1Diff = 0.6/maxPlayers -- 1.2 - 6
	local tra2Diff = 1/maxPlayers -- 1.2 - 6
	
	for i, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if tonumber(getElementData(players, "race rank")) == nil then return end
			
			setVehicleHandling(getPedOccupiedVehicle(players), "engineAcceleration", 20+accDiff*(math.abs(tonumber(getElementData(players, "race rank")) - 1 )))
			setVehicleHandling(getPedOccupiedVehicle(players), "tractionLoss", 0.9+tra1Diff*(math.abs(tonumber(getElementData(players, "race rank")) - 1 )))
			setVehicleHandling(getPedOccupiedVehicle(players), "fTractionMultiplier", 1.8+tra2Diff*(math.abs(tonumber(getElementData(players, "race rank")) - 1 )))
		end
	end
end 

addEventHandler("onResourceStart", resourceRoot, function()	
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 100, 0)
end )