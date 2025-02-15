addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", root,
function (checkpoint)
	local vehicle = getPedOccupiedVehicle(source)
	if checkpoint == 1 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 970, -1111, 150)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementPosition(vehicle, 970, -1111, 23.35)
			setElementRotation(vehicle, 0, 0, 155)
			setElementVelocity(vehicle, 0, 0, 0)
			setElementFrozen(vehicle, false)
		end, 200, 1)
	end
	if checkpoint == 3 then
		setElementRotation(vehicle, 0, 0, 270)
		setElementPosition(vehicle, 1231.46, -1145.02, 23.295)
	end
	if checkpoint == 5 then
		setElementRotation(vehicle, 0, 0, 180)
		setElementPosition(vehicle, 1777.27, -1142.49, 23.6)
	end
	if checkpoint == 8 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 2473, -1689, 13.21)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 10 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 177)
		setElementPosition(vehicle, 2078.5, -1794, 13.1)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 11 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 11)
		setElementPosition(vehicle, 2508.24, -1666.59, 13.15)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 15 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 1, 357, 250)
		setElementPosition(vehicle, 2379, -1528.5, 23.62)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 17 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 11)
		setElementPosition(vehicle, 2508.24, -1666.59, 13.15)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 18 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 90)
		setElementPosition(vehicle, 2282, -1655, 14.56)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 20 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 167.92)
		setElementPosition(vehicle, 2508.48, -1671.29, 13.11)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 21 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 270)
		setElementPosition(vehicle, 2396.25, -1917.75, 13.14)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 25 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 167.92)
		setElementPosition(vehicle, 2508.48, -1671.29, 13.11)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 27 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 106.49)
		setElementPosition(vehicle, 2451.01, -2004.65, 13.07)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 30 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 2074.7, -1687.8, 13.28)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 33 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 180)
		setElementPosition(vehicle, 1533.25, -1675, 13.11)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 100, 1)
	end
	if checkpoint == 34 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 270)
		setElementPosition(vehicle, 2470.28, -1285.08, 29.245)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 38 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 349.8, 0, 180)
		setElementPosition(vehicle, 2721.01, -1405.85, 34.45)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 44 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 138.8)
		setElementPosition(vehicle, 822.37, -1625.23, 12.92)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 47 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 1.19, 0, 294.38)
		setElementPosition(vehicle, 550.31, -1890.05, 3.571)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 48 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 270)
		setElementPosition(vehicle, 2067.87, -1694.75, 13.29)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 49 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 11)
		setElementPosition(vehicle, 2508.24, -1666.59, 13.15)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 56 then
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 57 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 270)
		setElementPosition(vehicle, 2494.75, -1671.24, 12.92)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 60 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 2765.85, -1978.92, 13.13)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 62 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 144)
		setElementPosition(vehicle, 2497.54, -1647.03, 13.03)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
	if checkpoint == 63 then
		setElementVelocity(vehicle, 0, 0, 0)
		setElementRotation(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 2644.91, -2024.42, 13.34)
		setElementFrozen(vehicle, true)
		setTimer( function()
			setElementFrozen(vehicle, false)
		end, 200, 1)
		setElementHealth(vehicle, 1000.0)
	end
end
)
