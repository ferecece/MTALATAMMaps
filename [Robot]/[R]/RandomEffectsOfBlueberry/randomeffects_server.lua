RANDOM_EFFECT_TIME_MULTIPLIER = 1 -- Multiplier for all the time variables.
RANDOM_EFFECT_PERIOD_TIME = 17000 * RANDOM_EFFECT_TIME_MULTIPLIER -- Time between new random effect is chosen. In ms
RANDOM_EFFECT_READY_TIME  = 3000 * RANDOM_EFFECT_TIME_MULTIPLIER -- Time between effect is revealed and applied. In ms

SpawnedObjects = {}
----------------------------------------------------------------------------------
-- Utility functions
----------------------------------------------------------------------------------

function setGravityForPlayers(gravity)
    for i,p in ipairs(getElementsByType("player")) do
		setPedGravity(p, gravity)
	end
end

function setHealthForPlayers(health)
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setElementHealth(vehicle, health)
        end
    end
end

----------------------------------------------------------------------------------
-- Cleanup functions
----------------------------------------------------------------------------------

function noCleanup()
end

function resetGravityForPlayers()
    setGravityForPlayers(0.008)
end

function resetHealthForPlayers()
    setHealthForPlayers(1000)
end

function resetGameSpeed()
    setGameSpeed(1)
end

function resetTimeAndWeather()
    setTime(12, 0)
    setWeather(1)
    resetFogDistance()
end

function resetVisibilityForPlayers()
    for i,p in ipairs(getElementsByType("player")) do
        fadeCamera(p, true, 0.5)
    end
end

function resetFovForPlayers()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onResetFov", p)
    end
end

function resetNightvisionForPlayers()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onResetNightvision", p)
    end
end

function resetThermalvisionForPlayers()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onResetThermalvision", p)
    end
end

function resetVehicleHandling()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, true)
        end
    end
    handling_changed_mass = false
    handling_changed_traction = false
    handling_changed_suspension = false
    handling_changed_velocity = false
end

function resetVehicleTires()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleWheelStates(vehicle, 0, 0, 0, 0)
        end
    end
    wheel_changed = false
end

function resetClearObjects()
    for i, obj in ipairs(SpawnedObjects) do
        destroyElement(obj)
        obj = nil
    end
    SpawnedObjects = {}
end

function resetCinematicCamera()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onResetCinematic", p)
    end
end

----------------------------------------------------------------------------------
-- Effect functions
----------------------------------------------------------------------------------

function effectDoubleGravity()
    setGravityForPlayers(0.016)
end

function effectQuadrupleGravity()
    setGravityForPlayers(0.032)
end

function effectHalfGravity()
    setGravityForPlayers(0.004)
end

function effectNoGravity()
    setGravityForPlayers(0.000)
end

function effectToTheMoon()
    setGravityForPlayers(-0.100)
end

function effectOHKO()
    setHealthForPlayers(250)
end

function effectDoubleGameSpeed()
    setGameSpeed(2)
end

function effectHalfGameSpeed()
    setGameSpeed(0.5)
end

function effectMidnightStorm()
	setTime(0, 0)
    setWeather(8)
end

function effectSandstorm()
	setTime(20, 0)
    setWeather(19)
end

function effectFoggyWeather()
	setTime(4, 0)
    setWeather(9)
    setFogDistance(500)
end

function effectSleepy()
    for i,p in ipairs(getElementsByType("player")) do
        fadeCamera(p, false, 2.5, 0, 0, 0)
    end
end

function effectConsoleFov()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onConsoleFov", p)
    end
end 

function effectNightvision()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onNightvision", p)
    end
end

function effectThermalvision()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onThermalvision", p)
    end
end

function effectRandomMass()
    massvalue = math.random(1.0, 10000.0)
    turnmassvalue = math.random(1.0, 10000.0)
    massX = math.random(-0.5, 0.5)
    massY = math.random(-0.5, 0.5)
    massZ = math.random(-1.0, 1.0)
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "mass", massvalue)
            setVehicleHandling(vehicle, "turnmass", turnmassvalue)
            setVehicleHandling(vehicle, "centerOfMass", {massX, massY, massZ})
        end
    end
    handling_changed_mass = true
end

function effectHighCenterofMass()
    massX = 0
    massY = 0.1
    massZ = 0.7
    massvalue = 1400
    turnmassvalue = 3400
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "centerOfMass", {massX, massY, massZ})
        end
    end
    handling_changed_mass = true
