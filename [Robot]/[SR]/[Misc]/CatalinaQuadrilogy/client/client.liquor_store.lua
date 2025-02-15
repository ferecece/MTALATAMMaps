local LiquorStore = {
    MISSION_ID = 'liquor_store',
    data = {
        briefcases = {
            Object(1210, 500.5, 50.4, 18.9),
            Object(1210, 1216.5, 113, 22.1),
            Object(1210, 924.4, 194.5, 34.6)
        },
        blips = {
            Blip(500.5, 50.4, 18.9, 0, 2, 255, 255, 0, 0),
            Blip(1216.5, 113, 22.1, 0, 2, 255, 255, 0, 0),
            Blip(924.4, 194.5, 34.6, 0, 2, 255, 255, 0, 0)
        },
        colSpheres = {
            ColShape.Sphere(500.5, 50.4, 18.9, 3.5),
            ColShape.Sphere(1216.5, 113, 22.1, 3.5),
            ColShape.Sphere(924.4, 194.5, 34.6, 3.5)
        },
        pickedUp = 0
    },
    finishBlip = nil,
    finishMarker = Marker(867, -32.1, 62.1, 'cylinder', 3, 255, 0, 0, 0)
}

for i, pickup in pairs(LiquorStore.data.briefcases) do
    pickup.dimension = 1
end
for i, colSphere in pairs(LiquorStore.data.colSpheres) do
    colSphere.dimension = 1
end

local startTick = getTickCount()

LiquorStore.startMission = function(missionID)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    for i, pickup in pairs(LiquorStore.data.briefcases) do
        pickup.dimension = 0
    end

    for i, blip in pairs(LiquorStore.data.blips) do
        blip:setColor(255, 255, 0, 255)
    end
    for i, colSphere in pairs(LiquorStore.data.colSpheres) do
        colSphere.dimension = 0
    end

    if isElement(LiquorStore.finishBlip) then
        LiquorStore.finishBlip:destroy()
    end
    LiquorStore.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', LiquorStore.finishMarker, LiquorStore.onClientMarkerHit)
end
addEvent('cat_quad:start_mission', true)
addEventHandler('cat_quad:start_mission', resourceRoot, LiquorStore.startMission)

LiquorStore.endMission = function(missionID, success)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    for i, pickup in pairs(LiquorStore.data.briefcases) do
        pickup.dimension = 1
    end
    for i, blip in pairs(LiquorStore.data.blips) do
        blip:setColor(255, 255, 0, 0)
    end
    for i, colSphere in pairs(LiquorStore.data.colSpheres) do
        colSphere.dimension = 1
    end

    if isElement(LiquorStore.finishBlip) then
        LiquorStore.finishBlip:destroy()
    end
    LiquorStore.finishMarker:setColor(255, 0, 0, 0)

    removeEventHandler('onClientMarkerHit', LiquorStore.finishMarker, LiquorStore.onClientMarkerHit)
end
addEvent('cat_quad:end_mission', true)
addEventHandler('cat_quad:end_mission', resourceRoot, LiquorStore.endMission)

LiquorStore.showFinishMarker = function(missionID)
    if missionID ~= LiquorStore.MISSION_ID then
        return
    end

    LiquorStore.finishBlip = Blip(867, -32.1, 62.1)
    LiquorStore.finishMarker:setColor(255, 0, 0, 128)

    addEventHandler('onClientMarkerHit', LiquorStore.finishMarker, LiquorStore.onClientMarkerHit)
end

LiquorStore.onClientColShapeHit = function(player, matchingDimension)
    if player ~= localPlayer then
        return
    end

    if not matchingDimension then
        return
    end

    for i, colSphere in pairs(LiquorStore.data.colSpheres) do
        if colSphere == source then
            local briefcase = LiquorStore.data.briefcases[i]
            local blip = LiquorStore.data.blips[i]

            briefcase.dimension = 1
            blip:setColor(255, 255, 0, 0)
            colSphere.dimension = 1

            playSoundFrontEnd(43)

            LiquorStore.data.pickedUp = LiquorStore.data.pickedUp + 1
            if LiquorStore.data.pickedUp == 3 then
                triggerEvent('cat_quad:set_text', resourceRoot, 'Now bring her home!', 5000)
                triggerEvent('cat_quad:play_sfx', resourceRoot, 'script', 39, math.random(20, 24))
                LiquorStore.showFinishMarker(LiquorStore.MISSION_ID)
            end
        end
    end
end
addEventHandler('onClientColShapeHit', resourceRoot, LiquorStore.onClientColShapeHit)

LiquorStore.onClientMarkerHit = function(element)
    if element.type ~= 'player' then
        return
    end
    local player = element

    if player ~= localPlayer then
        return
    end

    triggerServerEvent('cat_quad:finish_mission', resourceRoot, localPlayer, LiquorStore.MISSION_ID)
end

LiquorStore.updatePickupRotation = function()
    local angle = math.fmod((getTickCount() - startTick) * 360 / 2000, 360)
    for i, briefcase in pairs(LiquorStore.data.briefcases) do
        briefcase.rotation = Vector3(0, 0, angle)
    end
end
addEventHandler('onClientRender', root, LiquorStore.updatePickupRotation)
