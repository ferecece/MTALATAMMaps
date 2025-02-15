addEventHandler("onClientPlayerSpawn", getLocalPlayer(), function() setTimer(reRailPlayersTrain, 2000, 1) end)

function reRailPlayersTrain()
	-- Get player's train
	local playerTram = getPedOccupiedVehicle(localPlayer)
	if not playerTram then 
		return
	end
	
	-- Rerail player's train and set train speed
	if getVehicleType(playerTram) == "Train" then
		--setTrainDirection(playerTram, false)
		local playerFreightSpeed = getTrainSpeed(playerTram)
		
		if playerFreightSpeed < -0.8 then 
			setTrainDerailed(playerTram, false)
			setTrainSpeed(playerTram, playerFreightSpeed+0.2)
		end
		
		if playerFreightSpeed > 0.8 then 
			setTrainDerailed(playerTram, false)
			setTrainSpeed(playerTram, playerFreightSpeed-0.2)
		end
	end
end