end

function effectLowTraction()
    multipvalue = 0.5
    lossvalue = 0.5
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "tractionMultiplier", multipvalue)
            setVehicleHandling(vehicle, "tractionLoss", lossvalue)
        end
    end
    handling_changed_traction = true
end

function effectHighTraction()
    multipvalue = 10
    lossvalue = 1
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "tractionMultiplier", multipvalue)
            setVehicleHandling(vehicle, "tractionLoss", lossvalue)
        end
    end
    handling_changed_traction = true
end

function effectSoftSuspension()
    suspForce = 0.4
    suspDamp = 0.1
    suspHighSpeed = 0.0
    suspUpper = 0.1
    suspLower = -1.0
    suspAntiDive = 0.1
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)      
        if vehicle ~= false then
            setVehicleHandling(vehicle, "suspensionForceLevel", suspForce)
            setVehicleHandling(vehicle, "suspensionDamping", suspDamp)
            setVehicleHandling(vehicle, "suspensionHighSpeedDamping ", suspHighSpeed)
            setVehicleHandling(vehicle, "suspensionUpperLimit", suspUpper)
            setVehicleHandling(vehicle, "suspensionLowerLimit", suspLower)
            setVehicleHandling(vehicle, "suspensionAntiDiveMultiplier ", suspAntiDive)
        end
    end
    handling_changed_suspension = true
end

function effectHardSuspension()
    suspForce = 20
    suspDamp = 2
    suspHighSpeed = 0.0
    suspUpper = 0.3
    suspLower = -0.3
    suspAntiDive = 0.5
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)      
        if vehicle ~= false then
            setVehicleHandling(vehicle, "suspensionForceLevel", suspForce)
            setVehicleHandling(vehicle, "suspensionDamping", suspDamp)
            setVehicleHandling(vehicle, "suspensionHighSpeedDamping ", suspHighSpeed)
            setVehicleHandling(vehicle, "suspensionUpperLimit", suspUpper)
            setVehicleHandling(vehicle, "suspensionLowerLimit", suspLower)
            setVehicleHandling(vehicle, "suspensionAntiDiveMultiplier ", suspAntiDive)
        end
    end
    handling_changed_suspension = true
end

function effectPopTires()
    tire_1 = math.random(0, 1)
    tire_2 = math.random(0, 1)
    tire_3 = math.random(0, 1)
    tire_4 = math.random(0, 1)
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleWheelStates(vehicle, tire_1, tire_2, tire_3, tire_4)
        end
    end
    wheel_changed = true
end

function effectSpawnRamp()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            local x, y, z = getElementPosition(vehicle)
            local rot_x, rot_y, rot_z = getElementRotation(vehicle)

            local radians = math.rad(rot_z - 90)
            local newX = x - 20 * math.cos(radians)
            local newY = y - 20 * math.sin(radians)

            newobj = createObject(1634, newX, newY, z, rot_x, rot_y, rot_z)
            table.insert(SpawnedObjects, newobj)
        end
    end
end

function effectSpawnTree()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            local x, y, z = getElementPosition(vehicle)
            local rot_x, rot_y, rot_z = getElementRotation(vehicle)

            local radians = math.rad(rot_z - 90)
            local newX = x - 20 * math.cos(radians)
            local newY = y - 20 * math.sin(radians)

            newobj = createObject(615, newX, newY, z - 5, rot_x, rot_y, rot_z)
            table.insert(SpawnedObjects, newobj)
        end
    end
end

function effectCinematicCamera()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onCinematic", p)
    end
end

function effectWaterCube()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            local x, y, z = getElementPosition(vehicle)
            local rot_x, rot_y, rot_z = getElementRotation(vehicle)

            local radians = math.rad(rot_z - 90)
            local newX = x - 20 * math.cos(radians)
            local newY = y - 20 * math.sin(radians)
            newobj = createWater(newX-8, newY-8, z+0.05, newX+8, newY-8, z+0.05, newX-8, newY+8, z+0.05, newX+8, newY+8, z+0.05)
            table.insert(SpawnedObjects, newobj)
        end
    end
end

function effectRotateAround()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            local rot_x, rot_y, rot_z = getElementRotation(vehicle)
            setElementRotation(vehicle, rot_x, rot_y, rot_z+180)
        end
    end
end

