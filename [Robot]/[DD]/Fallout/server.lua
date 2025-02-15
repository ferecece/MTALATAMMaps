
-- Settings
local start_x = -2400
local start_y = 2100
local start_z = 30
local length = 15

-- Automated
local size = length * 9
local fields = math.max(math.floor(size / 40) - 1, 1)
local half = fields / 2
local radius = size / 2 + 2.5
local center_x = start_x + radius - 7
local center_y = start_y - radius + 7 

-- Runtime
local spawn = {}
local field = {}

addEventHandler("onResourceStart", resourceRoot,
    function ()
        -- Playfields
        for x = 1, length do
            for y = 1, length do
                field[#field + 1] = createObject(3095, start_x + ((x - 1) * 9), start_y - ((y - 1) * 9), start_z)
            end
        end

        -- Spawnfields
        for r = 90, 360, 90 do
            local radian = math.rad(r)

            for a = -half, half do
                for b = 0, 2 do
                    local x = center_x + math.cos(radian) * (radius + 5.13 * b) + a * 40 * math.sin(radian)
                    local y = center_y + math.sin(radian) * (radius + 5.13 * b) + a * 40 * math.cos(radian)
                    spawn[#spawn + 1] = createObject(3458, x, y, 29, 0, 0, r - 90)
                end
            end
        end
    end
)

addEventHandler("onResourceStop", resourceRoot,
    function ()
        -- Destroy playfields
        for index = 1, #field do
            if isElement(field[index]) then
                destroyElement(field[index])
            end
        end

        destroySpawnfields()
    end
)

function destroySpawnfields()
    -- Destroy spawnfields
    for index = 1, #spawn do
        if isElement(spawn[index]) then
            destroyElement(spawn[index])
        end
    end
end

addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", root,
    function (new,old)
        if new ~= "Running" or old ~= "GridCountdown" then
            return
        end

        setTimer(startRound, 20000, 1)
        triggerLatentClientEvent("Map:onRoundStart", resourceRoot)
    end
)

function playSoundForEveryone(file, x, y, z)
    triggerLatentClientEvent("Map:onSoundPlay", resourceRoot, file, x, y, z)
end

function startRound()
    destroySpawnfields()
    dropOneField()
end

local intervention = {
    [2] = {500, 1000},
    [3] = {500, 1300},
    [4] = {500, 1500},
    [5] = {800, 1800},
}

function dropOneField()
    if #field == 0 then
        return
    end

    local object = table.remove(field, math.random(#field))
    local x, y, z = getElementPosition(object)

    playSoundForEveryone("tiptoe.wav", x, y, z)

    setTimer(
        function ()
            if isElement(object) then
                moveObject(object, 100, x, y, z, 5, 5, 10)
                setTimer(
                    function ()
                        if isElement(object) then
                            moveObject(object, 100, x, y, z, -5, -5, -10)
                        end
                    end,
                100, 1)
            end
        end, 
    200, 10)

    setTimer(
        function ()
            if isElement(object) then
                playSoundForEveryone("falling.mp3", x, y, z)
                moveObject(object, 800, x, y, -3, 0, 0, 0, "InBack")
            end
        end,
    2500, 1)

    setTimer(
        function ()
            if isElement(object) then
                destroyElement(object)
            end
        end,
    3500, 1)

    if #field > 0 then
        local int = intervention[#getAlivePlayers()] or {1000, 2000}
        setTimer(dropOneField, math.random(int[1], int[2]), 1)
    end
end
