local TankerCommander = {
    MISSION_ID = 'tanker_commander',
    tankerBlip = nil,
    finishMarker = Marker(-45.7, -1143.7, 0, 'cylinder', 5, 255, 0, 0, 0)
}

TankerCommander.startMission = function(missionID)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    TankerCommander.finishMarker:setColor(255, 0, 0, 128)

    removeEventHandler('onClientMarkerHit', TankerCommander.finishMarker, TankerCommander.onClientMarkerHit)
    addEventHandler('onClientMarkerHit', TankerCommander.finishMarker, TankerCommander.onClientMarkerHit)
end
addEvent('cat_quad:start_mission', true)
addEventHandler('cat_quad:start_mission', resourceRoot, TankerCommander.startMission)

TankerCommander.endMission = function(missionID, success)
    if missionID ~= TankerCommander.MISSION_ID then
        return
    end

    TankerCommander.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', TankerCommander.finishMarker, TankerCommander.onClientMarkerHit)
end
addEvent('cat_quad:end_mission', true)
addEventHandler('cat_quad:end_mission', resourceRoot, TankerCommander.endMission)

TankerCommander.modifyTankerBlip = function(create)
    if isElement(TankerCommander.tankerBlip) then
        TankerCommander.tankerBlip:destroy()
    end
    if create then
        TankerCommander.tankerBlip = Blip(-45.7, -1143.7, 0, 51)
    end
end
addEvent('cat_quad:tanker_blip', true)
addEventHandler('cat_quad:tanker_blip', resourceRoot, TankerCommander.modifyTankerBlip)

TankerCommander.onClientMarkerHit = function(element)
    if element.type ~= 'player' then
        return
    end
    local player = element

    if player ~= localPlayer then
        return
    end

    triggerServerEvent('cat_quad:finish_mission', resourceRoot, localPlayer, TankerCommander.MISSION_ID)
end
