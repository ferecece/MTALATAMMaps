--[[
==============================================================
		Feel free to use this code for your own map
==============================================================
--]]

local vehicleChangeCP = {2,4,6,8,10,12,14,16} -- IDs of the checkpoints you want to change vehicles
local VehicleList = {438, 600, 527, 525, 421, 580, 458, 568, 516, 561, 575, 517, 482, 526, 470, 576, 579, 416, 549, 558, 427, 400, 551, 566, 599, 507, 555, 489, 533, 518, 445, 405, --Car List, sorted: slow to fast
					 535, 496, 542, 589, 565, 587, 412, 439, 426, 534, 602, 567, 434, 536, 475, 597, 502, 603, 560, 495, 559, 506, 562, 477, 402, 480, 415, 451, 541, 429, 494, 411} --This list may not be good


outputChatBox("Red Markers change your vehicle according to your race position.", getRootElement(), 255, 0, 0, true)
outputChatBox("The faster you are, the slower your car will be.", getRootElement(), 255, 0, 0, true)
if (getPlayerCount() < 2) then
	outputChatBox("You're alone, you get a bad car.", getRootElement(), 0, 120, 120, true)
end

addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", getRootElement(),
	function(checkpoint)
		for i = 0, #vehicleChangeCP do
			if checkpoint == vehicleChangeCP[i] then
				if getPlayerCount() > 1 then
					if (exports["race"]:getPlayerRank(source) == 1) then --if 1st: give worst car (Cabbie)
						calculatedVehicleFromList = 1
					else
						calculatedVehicleFromList = math.floor ((exports["race"]:getPlayerRank(source) -1 ) * (#VehicleList/(getPlayerCount() - 1)) + 0.5) --round result to closest integer
					end
				else
					calculatedVehicleFromList = 34 --car when alone on server (Blista Compact)
				end
					setElementModel(getPedOccupiedVehicle(source), VehicleList[calculatedVehicleFromList]) 
					setVehicleColor(getPedOccupiedVehicle(source), math.random(255), math.random(255), math.random(255), math.random(255), math.random(255), math.random(255))
				break
			end
		end
	end
)

