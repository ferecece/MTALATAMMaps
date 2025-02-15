local AgainstAllOdds = {
    MISSION_ID = 'against_all_odds',
    wantedLevels = {},
    catalinas = {}
}

AgainstAllOdds.startMission = function(player, missionID)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    player.vehicle.position = Vector3(1296.3, 276.9, 19.5)
    player.vehicle.rotation = Vector3(0, 0, 156)
    player.vehicle.velocity = Vector3(0, 0, 0)

    AgainstAllOdds.spawnCatalina(player, true)

    triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, 'Lose the heat!', 5000)

    AgainstAllOdds.wantedLevels[player] = 4

    player:fadeCamera(true)
    Timer(
        function()
            player.vehicle.frozen = false
            player.vehicle.damageProof = false
        end,
        1000,
        1
    )
end
addEvent('cat_quad:start_mission')
addEventHandler('cat_quad:start_mission', resourceRoot, AgainstAllOdds.startMission)

AgainstAllOdds.failMission = function(player, missionID, force)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    -- Player is spectating or above 30k height (fallback)
    if getElementData(player, "race.spectating") == true or player.position.z > 30000 then
        return
    end

    AgainstAllOdds.wantedLevels[player] = nil

    if force then
        AgainstAllOdds.spawnCatalina(player, false)

        triggerEvent('cat_quad:end_mission', resourceRoot, player, AgainstAllOdds.MISSION_ID, false)
    else
        Timer(
            function()
                player:fadeCamera(false)
                Timer(
                    function()
                        AgainstAllOdds.spawnCatalina(player, false)

                        triggerEvent('cat_quad:end_mission', resourceRoot, player, AgainstAllOdds.MISSION_ID, false)
                    end,
                    1000,
                    1
                )
            end,
            2000,
            1
        )
    end
end

AgainstAllOdds.forceFailMission = function(player, missionID)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, AgainstAllOdds.MISSION_ID, false)
    AgainstAllOdds.failMission(player, missionID, true)
end
addEvent('cat_quad:force_fail_mission')
addEventHandler('cat_quad:force_fail_mission', resourceRoot, AgainstAllOdds.forceFailMission)

AgainstAllOdds.finishMission = function(player, missionID)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    AgainstAllOdds.wantedLevels[player] = nil

    player.vehicle.frozen = true
    player:fadeCamera(false)
    Timer(
        function()
            AgainstAllOdds.spawnCatalina(player, false)

            triggerEvent('cat_quad:end_mission', resourceRoot, player, AgainstAllOdds.MISSION_ID, true)
        end,
        1000,
        1
    )
end
addEvent('cat_quad:finish_mission', true)
addEventHandler('cat_quad:finish_mission', resourceRoot, AgainstAllOdds.finishMission)

AgainstAllOdds.spawnCatalina = function(player, create)
    if isElement(AgainstAllOdds.catalinas[player]) then
        AgainstAllOdds.catalinas[player]:destroy()
    end
    if not create then
        AgainstAllOdds.catalinas[player] = nil
        return
    end

    AgainstAllOdds.catalinas[player] = Ped(298, 0, 0, 0)
    AgainstAllOdds.catalinas[player]:warpIntoVehicle(player.vehicle, 1)
end

AgainstAllOdds.setPlayerWantedLevels = function()
    for player, wantedLevel in pairs(AgainstAllOdds.wantedLevels) do
        player.wantedLevel = wantedLevel
    end
end
Timer(AgainstAllOdds.setPlayerWantedLevels, 250, 0)

AgainstAllOdds.bribePickup = function(player)
    AgainstAllOdds.wantedLevels[player] = AgainstAllOdds.wantedLevels[player] - 1
    if AgainstAllOdds.wantedLevels[player] == 0 then
        triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, 'Bring her home!', 5000)
        triggerClientEvent(player, 'cat_quad:show_finish_marker', resourceRoot, AgainstAllOdds.MISSION_ID)

        triggerClientEvent(player, 'cat_quad:play_sfx', resourceRoot, 'script', 39, math.random(20, 24))
    end
end
addEvent('cat_quad:bribe_pickup', true)
addEventHandler('cat_quad:bribe_pickup', resourceRoot, AgainstAllOdds.bribePickup)
