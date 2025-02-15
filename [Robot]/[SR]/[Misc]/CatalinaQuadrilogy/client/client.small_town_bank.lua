local SmallTownBank = {
    MISSION_ID = 'small_town_bank',
    catalinaBlip = nil,
    catalinaMarker = Marker(1296.5, 246.1, 16.6, 'cylinder', 7, 255, 0, 0, 0),
    finishMarker = Marker(867, -32.1, 62.1, 'cylinder', 3, 255, 0, 0, 0)
}

SmallTownBank.startMission = function(missionID)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    SmallTownBank.catalinaMarker:setColor(255, 0, 0, 128)
    SmallTownBank.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', SmallTownBank.catalinaMarker, SmallTownBank.onClientMarkerHit)
    removeEventHandler('onClientMarkerHit', SmallTownBank.finishMarker, SmallTownBank.onClientMarkerHit)
    addEventHandler('onClientMarkerHit', SmallTownBank.catalinaMarker, SmallTownBank.onClientMarkerHit)
    addEventHandler('onClientMarkerHit', SmallTownBank.finishMarker, SmallTownBank.onClientMarkerHit)
end
addEvent('cat_quad:start_mission', true)
addEventHandler('cat_quad:start_mission', resourceRoot, SmallTownBank.startMission)

SmallTownBank.endMission = function(missionID, success)
    if missionID ~= SmallTownBank.MISSION_ID then
        return
    end

    if isElement(SmallTownBank.catalinaBlip) then
        SmallTownBank.catalinaBlip:destroy()
    end
    SmallTownBank.catalinaBlip = nil

    SmallTownBank.catalinaMarker:setColor(255, 0, 0, 0)
    SmallTownBank.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', SmallTownBank.catalinaMarker, SmallTownBank.onClientMarkerHit)
    removeEventHandler('onClientMarkerHit', SmallTownBank.finishMarker, SmallTownBank.onClientMarkerHit)
end
addEvent('cat_quad:end_mission', true)
addEventHandler('cat_quad:end_mission', resourceRoot, SmallTownBank.endMission)

SmallTownBank.modifyCatalinaBlip = function(create)
    if isElement(SmallTownBank.catalinaBlip) then
        SmallTownBank.catalinaBlip:destroy()
        SmallTownBank.catalinaBlip = nil
    end
    if create then
        SmallTownBank.catalinaBlip = Blip(1296.5, 246.1, 16.6, 0)
    end
end
addEvent('cat_quad:catalina_blip', true)
addEventHandler('cat_quad:catalina_blip', resourceRoot, SmallTownBank.modifyCatalinaBlip)

SmallTownBank.onClientMarkerHit = function(element)
    if element.type ~= 'player' then
        return
    end
    local player = element

    if player ~= localPlayer then
        return
    end

    if source == SmallTownBank.catalinaMarker then
        SmallTownBank.catalinaMarker:setColor(255, 0, 0, 0)
        SmallTownBank.finishMarker:setColor(255, 0, 0, 128)
        SmallTownBank.catalinaBlip.position = SmallTownBank.finishMarker.position

        triggerEvent('cat_quad:play_sfx', resourceRoot, 'script', 39, math.random(20, 24))

        playSoundFrontEnd(43)

        triggerServerEvent('cat_quad:spawn_catalina', resourceRoot, localPlayer, true)
        triggerEvent('cat_quad:set_text', resourceRoot, 'Now bring her home!', 5000)
    elseif source == SmallTownBank.finishMarker then
        triggerServerEvent('cat_quad:finish_mission', resourceRoot, localPlayer, SmallTownBank.MISSION_ID)
    end
end
