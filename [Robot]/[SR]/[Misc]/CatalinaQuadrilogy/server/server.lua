local CatalinaQuadrilogy = {
    playerProgress = {},
    playerSpawns = {},
    playerCurrentTask = {},
    playerPreviousVehicle = {},
    missionMap = {
        tanker_commander = true,
        small_town_bank = true,
        liquor_store = true,
        against_all_odds = true
    }
}

CatalinaQuadrilogy.onMarkerHit = function(element)
    if element.type ~= 'player' then
        return
    end

    local player = element
    if not CatalinaQuadrilogy.playerCurrentTask[player] then
        local missionID = source.id:sub(8)
        if not CatalinaQuadrilogy.didPlayerFinishMission(player, missionID) then
            CatalinaQuadrilogy.playerStartMission(player, missionID)
        end
    end
end
addEventHandler('onMarkerHit', resourceRoot, CatalinaQuadrilogy.onMarkerHit)

CatalinaQuadrilogy.didPlayerFinishMission = function(player, missionID)
    if not CatalinaQuadrilogy.playerProgress[player] then
        CatalinaQuadrilogy.playerProgress[player] = {
            count = 0
        }
    end

    return CatalinaQuadrilogy.playerProgress[player][missionID]
end

CatalinaQuadrilogy.playerStartMission = function(player, missionID)
    if not CatalinaQuadrilogy.missionMap[missionID] then
        return
    end

    -- Start script with ID missionID
    -- Use events
    CatalinaQuadrilogy.playerCurrentTask[player] = missionID
    CatalinaQuadrilogy.playerPreviousVehicle[player] = player.vehicle.model
    player.vehicle.frozen = true
    player.vehicle:fix()
    player.vehicle.damageProof = true
    player:fadeCamera(false)
    Timer(
        function()
            if not CatalinaQuadrilogy.playerCurrentTask[player] then
                return
            end

            triggerEvent('cat_quad:start_mission', resourceRoot, player, missionID)
            triggerClientEvent(player, 'cat_quad:start_mission', resourceRoot, missionID)
        end,
        1000,
        1
    )
end

CatalinaQuadrilogy.playerEndMission = function(player, missionID, success)
    if not success then
        triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, missionID, false)

        if player.vehicle then
            player.vehicle.model = CatalinaQuadrilogy.playerPreviousVehicle[player]
        end

        player:fadeCamera(true)
        Timer(
            function()
                if player.vehicle then
                    player.vehicle.frozen = false
                    player.vehicle.damageProof = false
                end
            end,
            500,
            1
        )
    else
        CatalinaQuadrilogy.playerProgress[player].count = CatalinaQuadrilogy.playerProgress[player].count + 1
        CatalinaQuadrilogy.playerProgress[player][missionID] = true
        triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, missionID, true)

        if missionID == 'tanker_commander' then
            player.vehicle.model = 422
            player.vehicle.position = Vector3(-92.9, -1129.3, 1.2)
            player.vehicle.rotation = Vector3(0, 0, 336)
            CatalinaQuadrilogy.playerPreviousVehicle[player] = player.vehicle.model
            CatalinaQuadrilogy.playerSpawns[player] = {
                position = player.vehicle.position,
                rotation = player.vehicle.rotation
            }
        else
            CatalinaQuadrilogy.playerPreviousVehicle[player] = player.vehicle.model
            CatalinaQuadrilogy.playerSpawns[player] = {
                position = player.vehicle.position,
                rotation = player.vehicle.rotation
            }
        end

        player:fadeCamera(true)
        Timer(
            function()
                player.vehicle.frozen = false
                player.vehicle.damageProof = false

                if CatalinaQuadrilogy.playerProgress[player].count == 4 then
                    triggerEvent('onPlayerReachCheckpointInternal', player, 1)
                end
            end,
            500,
            1
        )
    end

    CatalinaQuadrilogy.playerCurrentTask[player] = nil
end
addEvent('cat_quad:end_mission')
addEventHandler('cat_quad:end_mission', resourceRoot, CatalinaQuadrilogy.playerEndMission)

CatalinaQuadrilogy.forcePlayerEndMission = function(player)
    local missionID = CatalinaQuadrilogy.playerCurrentTask[player]
    if missionID == nil then
        return
    end

    triggerEvent('cat_quad:force_fail_mission', resourceRoot, player, missionID)
end

CatalinaQuadrilogy.onPlayerRaceWasted = function()
    CatalinaQuadrilogy.forcePlayerEndMission(source)
end
addEvent('onPlayerRaceWasted', true)
addEventHandler('onPlayerRaceWasted', root, CatalinaQuadrilogy.onPlayerRaceWasted)

CatalinaQuadrilogy.onElementDataChange = function(theKey)
    if getElementType(source) ~= "player" then
        return
    end

    if theKey ~= "race.spectating" then
        return
    end

    CatalinaQuadrilogy.forcePlayerEndMission(source)
end
addEventHandler('onElementDataChange', root, CatalinaQuadrilogy.onElementDataChange)

CatalinaQuadrilogy.onPlayerSpawn = function()
    local player = source

    if CatalinaQuadrilogy.playerProgress[player] and CatalinaQuadrilogy.playerProgress[player].count > 0 then
        Timer(
            function()
                player.vehicle.model = CatalinaQuadrilogy.playerPreviousVehicle[player] or 586
                if CatalinaQuadrilogy.playerSpawns[player] then
                    player.vehicle.position = CatalinaQuadrilogy.playerSpawns[player].position
                    player.vehicle.rotation = CatalinaQuadrilogy.playerSpawns[player].rotation
                end
            end,
            100,
            1
        )
    end
end
addEventHandler('onPlayerSpawn', root, CatalinaQuadrilogy.onPlayerSpawn)