function effectSpeedBoost()
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            local vel_x, vel_y, vel_z = getElementVelocity(vehicle)
            setElementVelocity(vehicle, vel_x*3, vel_y*3, vel_z*3)
        end
    end
end

function effectNoMaxVelocity()
    maxVelocity = 200000
    drag = 0.5
    accel = 28.0
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
            setVehicleHandling(vehicle, "dragCoeff", drag)
            setVehicleHandling(vehicle, "engineAcceleration", accel)
        end
    end
    handling_changed_velocity = true
end

function effectLowMaxVelocity()
    maxVelocity = 20
    drag = 2.4
    accel = 28.0
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
            setVehicleHandling(vehicle, "dragCoeff", drag)
            setVehicleHandling(vehicle, "engineAcceleration", accel)
        end
    end
    handling_changed_velocity = true
end

function effectHighAccel()
    maxVelocity = 209
    drag = 2.4
    accel = 100.0
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
            setVehicleHandling(vehicle, "dragCoeff", drag)
            setVehicleHandling(vehicle, "engineAcceleration", accel)
        end
    end
    handling_changed_velocity = true
end

function effectLowAccel()
    maxVelocity = 209
    drag = 2.4
    accel = 2.8
    for i,p in ipairs(getElementsByType("player")) do
        local vehicle = getPedOccupiedVehicle(p)
        if vehicle ~= false then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
            setVehicleHandling(vehicle, "dragCoeff", drag)
            setVehicleHandling(vehicle, "engineAcceleration", accel)
        end
    end
    handling_changed_velocity = true
end

-- Effect array. First value is the description of the effect. Second value is the effect function. Third value is the effect duration. Fourth value is the cleanup function.
local effects_array = {
    {"Double Gravity", effectDoubleGravity, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGravityForPlayers},         -- 1
    {"Quadruple Gravity", effectQuadrupleGravity, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGravityForPlayers},   -- 2
    {"Half Gravity", effectHalfGravity, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGravityForPlayers},             -- 3
    {"No Gravity", effectNoGravity, 5000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGravityForPlayers},                  -- 4
    {"Jump", effectToTheMoon, 100 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGravityForPlayers},                         -- 5
    {"OHKO", effectOHKO, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetHealthForPlayers},                             -- 6
    {"2x Game Speed", effectDoubleGameSpeed, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGameSpeed},                -- 7
    {"Half Game Speed", effectHalfGameSpeed, 10000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetGameSpeed},                -- 8
    {"Midnight Storm", effectMidnightStorm, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetTimeAndWeather},            -- 9
    {"Sandstorm", effectSandstorm, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetTimeAndWeather},                     -- 10
    {"Foggy Weather", effectFoggyWeather, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetTimeAndWeather},              -- 11
    {"Sleepy", effectSleepy, 5000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVisibilityForPlayers},                      -- 12
    {"Console FOV", effectConsoleFov, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetFovForPlayers},                   -- 13
    {"Nightvision", effectNightvision, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetNightvisionForPlayers},          -- 14
    {"Thermalvision", effectThermalvision, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetThermalvisionForPlayers},    -- 15
    {"Random Mass", effectRandomMass, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},                 -- 16
    {"Low Traction", effectLowTraction, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},               -- 17
    {"Soft Suspension", effectSoftSuspension, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},         -- 18
    {"Pop Random Tires", effectPopTires, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleTires},                 -- 19
    {"Spawn Ramp", effectSpawnRamp, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetClearObjects},                      -- 20
    {"Spawn Tree", effectSpawnTree, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetClearObjects},                      -- 21
    {"Cinematic Camera", effectCinematicCamera, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetCinematicCamera},       -- 22
    {"Water Trap", effectWaterCube, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetClearObjects},                      -- 23
    {"Rotate Around", effectRotateAround, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, noCleanup},                        -- 24
    {"Speed Boost", effectSpeedBoost, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, noCleanup},                            -- 25
    {"High Traction", effectHighTraction, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},             -- 26
    {"Hard Suspension", effectHardSuspension, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},         -- 27
    {"High Center of Mass", effectHighCenterofMass, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},   -- 28
    {"No Max Velocity", effectNoMaxVelocity, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},          -- 29
    {"Snail Speed", effectLowMaxVelocity, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},             -- 30
    {"High Acceleration", effectHighAccel, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},            -- 31
    {"Low Acceleration", effectLowAccel, 15000 * RANDOM_EFFECT_TIME_MULTIPLIER, resetVehicleHandling},              -- 32
}

