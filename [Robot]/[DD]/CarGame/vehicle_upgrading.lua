-- Baggage -> Blade -> Flash -> Glendale -> Rancher -> Patriot -> Enforcer -> S.W.A.T. -> Dune -> Tug -> Hunter
local tiers = {485, 536, 565, 466, 489, 470, 427, 601, 573, 583, 425}
local markerID = 1
local randomID = 1
local markerBlip

-- Marker array
local markerarray = {{4245.2998046875, -1700.3000488281, 182},
                     {4294, -1669.5, 182},
                     {4192, -1730.099609375, 182},
                     {4243.5, -1758.099609375, 182},
                     {4294.400390625, -1728.7998046875, 182},
                     {4242.6005859375, -1640.099609375, 182},
                     {4268.3999023438, -1593.8000488281, 182},
                     {4217.8999023438, -1594.3000488281, 182},
                     {4165.2001953125, -1624.5, 182},
                     {4139.3999023438, -1668.6999511719, 182},
                     {4138.7998046875, -1729.3000488281, 182},
                     {4165.7001953125, -1774.4000244141, 182},
                     {4217.6000976563, -1805.1999511719, 182},
                     {4268.1000976563, -1806, 182},
                     {4321.6000976563, -1774.5999755859, 182},
                     {4346.3999023438, -1729.8000488281, 182},
                     {4347, -1669.1999511719, 182},
                     {4321, -1624.8000488281, 182}}

-- Create first marker middle of the map
function mapSetup()
    createMarker(markerarray[1][1],markerarray[1][2],markerarray[1][3],"checkpoint",3)
    markerBlip = createBlip(markerarray[1][1],markerarray[1][2],markerarray[1][3],0,2,0,0,255)
    outputChatBox ( "#FF0000Go to checkpoints to upgrade your vehicle tier! Survive the Tug tier to get a Hunter!", getRootElement(), 255, 255, 255, true )
end

-- Create new random markerID
function randomNumber()
    while(markerID == randomID)
    do
        randomID = math.random(1,18)
    end
    markerID = randomID
end

-- Create random marker to map
function createMarkerToMap()
    randomNumber()
    local x, y, z = markerarray[markerID][1], markerarray[markerID][2], markerarray[markerID][3]
    createMarker(x,y,z,"checkpoint",3)
    destroyElement(markerBlip)
    markerBlip = createBlip(x,y,z,0,2,0,0,255)
end

-- Do this when marker is hit
function onMarkerHit_S(hit)
    if getElementType(hit) == "vehicle" then
        local local_x, local_y, local_z = getElementPosition(hit)
        local currentvehicleID = getElementModel(hit)
        local nextvehicletier = 0

        destroyElement(source)
        -- Loop to upgrade car tier
        for tierID = 1, 10, 1
        do
            if currentvehicleID == 425 then
                nextvehicletier = 0
                break
            elseif currentvehicleID == tiers[tierID] then
                nextvehicletier = tierID + 1
                break
            end
        end
        -- Set new car and reset marker
        if nextvehicletier == 11 then
            local_x, local_y, local_z = 4106, -1702, 195 -- Put Hunter to the platform
            setElementVelocity(hit, 0, 0, 0)
            setElementRotation(hit, 0, 0, 270)
        end
        if nextvehicletier ~= 0 then
            setElementModel(hit, tiers[nextvehicletier])
            setElementPosition(hit, local_x, local_y, local_z + 1)
        end
        setTimer(createMarkerToMap, 100, 1)
    end
end

addEventHandler("onResourceStart", getResourceRootElement(), mapSetup)
addEventHandler("onMarkerHit", getRootElement(), onMarkerHit_S)