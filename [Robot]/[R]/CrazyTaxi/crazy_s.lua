peds = {}
pedAnims = {}
pedAnimTimer = {}

addEventHandler("onPlayerVehicleEnter", root, function(vehicle, seat, jacked)
		-- set up taxi
	setVehicleColor(vehicle, 215, 142, 16, 165, 138, 65) -- color #6
	setVehicleHandling(vehicle, "engineInertia", 4.0)
	setVehicleHandling(vehicle, "collisionDamageMultiplier", 0.4)
	setVehicleHandling(vehicle, "turnMass", 3000.0)
	setVehicleHandling(vehicle, "brakeBias", 0.52)
	setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.0, -0.3})
	setVehicleHandling(vehicle, "tractionLoss", 1.2)
	setVehicleHandling(vehicle, "tractionBias", 0.53)
	setVehicleHandling(vehicle, "tractionMultiplier", 0.85)
	setVehicleHandling(vehicle, "maxVelocity", 300.0)
	setVehicleHandling(vehicle, "engineAcceleration", 20.0)
	setVehicleHandling(vehicle, "mass", 2500.0)
	setVehicleHandling(vehicle, "brakeDeceleration", 12.0)
	setVehicleOverrideLights(vehicle, 2)
	
	-- set up ped
	if isElement(peds[source]) then destroyElement(peds[source]) end
	
	math.randomseed(getTickCount())
	repeat
		peds[source] = createPed(math.random(0, 311), 0.0, 0.0, 0.0)
	until isElement(peds[source])
	
	warpPedIntoVehicle(peds[source], vehicle, 3)
	setElementAlpha(peds[source], getElementAlpha(source))
	setPedAnimation(peds[source], "lowrider", "lrgirl_idleloop")
	
	if isTimer(pedAnimTimer[source]) then killTimer(pedAnimTimer[source]) end
	pedAnimTimer[source] = setTimer(setAnim, 500, 0, source)
end )

addEventHandler("onPlayerWasted", root, function(ammo, attacker, weapon, bodypart)
	if isTimer(pedAnimTimer[source]) then killTimer(pedAnimTimer[source]) end
end )

function setAnim(s)
	if not isElement(peds[s]) or getElementType(peds[s]) ~= "ped" then
		return 
	end

	if getElementData(s, "air") == 0 then -- not in air
		if pedAnims[s] ~= 0 then
			setTimer(function() 
				if not isElement(peds[s]) or getElementType(peds[s]) ~= "ped" then return end 
				setPedAnimation(peds[s], "lowrider", "lrgirl_idleloop") 
			end, 1000, 1) 
			pedAnims[s] = 0
		end
	elseif getElementData(s, "air") == 1 then -- in air
		if pedAnims ~= 1 then
			setTimer(function()
				if getElementData(s, "air") == 1 then
					if not isElement(peds[s]) or getElementType(peds[s]) ~= "ped" then return end 
					setPedAnimation(peds[s], "lowrider", "lrgirl_l4_loop")
					pedAnims[s] = 1
				end
			end, 100, 1)
		end
	end
	setElementAlpha(peds[s], getElementAlpha(s))
end

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	setVehicleWheelStates(getPedOccupiedVehicle(source), -1, 2, -1, 2)
	outputChatBox("#E6FFDD"..getPlayerName(source).. " #E6FFDDfinished the race with #D78E10" ..getElementData(source, "Score").. " #E6FFDDscore.", root, 255, 255, 255, true)
	setTimer(function() if isElement(peds[source]) then destroyElement(peds[source]) end end, 6000, 1)
end )

addEventHandler("onPlayerQuit", root, function(quitType)
	if isElement(peds[source]) then destroyElement(peds[source]) end
	if isTimer(pedAnimTimer[source]) then killTimer(pedAnimTimer[source]) end
end )