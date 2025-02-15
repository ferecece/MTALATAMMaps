local pedFindBlips = {}
local peds = {}
local loaded = false
local pedUpdateLimits = {}

-- limit how many animations can be broadcast to avoid spam
local function canSendPedUpdate(ped)
	if isPedDead(ped) then
		return false
	end

	local current = pedUpdateLimits[ped] or 0

	if current > 10 then
		return false
	end

	pedUpdateLimits[ped] = current + 1

	return true
end

local function startPedRequestListener()
	addEvent(g_REQUEST_SPAWN_PED_EVENT, true)
	addEventHandler(g_REQUEST_SPAWN_PED_EVENT, getRootElement(), function()
		local ped = createPed(16, 1248, -1337, 15) -- park opposite police station
		setElementHealth(ped, 60)
		setElementSyncer(ped, client, true)
		peds[#peds + 1] = ped

		setPlayerTeam(client, g_PedTeam)
		triggerClientEvent(client, g_SPAWN_PLAYER_PED_EVENT, resourceRoot, ped)
	end)

	-- forward control state information to everyone
	addEvent(g_PED_CONTROL_UPDATE_EVENT, true)
	addEventHandler(g_PED_CONTROL_UPDATE_EVENT, resourceRoot, function(ped, control, status)
		if canSendPedUpdate(ped) then
			triggerClientEvent(g_PED_CONTROL_UPDATE_EVENT, resourceRoot, ped, control, status)
		end
	end)

	addEvent(g_PED_ANIMATION_EVENT, true)
	addEventHandler(g_PED_ANIMATION_EVENT, resourceRoot, function(ped, block, anim)
		if canSendPedUpdate(ped) then
			triggerClientEvent(g_PED_ANIMATION_EVENT, resourceRoot, ped, block, anim)
		end
	end)

	addEvent(g_PED_MOVEMENT_EVENT, true)
	addEventHandler(g_PED_MOVEMENT_EVENT, resourceRoot, function(ped, pos, rot)
		if canSendPedUpdate(ped) then
			triggerClientEvent(g_PED_MOVEMENT_EVENT, resourceRoot, ped, pos, rot)
		end
	end)

	setTimer(function()
		-- cleanup ped blips
		for _, blip in ipairs(pedFindBlips) do
			destroyElement(blip)
		end

		pedFindBlips = {}
		for _, ped in ipairs(peds) do
			if not isPedDead(ped) then
				-- detect nearby players
				local x, y, z = getElementPosition(ped)
				local detection = getElementsWithinRange(x, y, z, 50, "vehicle")
				for _, vehicle in ipairs(detection) do
					local player = getVehicleOccupant(vehicle)
					if player then
						if getPlayerTeam(player) == g_CriminalTeam then
							pedFindBlips[#pedFindBlips + 1] = createBlipAttachedTo(vehicle, 0, 2, 150, 0, 200, 255, 6, 80085)
						else
							pedFindBlips[#pedFindBlips + 1] = createBlipAttachedTo(vehicle, 0, 2, 30, 190, 240, 255, 6, 80085)
						end
					end
				end

				-- allow more actions every interval, currently 3 per second with generous cap
				pedUpdateLimits[ped] = math.max(0, (pedUpdateLimits[ped] or 1) - 5)
			end
		end
	end, 1000, 0)

	triggerClientEvent(getRootElement(), g_PED_GAME_READY_EVENT, resourceRoot)
end

local function startPickupListener()
	-- should only be 1 pickup anyways
	for _, element in ipairs(getElementsByType("pickup", mapRoot)) do
		local x, y, z = getElementPosition(element)
		local colShape = createColSphere(x, y, z, 1)
		addEventHandler("onColShapeHit", colShape, function(hitElement)
			if getElementType(hitElement) == "ped" then
				giveWeapon(hitElement, 10, 1, true)
				setElementPosition(hitElement, 1248, -1337, 15)
			end
		end)
	end
end

addEvent(g_GAME_STATE_UPDATE_EVENT)
addEventHandler(g_GAME_STATE_UPDATE_EVENT, resourceRoot, function(state)
	if state == g_COREGAME_STATE and loaded == false then
		loaded = true
		startPedRequestListener()
		startPickupListener()
	end
end)


--hay1 z-3" breakable="true"  posX="1318.8164" posY="-1328.918" posZ="78"
--hay2 z-3" breakable="true"  posX="1314.7813" posY="-1328.902" posZ="57"
--hay3 x+3" breakable="true"  posX="1314.7813" posY="-1328.901" posZ="48"
--hay4 z-3" breakable="true"  posX="1314.7813" posY="-1320.879" posZ="48"
--hay5 z+3" breakable="true"  posX="1318.7979" posY="-1320.879" posZ="63"
--hay6 x-4" breakable="true"  posX="1322.8242" posY="-1320.879" posZ="72"
--hay7 z-3" breakable="true"  posX="1318.8115" posY="-1324.904" posZ="45"


-- ped easter egg hay climb
function pedHayClimb()
    hay1 = createObject(3374, 1318.8164, -1328.918, 78, 0, 0, 0)
    hay2 = createObject(3374, 1314.7813, -1328.902, 57, 0, 0, 0)
    hay3 = createObject(3374, 1314.7813, -1328.901, 48, 0, 0, 0)
    hay4 = createObject(3374, 1314.7813, -1320.879, 48, 0, 0, 0)
    hay5 = createObject(3374, 1318.7979, -1320.879, 63, 0, 0, 0)
	hay6 = createObject(3374, 1322.8242, -1320.879, 72, 0, 0, 0)
    hay7 = createObject(3374, 1318.8115, -1324.904, 45, 0, 0, 0)
	hay8 = createObject(3374, 1322.8203, -1328.918, 54, 0, 0, 0)
	hay9 = createObject(3374, 1314.7832, -1320.878, 75, 0, 0, 0)
	hay10 = createObject(3374, 1322.8210, -1324.901, 48, 0, 0, 0)
	moveHay1(1)
	moveHay2(1)
	moveHay3(1)
	moveHay4(1)
	moveHay5(1)
	moveHay6(1)
	moveHay7(1)
	moveHay8(1)
	moveHay9(1)
	moveHay10(1)
end
addEventHandler("onResourceStart", resourceRoot, pedHayClimb)

function moveHay1(point)
    if point == 1 then
        moveObject(hay1, 4000, 1318.8164, -1328.918, 75)
        setTimer(moveHay1, 4000 + 4250, 1, 2)
    elseif point == 2 then
        moveObject(hay1, 4000, 1318.8164, -1328.918, 78)
        setTimer(moveHay1, 4000 + 6160, 1, 1)
    end
end
function moveHay2(point)
    if point == 1 then
        moveObject(hay2, 4000, 1314.7813, -1328.902, 57)
        setTimer(moveHay2, 4000 + 3330, 1, 2)
    elseif point == 2 then
        moveObject(hay2, 4000, 1314.7813, -1328.902, 57)
        setTimer(moveHay2, 4000 + 5110, 1, 1)
    end
end
function moveHay3(point)
    if point == 1 then
        moveObject(hay3, 4000, 1318.7813, -1328.901, 48)
        setTimer(moveHay3, 4000 + 7590, 1, 2)
    elseif point == 2 then
        moveObject(hay3, 4000, 1314.7813, -1328.901, 48)
        setTimer(moveHay3, 4000 + 10850, 1, 1)
    end
end
function moveHay4(point)
    if point == 1 then
        moveObject(hay4, 4000, 1314.7813, -1320.879, 45)
        setTimer(moveHay4, 4000 + 4800, 1, 2)
    elseif point == 2 then
        moveObject(hay4, 4000, 1314.7813, -1320.879, 48)
        setTimer(moveHay4, 4000 + 9710, 1, 1)
    end
end
function moveHay5(point)
    if point == 1 then
        moveObject(hay5, 4000, 1318.7979, -1320.879, 66)
        setTimer(moveHay5, 4000 + 8220, 1, 2)
    elseif point == 2 then
        moveObject(hay5, 4000, 1318.7979, -1320.879, 63)
        setTimer(moveHay5, 4000 + 5550, 1, 1)
    end
end
function moveHay6(point)
    if point == 1 then
        moveObject(hay6, 4000, 1318.8242, -1320.879, 72)
        setTimer(moveHay6, 4000 + 8660, 1, 2)
    elseif point == 2 then
        moveObject(hay6, 4000, 1322.8242, -1320.879, 72)
        setTimer(moveHay6, 4000 + 5690, 1, 1)
    end
end
function moveHay7(point)
    if point == 1 then
        moveObject(hay7, 4000, 1318.8115, -1324.904, 42)
        setTimer(moveHay7, 4000 + 5250, 1, 2)
    elseif point == 2 then
        moveObject(hay7, 4000, 1318.8115, -1324.904, 45)
        setTimer(moveHay7, 4000 + 6160, 1, 1)
    end
end
function moveHay8(point)
    if point == 1 then
        moveObject(hay8, 4000, 1318.8203, -1328.918, 54)
        setTimer(moveHay8, 4000 + 5150, 1, 2)
    elseif point == 2 then
        moveObject(hay8, 4000, 1322.8203, -1328.918, 54)
        setTimer(moveHay8, 4000 + 5770, 1, 1)
    end
end
function moveHay9(point)
    if point == 1 then
        moveObject(hay9, 4000, 1318.7832, -1320.878, 75)
        setTimer(moveHay9, 4000 + 8830, 1, 2)
    elseif point == 2 then
        moveObject(hay9, 4000, 1314.7832, -1320.878, 75)
        setTimer(moveHay9, 4000 + 7350, 1, 1)
    end
end
function moveHay10(point)
    if point == 1 then
        moveObject(hay10, 4000, 1322.8210, -1320.901, 48)
        setTimer(moveHay10, 4000 + 12110, 1, 2)
    elseif point == 2 then
        moveObject(hay10, 4000, 1322.8210, -1324.901, 48)
        setTimer(moveHay10, 4000 + 5690, 1, 1)
    end
end
