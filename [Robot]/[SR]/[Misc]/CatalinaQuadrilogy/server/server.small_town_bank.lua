local SmallTownBank = {
    MISSION_ID = 'small_town_bank',
    catalinas = {}
}

SmallTownBank.startMission = function(player, missionID)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    player.vehicle.model = 523
    player.vehicle.position = Vector3(2321.7, 67.6, 26.1)
    player.vehicle.rotation = Vector3(0, 0, 346)
    player.vehicle.velocity = Vector3(0, 0, 0)

    triggerClientEvent(player, 'cat_quad:set_text', resourceRoot, 'Pick up Catalina!', 5000)
    triggerClientEvent(player, 'cat_quad:catalina_blip', resourceRoot, true)

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
addEventHandler('cat_quad:start_mission', resourceRoot, SmallTownBank.startMission)

SmallTownBank.failMission = function(player, missionID, force)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    if force then
        SmallTownBank.spawnCatalina(player, false)

        triggerEvent('cat_quad:end_mission', resourceRoot, player, SmallTownBank.MISSION_ID, false)
    else
        Timer(
            function()
                player:fadeCamera(false)
                Timer(
                    function()
                        SmallTownBank.spawnCatalina(player, false)

                        triggerEvent('cat_quad:end_mission', resourceRoot, player, SmallTownBank.MISSION_ID, false)
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

SmallTownBank.forceFailMission = function(player, missionID)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    triggerClientEvent(player, 'cat_quad:end_mission', resourceRoot, SmallTownBank.MISSION_ID, false)
    SmallTownBank.failMission(player, missionID, true)
end
addEvent('cat_quad:force_fail_mission')
addEventHandler('cat_quad:force_fail_mission', resourceRoot, SmallTownBank.forceFailMission)

SmallTownBank.finishMission = function(player, missionID)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    -- Player is spectating or above 30k height (fallback)
    if getElementData(player, "race.spectating") == true or player.position.z > 30000 then
        return
    end

    triggerClientEvent(player, 'cat_quad:catalina_blip', resourceRoot, false)

    player.vehicle.frozen = true
    player:fadeCamera(false)
    Timer(
        function()
            SmallTownBank.spawnCatalina(player, false)

            triggerEvent('cat_quad:end_mission', resourceRoot, player, SmallTownBank.MISSION_ID, true)
        end,
        1000,
        1
    )
end
addEvent('cat_quad:finish_mission', true)
addEventHandler('cat_quad:finish_mission', resourceRoot, SmallTownBank.finishMission)

SmallTownBank.spawnCatalina = function(player, create)
    if isElement(SmallTownBank.catalinas[player]) then
        SmallTownBank.catalinas[player]:destroy()
    end
    if not create then
        SmallTownBank.catalinas[player] = nil
        return
    end

    SmallTownBank.catalinas[player] = Ped(298, 0, 0, 0)
    SmallTownBank.catalinas[player]:warpIntoVehicle(player.vehicle, 1)
end
addEvent('cat_quad:spawn_catalina', true)
addEventHandler('cat_quad:spawn_catalina', resourceRoot, SmallTownBank.spawnCatalina)
