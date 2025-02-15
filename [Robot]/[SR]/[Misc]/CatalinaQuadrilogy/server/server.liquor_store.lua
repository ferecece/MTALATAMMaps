local LiquorStore = {
    MISSION_ID = 'liquor_store',
    catalinas = {}
}

LiquorStore.startMission = function(player, missionID)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    player.vehicle.model = 471
    player.vehicle.position = Vector3(248.7, -75.7, 1)
    player.vehicle.rotation = Vector3(0, 0, 270)
    player.vehicle.velocity = Vector3(0, 0, 0)

    LiquorStore.spawnCatalina(player, true)

    triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, 'Pick up the briefcases!', 5000)

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
addEventHandler('cat_quad:start_mission', resourceRoot, LiquorStore.startMission)

LiquorStore.failMission = function(player, missionID, force)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    if force then
        LiquorStore.spawnCatalina(player, false)

        triggerEvent('cat_quad:end_mission', resourceRoot, player, LiquorStore.MISSION_ID, false)
    else
        Timer(
            function()
                player:fadeCamera(false)
                Timer(
                    function()
                        LiquorStore.spawnCatalina(player, false)

                        triggerEvent('cat_quad:end_mission', resourceRoot, player, LiquorStore.MISSION_ID, false)
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

LiquorStore.forceFailMission = function(player, missionID)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, LiquorStore.MISSION_ID, false)
    LiquorStore.failMission(player, missionID, true)
end
addEvent('cat_quad:force_fail_mission')
addEventHandler('cat_quad:force_fail_mission', resourceRoot, LiquorStore.forceFailMission)

LiquorStore.finishMission = function(player, missionID)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    -- Player is spectating or above 30k height (fallback)
    if getElementData(player, "race.spectating") == true or player.position.z > 30000 then
        return
    end

    player.vehicle.frozen = true
    player:fadeCamera(false)
    Timer(
        function()
            LiquorStore.spawnCatalina(player, false)

            player.vehicle.model = 402

            triggerEvent('cat_quad:end_mission', resourceRoot, player, LiquorStore.MISSION_ID, true)
        end,
        1000,
        1
    )
end
addEvent('cat_quad:finish_mission', true)
addEventHandler('cat_quad:finish_mission', resourceRoot, LiquorStore.finishMission)

LiquorStore.spawnCatalina = function(player, create)
    if isElement(LiquorStore.catalinas[player]) then
        LiquorStore.catalinas[player]:destroy()
    end
    if not create then
        LiquorStore.catalinas[player] = nil
        return
    end

    LiquorStore.catalinas[player] = Ped(298, 0, 0, 0)
    LiquorStore.catalinas[player]:warpIntoVehicle(player.vehicle, 1)
end
