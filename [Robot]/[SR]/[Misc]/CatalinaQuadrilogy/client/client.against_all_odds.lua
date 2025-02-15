local AgainstAllOdds = {
    MISSION_ID = 'against_all_odds',
    data = {
        bribes = {
            Pickup(859.3, 347.9, 19.9, 3, 1247),
            Pickup(292.3, 110.7, 4.3, 3, 1247),
            Pickup(85.1, -127.8, 1.2, 3, 1247),
            Pickup(261.7, -149.3, 1.6, 3, 1247)
        },
        blips = {
            Blip(859.3, 347.9, 19.9, 0, 2, 255, 255, 0, 0),
            Blip(292.3, 110.7, 4.3, 0, 2, 255, 255, 0, 0),
            Blip(85.1, -127.8, 1.2, 0, 2, 255, 255, 0, 0),
            Blip(261.7, -149.3, 1.6, 0, 2, 255, 255, 0, 0)
        },
        colSpheres = {
            ColShape.Sphere(859.3, 347.9, 19.9, 3.5),
            ColShape.Sphere(292.3, 110.7, 4.3, 3.5),
            ColShape.Sphere(85.1, -127.8, 1.2, 3.5),
            ColShape.Sphere(261.7, -149.3, 1.6, 3.5)
        }
    },
    finishBlip = nil,
    finishMarker = Marker(867, -32.1, 62.1, 'cylinder', 3, 255, 0, 0, 0)
}

for i, pickup in pairs(AgainstAllOdds.data.bribes) do
    pickup.dimension = 1
end
for i, colSphere in pairs(AgainstAllOdds.data.colSpheres) do
    colSphere.dimension = 1
end

AgainstAllOdds.startMission = function(missionID)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    for i, pickup in pairs(AgainstAllOdds.data.bribes) do
        pickup.dimension = 0
    end

    for i, blip in pairs(AgainstAllOdds.data.blips) do
        blip:setColor(255, 255, 0, 255)
    end
    for i, colSphere in pairs(AgainstAllOdds.data.colSpheres) do
        colSphere.dimension = 0
    end

    if isElement(AgainstAllOdds.finishBlip) then
        AgainstAllOdds.finishBlip:destroy()
    end
    AgainstAllOdds.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', AgainstAllOdds.finishMarker, AgainstAllOdds.onClientMarkerHit)
end
addEvent('cat_quad:start_mission', true)
addEventHandler('cat_quad:start_mission', resourceRoot, AgainstAllOdds.startMission)

AgainstAllOdds.endMission = function(missionID, success)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    for i, pickup in pairs(AgainstAllOdds.data.bribes) do
        pickup.dimension = 1
    end
    for i, blip in pairs(AgainstAllOdds.data.blips) do
        blip:setColor(255, 255, 0, 0)
    end
    for i, colSphere in pairs(AgainstAllOdds.data.colSpheres) do
        colSphere.dimension = 1
    end

    if isElement(AgainstAllOdds.finishBlip) then
        AgainstAllOdds.finishBlip:destroy()
    end
    AgainstAllOdds.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', AgainstAllOdds.finishMarker, AgainstAllOdds.onClientMarkerHit)
end
addEvent('cat_quad:end_mission', true)
addEventHandler('cat_quad:end_mission', resourceRoot, AgainstAllOdds.endMission)

AgainstAllOdds.showFinishMarker = function(missionID)
    if missionID ~= AgainstAllOdds.MISSION_ID then
        return
    end

    AgainstAllOdds.finishBlip = Blip(867, -32.1, 62.1)
    AgainstAllOdds.finishMarker:setColor(255, 0, 0, 128)

    addEventHandler('onClientMarkerHit', AgainstAllOdds.finishMarker, AgainstAllOdds.onClientMarkerHit)
end
addEvent('cat_quad:show_finish_marker', true)
addEventHandler('cat_quad:show_finish_marker', resourceRoot, AgainstAllOdds.showFinishMarker)

AgainstAllOdds.onClientColShapeHit = function(player, matchingDimension)
    if player ~= localPlayer then
        return
    end

    if not matchingDimension then
        return
    end

    for i, colSphere in pairs(AgainstAllOdds.data.colSpheres) do
        if colSphere == source then
            local bribe = AgainstAllOdds.data.bribes[i]
            local blip = AgainstAllOdds.data.blips[i]

            bribe.dimension = 1
            blip:setColor(255, 255, 0, 0)
            colSphere.dimension = 1

            playSoundFrontEnd(43)

            triggerServerEvent('cat_quad:bribe_pickup', resourceRoot, localPlayer)
        end
    end
end
addEventHandler('onClientColShapeHit', resourceRoot, AgainstAllOdds.onClientColShapeHit)

AgainstAllOdds.onClientMarkerHit = function(element)
    if element.type ~= 'player' then
        return
    end
    local player = element

    if player ~= localPlayer then
        return
    end

    triggerServerEvent('cat_quad:finish_mission', resourceRoot, localPlayer, AgainstAllOdds.MISSION_ID)
end
