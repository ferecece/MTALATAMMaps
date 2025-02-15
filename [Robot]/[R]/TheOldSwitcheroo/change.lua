addEventHandler("onPlayerJoin",root,
function ()
	bindKey(source,"m","down",carSwap)
	bindKey(source,"2","down",carSwap)
	bindKey(source,"lctrl","down",carSwap)
	bindKey(source,"rctrl","down",carSwap)
	bindKey(source,"mouse2","down",carSwap)
end)

addEventHandler("onResourceStart",resourceRoot,
function ()
	for index, player in ipairs(getElementsByType("player")) do	
	bindKey(player,"m","down",carSwap)
	bindKey(player,"2","down",carSwap)
	bindKey(player,"lctrl","down",carSwap)
	bindKey(player,"rctrl","down",carSwap)
	bindKey(player,"mouse2","down",carSwap)
	end
end)
	 
function carSwap(player)
	local veh = getPedOccupiedVehicle(player)
	local id = getElementModel (veh)
	if id == 495 or id == 411 then
		if (veh) then
			local x,y,z = getElementPosition(veh)
			setElementModel (veh, 446)
			setElementPosition (veh, x, y, z+1)
			 if getVehicleController(veh) == player then 
				local xr,yr,zr = getElementRotation(veh)
				setElementRotation (veh, 0, yr, zr)
			end
			removeVehicleUpgrade (veh, 1010)
		end
	else
		if (veh) then
			local x,y,z = getElementPosition(veh)
			setElementModel (veh, 495)
			setElementPosition (veh, x, y, z+1)
		end
	end
end

function repairCar(checkpoint)
	local vehh = getPedOccupiedVehicle(source)
	fixVehicle (vehh)
	local upgrade = getVehicleUpgradeOnSlot (vehh, 8)
    if (upgrade ~= 1010) then
		addVehicleUpgrade (vehh, 1010)
    end
end
addEvent('onPlayerReachCheckpoint')
addEventHandler('onPlayerReachCheckpoint', getRootElement(), repairCar)

--446 = squalo
--495 = sandking
--411 = infernus