----------------------------------------------------------------------------------
--  Main functions
----------------------------------------------------------------------------------

-- Create RNG numbers
function createRandomNumbers()
    range = #effects_array
    availableNumbers = {}
    for i = 1, range do
        availableNumbers[i] = i
    end
end

function getRandomUniqueNumber()
    if #availableNumbers == 0 then
        createRandomNumbers() -- No more random numbers, create new ones
        outputChatBox("All random effects done, redo!")
    end
    local index = math.random(#availableNumbers)
    local number = availableNumbers[index]
    table.remove(availableNumbers, index)
    return number
end

-- Choose random effect not happened yet
function chooseRandomEffect()
    neweffect = effects_array[getRandomUniqueNumber()]
    updateNextEffect()
    setTimer(applyRandomEffect, RANDOM_EFFECT_READY_TIME, 1)
end

function applyRandomEffect()
    currenteffect = neweffect
    currenteffect[2]()
    setTimer(cleanupRandomEffect, currenteffect[3], 1)
end

function cleanupRandomEffect()
    currenteffect[4]()
end

----------------------------------------------------------------------------------
-- When map starts
----------------------------------------------------------------------------------
function effectsStart()
    createRandomNumbers()
    effecttimer = setTimer(chooseRandomEffect, RANDOM_EFFECT_PERIOD_TIME, 0)
end
addEventHandler("onMapStarting", getRootElement(), effectsStart)

----------------------------------------------------------------------------------
-- UI Updating
----------------------------------------------------------------------------------
function updateNextEffect()
    for i,p in ipairs(getElementsByType("player")) do
        triggerClientEvent(p, "onUpdateNextEffect", p, neweffect[1])
    end
end

----------------------------------------------------------------------------------
-- Functions to use when player respawns to avoid effects
----------------------------------------------------------------------------------
function enterVehicle(theVehicle)
    if handling_changed_mass == true then
        setVehicleHandling(theVehicle, "mass", massvalue)
        setVehicleHandling(theVehicle, "turnmass", turnmassvalue)
        setVehicleHandling(theVehicle, "centerOfMass", {massX, massY, massZ})
    end
    if handling_changed_traction == true then
        setVehicleHandling(theVehicle, "tractionMultiplier", multipvalue)
        setVehicleHandling(theVehicle, "tractionLoss", lossvalue)
    end
    if handling_changed_suspension == true then
        setVehicleHandling(theVehicle, "suspensionForceLevel", suspForce)
        setVehicleHandling(theVehicle, "suspensionDamping", suspDamp)
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping ", suspHighSpeed)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", suspUpper)
        setVehicleHandling(theVehicle, "suspensionLowerLimit", suspLower)
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier ", suspAntiDive)        
    end
    if wheel_changed == true then
        setTimer(function() 
            setVehicleWheelStates(theVehicle, tire_1, tire_2, tire_3, tire_4)
        end, 2500, 1)
    end
    if handling_changed_velocity == true then
        setVehicleHandling(theVehicle, "maxVelocity", maxVelocity)
        setVehicleHandling(theVehicle, "dragCoeff", drag)
        setVehicleHandling(theVehicle, "engineAcceleration", accel)
    end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), enterVehicle)

----------------------------------------------------------------------------------
-- Map Cleanup
----------------------------------------------------------------------------------

function onCurrentResourceStop (theResource)
    resetGravityForPlayers()
    resetGameSpeed()
end

-- Add the event handler
addEventHandler("onResourceStop", getResourceRootElement(), onCurrentResourceStop)

----------------------------------------------------------------------------------
-- Testing functions
----------------------------------------------------------------------------------
-- -- Kill effecttimer for testing purposes
-- function killeffecttimer(playerSource, commandName)
--     killTimer(effecttimer)
--     effecttimer = nil
--     outputChatBox("Effecttimer killed")
-- end

-- addCommandHandler ("killtimer", killeffecttimer)

-- function chooseEffect(playerSource, commandName, effectnumber)
--     neweffect = effects_array[tonumber(effectnumber)]
--     outputChatBox(neweffect[1])
--     setTimer(applyRandomEffect, RANDOM_EFFECT_READY_TIME, 1)
-- end

-- -- Test any effect
-- addCommandHandler ("effect", chooseEffect)