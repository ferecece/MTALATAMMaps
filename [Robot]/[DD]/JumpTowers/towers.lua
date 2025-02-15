Dangerouscars = {}
local isMarkerid = 1
Dangerouscars[425] = true
Dangerouscars[520] = true
Dangerouscars[476] = true
Dangerouscars[447] = true
Dangerouscars[432] = true
Dangerouscars[464] = true


disallowedVehicle = {[511] = true, [594] = true, [441] = true, [501] = true, [465] = true, [564] = true, [449] = true, [537] = true, [460] = true, [538] = true, [570] = true, [569] = true, [590] = true, [472] = true, [473] = true, [493] = true, [595] = true, [484] = true, [430] = true, [453] = true, [452] = true, [446] = true, [454] = true, [592] = true, [577] = true, [606] = true, [607] = true, [610] = true, [611] = true, [584] = true, [608] = true, [435] = true, [450] = true, [591] = true, [539] = true, [553] = true, [417] = true, [469] = true, [487] = true,
[488] = true, [497] = true, [563] = true, [460] = true, [511] = true, [512] = true, [513] = true, [519] = true, [553] = true, [592] = true, [593] = true, [464] = true, [447] = true}


function generateZufallCarID ()
	vehicleID = math.random(399, 609)
	if disallowedVehicle[vehicleID] then
		return 451
	else
		return vehicleID
  end
end




function mapISStarting ()
	createMarkerToMap()
end
addEventHandler("onResourceStart",getResourceRootElement(),mapISStarting)

function createMarkerToMap ()
	if isMarkerid == 1 then
		createMarker(6032.7001953125,-1152.2998046875,126.30000305176,"cylinder",5)
	elseif isMarkerid == 2 then
		createMarker(6017.599609375,-1211.599609375,126.30000305176,"cylinder",5)
	elseif isMarkerid == 3 then
		createMarker(6072.3994140625,-1196.099609375,126.30000305176,"cylinder",5)
	elseif isMarkerid == 4 then
		createMarker(5992.2998046875,-1196,126.30000305176,"cylinder",5)
	elseif isMarkerid == 5 then
		createMarker(6047.2001953125,-1180.69921875,126.30000305176,"cylinder",5)
	elseif isMarkerid == 6 then
		createMarker(6032,-1239.599609375,126.30000305176,"cylinder",5)
	else
		isMarkerid = 1
		createMarkerToMap()
	end
end

function onMarkerHit_S ( hit )
	if getElementType(hit ) == "vehicle" then
		local carid = generateZufallCarID()
		local x, y, z = getElementPosition(hit)
		fixVehicle(hit)
		setElementModel(hit, carid)
		setElementPosition(hit, x, y, z + 1)
		if Dangerouscars[carid] then
			outputChatBox("#ff0000Warning - Someone got a " .. getVehicleNameFromModel(carid), getRootElement(), 255, 0, 0, true)
		end
		destroyElement(source)
		isMarkerid = isMarkerid + 1
		createMarkerToMap()
	end
end
addEventHandler("onMarkerHit",getRootElement(),onMarkerHit_S)