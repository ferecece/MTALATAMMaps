-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- Info for start a mission
	b_offsets = {0.012, 0.163, 0.13, 0.05} -- X-left, Y-top, width, height for a box
	t_offsets = {0.014, 0.168, 0.200, 2.3} -- X-left, Y1, Y2, textsize
	
 -- 4:3 and others screens
else 
	-- Info for start a mission
	b_offsets = {0.020, 0.190, 0.13, 0.05} -- X-left, Y-top, width, height for a box
	t_offsets = {0.022, 0.195, 0.225, 2.0} -- X-left, Y1, Y2, textsize
end 	

-- Timers
updateTimer = nil
helpTimer = nil

-- Special actions
unlimitedHealth = false
allCarsHaveNitro = false
alwaysMidnight = false
alwaysEvening = false
speedTime = false
wantSpectate = false

function activateCheat(cheat)
	-- Armor, health and $250,000
	if cheat == 1 or cheat == 2 then
		fixVehicle(getPedOccupiedVehicle(localPlayer))
		givePlayerMoney(250000)
		
	-- Commit suicide	
	elseif cheat == 3 or cheat == 4 then
		setElementHealth(localPlayer, 0)
	
	-- Maximum fat
	elseif cheat == 5 or cheat == 6 then 
		setPedStat(localPlayer, 21, 999)
	
	-- Maximum muscle
	elseif cheat == 7 or cheat == 8 then
		setPedStat(localPlayer, 23, 999)
		
	-- Maximum sex appeal
	elseif cheat == 9 or cheat == 10 then
		setPedStat(localPlayer, 25, 999)
		
	-- Maximum sex appeal
	elseif cheat == 11 or cheat == 12 then
		setPedStat(localPlayer, 229, 999)
		setPedStat(localPlayer, 230, 999)
		setPedStat(localPlayer, 160, 999)
		
	-- Minimum fat and muscle
	elseif cheat == 13 or cheat == 14 then
		setPedStat(localPlayer, 21, 0)
		setPedStat(localPlayer, 23, 0)
		
	-- Unlimited health
	elseif cheat == 15 or cheat == 16 then
		unlimitedHealth = not unlimitedHealth
		
	-- All cars have nitrous
	elseif cheat == 17 or cheat == 18 then	
		allCarsHaveNitro = not allCarsHaveNitro
	
	-- Cars drive on water
	elseif cheat == 19 or cheat == 20 then
		setWorldSpecialPropertyEnabled("hovercars", not isWorldSpecialPropertyEnabled("hovercars"))
	
	-- Flying cars
	elseif cheat == 21 or cheat == 22 then
		setWorldSpecialPropertyEnabled("aircars", not isWorldSpecialPropertyEnabled("aircars"))
		
	-- Spawn Bloodring Banger
	elseif cheat == 23 or cheat == 24 then 
		setElementData(localPlayer, "changecar", 504)
		
	-- Spawn Caddy
	elseif cheat == 25 or cheat == 26 then 
		setElementData(localPlayer, "changecar", 457)
		
	-- Spawn Dozer
	elseif cheat == 27 or cheat == 28 then 
		setElementData(localPlayer, "changecar", 486)
	
	-- Spawn Hunter
	elseif cheat == 29 or cheat == 30 then 
		setElementData(localPlayer, "changecar", 425)
		
	-- Spawn Hydra
	elseif cheat == 31 or cheat == 32 then 
		setElementData(localPlayer, "changecar", 520)
		
	-- Spawn Monster Truck
	elseif cheat == 33 or cheat == 34 then 
		setElementData(localPlayer, "changecar", 556)
		
	-- Spawn Quad
	elseif cheat == 35 or cheat == 36 then 
		setElementData(localPlayer, "changecar", 471)
		
	-- Spawn Hotring Racer
	elseif cheat == 37 or cheat == 38 then 
		setElementData(localPlayer, "changecar", 502)
		
	-- Spawn Hotring Racer 2
	elseif cheat == 39 or cheat == 40 then 
		setElementData(localPlayer, "changecar", 503)
		
	-- Spawn Rancher
	elseif cheat == 41 or cheat == 42 then 
		setElementData(localPlayer, "changecar", 505)
		
	-- Spawn Rhino
	elseif cheat == 13 or cheat == 44 then 
		setElementData(localPlayer, "changecar", 432)
		
	-- Spawn Romero
	elseif cheat == 45 or cheat == 46 then 
		setElementData(localPlayer, "changecar", 442)
		
	-- Spawn Stretch
	elseif cheat == 47 or cheat == 48 then 
		setElementData(localPlayer, "changecar", 409)
		
	-- Spawn Stunt Plane
	elseif cheat == 49 or cheat == 50 then 
		setElementData(localPlayer, "changecar", 513)
		
	-- Spawn Tanker
	elseif cheat == 51 or cheat == 52 then 
		setElementData(localPlayer, "changecar", 514)
		
	-- Spawn Trashmaster
	elseif cheat == 53 or cheat == 54 then 
		setElementData(localPlayer, "changecar", 408)
		
	-- Spawn Vortex
	elseif cheat == 55 or cheat == 56 then 
		setElementData(localPlayer, "changecar", 539)
	
	-- Massive bicycle bunny hops
	elseif cheat == 57 or cheat == 58 then
		setWorldSpecialPropertyEnabled("extrabunny", not isWorldSpecialPropertyEnabled("extrabunny"))
	
	-- Black traffic
	elseif cheat == 59 or cheat == 60 then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setVehicleColor(vehicles, 0, 0, 0, 0)
		end
	
	-- Pedestrians are Elvis
	elseif cheat == 61 or cheat == 62 then
		for index, peds in ipairs(getElementsByType("player")) do
			setElementModel(peds, 83)
		end
		
	-- Pink traffic
	elseif cheat == 63 or cheat == 64 then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setVehicleColor(vehicles, 126, 126, 126, 126)
		end
	
	-- Always midnight (00:00)
	elseif cheat == 65 or cheat == 66 then
		alwaysMidnight = not alwaysMidnight
		alwaysEvening = false
		speedTime = false
	
	-- Always evening (21:00)
	elseif cheat == 67 or cheat == 68 then
		alwaysEvening = not alwaysEvening
		alwaysMidnight = false
		speedTime = false
		
	-- Cloudy weather
	elseif cheat == 69 or cheat == 70 then
		setWeather(4)
		
	-- Fast gameplay
	elseif cheat == 71 or cheat == 72 then
		if getGameSpeed()*2 > 10 then setGameSpeed(10)
		else setGameSpeed(getGameSpeed()*2) end
		
	-- Slow gameplay
	elseif cheat == 73 or cheat == 74 then
		setGameSpeed(getGameSpeed()/2)	
		
	-- Speed up time
	elseif cheat == 75 or cheat == 76 then
		alwaysEvening = false
		alwaysMidnight = false
		speedTime = not speedTime
	
	-- Explode
	elseif cheat == 77 or cheat == 78 then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			blowVehicle(vehicles)
		end
	
	-- Foggy weather
	elseif cheat == 79 or cheat == 80 then
		setWeather(9)
		
	-- Overcast weather
	elseif cheat == 81 or cheat == 82 then
		setWeather(15)
		
	-- Sandstorm
	elseif cheat == 83 or cheat == 84 then
		setWeather(19)
		
	-- Rainy weather
	elseif cheat == 85 or cheat == 86 then
		setWeather(8)
		
	-- Stormy weather
	elseif cheat == 87 or cheat == 88 then
		setWeather(16)
		
	-- Sunny weather
	elseif cheat == 89 or cheat == 90 then
		setWeather(18)
		
	-- Very sunny weather
	elseif cheat == 91 or cheat == 92 then
		setWeather(17)
	end
	
	drawHelpText = true
	if isTimer(helpTimer) then killTimer(helpTimer) end
	helpTimer = setTimer(function() drawHelpText = false end, 2000, 1)
	
	local s = playSound("s.mp3")
	setSoundVolume(s, 0.5)
