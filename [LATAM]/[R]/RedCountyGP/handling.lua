local timer = {}

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", root, 
function(newState, oldState)
	if newState == "GridCountdown" then 
		for _, veh in ipairs(getElementsByType("vehicle")) do
			setRaceHandling(veh)
		end
	end
end)

addEvent("onPlayerRaceWasted", true)
addEventHandler("onPlayerRaceWasted", root, 
function(veh)
	detectRespawnCar(source)
end)

function detectRespawnCar(player)
	timer[player] = setTimer(
	function()
		if getElementData(player, "state") == "alive" then
			local car = getPedOccupiedVehicle(player)
			setRaceHandling(car)
			killTimer(timer[player])
			timer[player] = nil
		end
	end, 1000, 0)
end

function setRaceHandling(veh)
	setVehicleHandling(veh, "mass", 950)
	setVehicleHandling(veh, "dragCoeff", 1.5)
	setVehicleHandling(veh, "centerOfMass", {0, 0.3, -0.5})
	setVehicleHandling(veh, "tractionBias", 0.55)
	setVehicleHandling(veh, "numberOfGears", 4)
	setVehicleHandling(veh, "maxVelocity", 300)
	setVehicleHandling(veh, "engineAcceleration", 20)
	setVehicleHandling(veh, "engineInertia", 80)
end