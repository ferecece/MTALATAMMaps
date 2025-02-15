local oldZ = nil
local zD = 0
local timer = nil
local blowtimer = nil

function updZ()
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	local rX, rY, rZ = getElementRotation(getPedOccupiedVehicle(localPlayer))
	if oldZ ~= nil then 
		zD = math.abs(oldZ - rZ)
		
		if zD > 55 and zD < 300 and not isTimer(blowtimer) then 
			blowVehicle(getPedOccupiedVehicle(localPlayer)) 
			oldZ = nil
			blowtimer = setTimer(function() end, 6000, 1)
		end
	end
	oldZ = rZ
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	outputChatBox("Spin out and your vehicle will blow up!")
	setWorldProperty("Fog", 3)
	setWorldProperty("Foggyness", 2)
	setWorldProperty("RainFog", 3)
	setRainLevel(10)
	
	if isTimer(timer) then killTimer(timer) end
	timer = setTimer(updZ, 500, 0)
end )