end 

-- Function checks if player is spectating
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 2000 then return true	
	else return false end
end

function update()
	if isLocalPlayerSpectating() then return end
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	if unlimitedHealth then
		setElementHealth(getPedOccupiedVehicle(localPlayer), 1000)
	end
	
	if allCarsHaveNitro then
		if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(localPlayer), 8) ~= 1010 then
			addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1010)
		end
	end
	
	if alwaysMidnight then
		setTime(0, 0)
	end
	
	if alwaysEvening then
		setTime(21, 0)
	end
	
	if speedTime then
		local h, m = getTime()
		setTime(h, m + 1)
	end
end

addEvent("newCheatHandler", true)
addEventHandler("newCheatHandler", getRootElement(), activateCheat)

addEventHandler("onClientKey", root, function(button, press)
	-- start special timer once 
	if not isTimer(updateTimer) then updateTimer = setTimer(update, 20, 0) end
end )

addEventHandler("onClientRender", getRootElement(), function()
	if drawHelpText and not isLocalPlayerSpectating() then 
		dxDrawRectangle(screenX*b_offsets[1], screenY*b_offsets[2], screenX*b_offsets[3], screenY*b_offsets[4], tocolor(0, 0, 0, 175)) -- border 0.012, 0.163
		dxDrawText("Cheat activated!", screenX*t_offsets[1], screenY*t_offsets[2], 800, screenY, tocolor(155, 155, 155, 255), 2, "default-bold")
	end
end )

addEventHandler("onClientPlayerSpawn", localPlayer, function()
	setGameSpeed(1)
	setPlayerHudComponentVisible("money", true)
end )
