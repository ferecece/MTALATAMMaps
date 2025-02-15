
local falled = true

-- Credits
local peds = {}
local plate = {}
local credits = {
    {name = "[SKC]CsenaHUN",    color = tocolor(255, 130, 0), x = -2274, y = 1974, z = 38.95, r = 45, skin = 20},
    {name = "[SKC]botder",    color = tocolor(255, 130, 0), x = -2274, y = 2100, z = 38.95, r = 135, skin = 21},
    {name = "[SKC]Bubu",        color = tocolor(255, 130, 0), x = -2400, y = 1974, z = 38.95, r = -45, skin = 22},
    {name = "[SKC]Abraxas",     color = tocolor(255, 130, 0), x = -2400, y = 2100, z = 38.95, r = -135, skin = 23},
    {name = "[SKC]Tr4veleR",    color = tocolor(255, 130, 0), x = -2400, y = 2030, z = 38.95, r = 270, skin = 24},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        for index, ped in pairs(credits) do
            local id = #peds + 1
            peds[id] = createPed(ped.skin, ped.x, ped.y, ped.z, ped.r)
            setElementCollisionsEnabled(peds[id], false)
            setPedAnimation(peds[id], "RAPPING", "Laugh_01", nil, true)

            local id = #plate + 1
            plate[id] = createObject(1649, ped.x, ped.y, ped.z - 0.95, 90)
            setObjectBreakable(plate[id], false)
            setElementDoubleSided(plate[id], true)
        end

        addEventHandler("onClientRender", root, drawCreditNames)
    end
)

addEventHandler("onClientResourceStop", resourceRoot,
    function ()
        removeEventHandler("onClientRender", root, drawCreditNames)

        for index = 1, #peds do
            if isElement(peds[index]) then
                destroyElement(peds[index])
            end
        end
    end
)

local camera = getCamera()

function drawCreditNames()
    local cx, cy, cz = getElementPosition(camera)
    for index, ped in pairs(credits) do
        local distance = getDistanceBetweenPoints3D(cx, cy, cz, ped.x, ped.y, ped.z)
        if distance < 120 then
            local sx, sy = getScreenFromWorldPosition(ped.x, ped.y, ped.z + 1.5, 0.06)
            if sx and sy then
                local scale = math.min(1.50, math.max(0.50, 120 / distance * 0.25)) * 1.5
                dxDrawText(ped.name, sx, sy, nil, nil, ped.color, scale, "center", "center")
            end
        end
    end

    if not falled and not isPedDead(localPlayer) then
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if vehicle then
            local _, _, z = getElementPosition(vehicle)
            if z < 28 then
                falled = true
                playSound("scramble.wav", false)
            end
        end
    end
end

addEvent("Map:onRoundStart", true)
addEventHandler("Map:onRoundStart", resourceRoot,
    function ()
        falled = false
        addEventHandler("onClientRender", root, drawWarningText)
        setTimer(function () removeEventHandler("onClientRender", root, drawWarningText) end, 20000, 1)
    end
)

local screenWidth, screenHeight = guiGetScreenSize()

function drawWarningText()
    dxDrawText("All Carshade objects will be removed after 20 seconds!", 0, 0, screenWidth, 100, tocolor(255, 255, 255, 255 - getTickCount() * 0.2 % 255), 2, "default-bold", "center", "bottom")
end

addEvent("Map:onSoundPlay", true)
addEventHandler("Map:onSoundPlay", resourceRoot,
    function (file, x, y, z)
        if fileExists(file) then
            local sound = playSound3D(file, x, y, z, false)
            if sound then
                setSoundMaxDistance(sound, 100)
            end
        end
    end
)
