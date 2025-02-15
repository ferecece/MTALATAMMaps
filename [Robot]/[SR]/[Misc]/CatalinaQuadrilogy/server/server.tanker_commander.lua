local TankerCommander = {
    MISSION_ID = 'tanker_commander',
    catalinas = {},
}

TankerCommander.startMission = function(player, missionID)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    player.vehicle.model = 514
    player.vehicle.position = Vector3(659, -583.9, 17)
    player.vehicle.rotation = Vector3(0, 0, 180)
    player.vehicle.velocity = Vector3(0, 0, 0)

    TankerCommander.spawnCatalina(player, true)

    triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, 'Deliver the goods', 5000)
    triggerClientEvent(player, 'cat_quad:tanker_blip', resourceRoot, true)
    triggerClientEvent(player, 'cat_quad:play_sfx', resourceRoot, 'script', 37, 11)

    player:fadeCamera(true)
    Timer(
        function()
            if isElement(player.vehicle) then
                player.vehicle.frozen = false
                player.vehicle.damageProof = false
            end
        end,
        1000,
        1
    )
end
addEvent('cat_quad:start_mission')
addEventHandler('cat_quad:start_mission', resourceRoot, TankerCommander.startMission)

TankerCommander.failMission = function(player, missionID, force)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    if force then
        TankerCommander.spawnCatalina(player, false)

        triggerClientEvent(player, 'cat_quad:tanker_blip', resourceRoot, false)
        triggerEvent('cat_quad:end_mission', resourceRoot, player, TankerCommander.MISSION_ID, false)
    else
        Timer(
            function()
                player:fadeCamera(false)
                Timer(
                    function()
                        TankerCommander.spawnCatalina(player, false)

                        triggerClientEvent(player, 'cat_quad:tanker_blip', resourceRoot, false)
                        triggerEvent('cat_quad:end_mission', resourceRoot, player, TankerCommander.MISSION_ID, false)
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

TankerCommander.forceFailMission = function(player, missionID)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, TankerCommander.MISSION_ID, false)
    TankerCommander.failMission(player, missionID, true)
end
addEvent('cat_quad:force_fail_mission')
addEventHandler('cat_quad:force_fail_mission', resourceRoot, TankerCommander.forceFailMission)

TankerCommander.finishMission = function(player, missionID)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    -- Player is spectating or above 30k height (fallback)
    if getElementData(player, "race.spectating") == true or player.position.z > 30000 then
        return
    end

    triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, "You've delivered the goods!", 3000)
    triggerClientEvent(player, 'cat_quad:tanker_blip', resourceRoot, false)

    player.vehicle.frozen = true
    player:fadeCamera(false)
    Timer(
        function()
            TankerCommander.spawnCatalina(player, false)

            triggerEvent('cat_quad:end_mission', resourceRoot, player, TankerCommander.MISSION_ID, true)
        end,
        1000,
        1
    )
end
addEvent('cat_quad:finish_mission', true)
addEventHandler('cat_quad:finish_mission', resourceRoot, TankerCommander.finishMission)

TankerCommander.spawnCatalina = function(player, create)
    if isElement(TankerCommander.catalinas[player]) then
        TankerCommander.catalinas[player]:destroy()
    end

    if not create then
        TankerCommander.catalinas[player] = nil
        return
    end

    TankerCommander.catalinas[player] = Ped(298, 0, 0, 0)
    TankerCommander.catalinas[player]:warpIntoVehicle(player.vehicle, 1)
end