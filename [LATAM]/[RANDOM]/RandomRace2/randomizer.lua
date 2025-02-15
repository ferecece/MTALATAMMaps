disallowedVehicle = {
    [511] = true, [594] = true, [501] = true, [465] = true, 
    [449] = true, [537] = true, [460] = true, [538] = true, 
    [570] = true, [569] = true, [590] = true, [472] = true, 
    [473] = true, [493] = true, [595] = true, [484] = true, 
    [430] = true, [453] = true, [452] = true, [446] = true, 
    [454] = true, [577] = true, [606] = true, [432] = true,
    [607] = true, [610] = true, [611] = true, [584] = true, 
    [608] = true, [435] = true, [450] = true, [591] = true,  
    [553] = true, [417] = true, [469] = true, [487] = true, 
    [488] = true, [497] = true, [548] = true, [563] = true,
    [512] = true, [513] = true, [519] = true, [464] = true,
    [592] = true, [593] = true, [447] = true, [425] = true,
    [520] = true, [476] = true
}
 
  
function randomCar(checkpoint, time) 
    local veh = getPedOccupiedVehicle(source)
    local x, y, z = getElementPosition(veh)
    vehicleID = math.random(400, 611)
	while disallowedVehicle[vehicleID] do
		vehicleID = math.random(400, 611)
    end
    setElementPosition(veh, x, y, z+1)
	setElementModel (veh, vehicleID)
end 

function onStateChanged(state)
    if (state == "SomeoneWon") then
        triggerClientEvent("onSomeoneWon", getRootElement(), state)
    end
end

addEvent('onPlayerReachCheckpoint') 
addEvent('onRaceStateChanging') 
addEventHandler('onPlayerReachCheckpoint', getRootElement(), randomCar) 
addEventHandler('onRaceStateChanging', getRootElement(), onStateChanged) 