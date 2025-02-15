addEvent('onPlayerReachCheckpoint')
addEventHandler('onPlayerReachCheckpoint', getRootElement(),
	function(checkpoint)
		local vehicle = getPedOccupiedVehicle(source)
		if (vehicle) then
			setVehicleWheelStates(vehicle, 1, 1, 1, 1)
		end
	end
)
