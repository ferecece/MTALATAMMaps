----------------------------------------------------------------------------------
-- Client side scripts for random effects
----------------------------------------------------------------------------------

-- Console FOV
function ConsoleFovHandler()
    c_vehiclefov = getCameraFieldOfView("vehicle")
    c_vehiclemaxfov = getCameraFieldOfView("vehicle_max")
    viewmode_v, viewmode_p = getCameraViewMode()
    setCameraViewMode(1)
    setCameraFieldOfView("vehicle",20)
    setCameraFieldOfView("vehicle_max",20)
    backToConsole()
end
addEvent("onConsoleFov", true)
addEventHandler("onConsoleFov", localPlayer, ConsoleFovHandler)

function ConsoleResetFovHandler()
    setCameraFieldOfView("vehicle", c_vehiclefov)
    setCameraFieldOfView("vehicle_max", c_vehiclemaxfov)
    setCameraViewMode(viewmode_v)
    if isTimer(Back2consoleTimer) then
        killTimer(Back2consoleTimer)
    end
    Back2consoleTimer = nil
end
addEvent("onResetFov", true)
addEventHandler("onResetFov", localPlayer, ConsoleResetFovHandler)

-- Change Camera Key prevention for Console FOV
function backToConsole()
    local currentviewmode_v, currentviewmode_p = getCameraViewMode()
    if currentviewmode_v ~= 1 then
        setCameraViewMode(1)
    end
    Back2consoleTimer = setTimer(backToConsole, 100, 1)
end

-- Nightvision
function NightvisionHandler()
    setCameraGoggleEffect("nightvision")
end
addEvent("onNightvision", true)
addEventHandler("onNightvision", localPlayer, NightvisionHandler)

function NightvisionResetHandler()
    setCameraGoggleEffect("normal")
end
addEvent("onResetNightvision", true)
addEventHandler("onResetNightvision", localPlayer, NightvisionResetHandler)

--  Thermalvision
function ThermalvisionHandler()
    setCameraGoggleEffect("thermalvision")
end
addEvent("onThermalvision", true)
addEventHandler("onThermalvision", localPlayer, ThermalvisionHandler)

function ThermalvisionResetHandler()
    setCameraGoggleEffect("normal")
end
addEvent("onResetThermalvision", true)
addEventHandler("onResetThermalvision", localPlayer, ThermalvisionResetHandler)

-- Cinematic Camera
function CinematicHandler()
    viewmode_v, viewmode_p = getCameraViewMode()
    setCameraViewMode(5)
    backToCinematic()
end
addEvent("onCinematic", true)
addEventHandler("onCinematic", localPlayer, CinematicHandler)

function CinematicResetHandler()
    setCameraViewMode(viewmode_v)
    if isTimer(Back2cinematicTimer) then
        killTimer(Back2cinematicTimer)
    end
    Back2cinematicTimer = nil
end
addEvent("onResetCinematic", true)
addEventHandler("onResetCinematic", localPlayer, CinematicResetHandler)

-- Change Camera Key prevention
function backToCinematic()
    local currentviewmode_v, currentviewmode_p = getCameraViewMode()
    if currentviewmode_v ~= 5 then
        setCameraViewMode(5)
    end
    Back2cinematicTimer = setTimer(backToCinematic, 100, 1)
end

----------------------------------------------------------------------------------
-- UI Stuff
----------------------------------------------------------------------------------
local screenWidth, screenHeight = guiGetScreenSize()
-- My resolution is 2560x1440
font_multiplier_height = screenHeight / 1440
font_multiplier_width = screenWidth / 2560
next_effect_text = ""

function GuiNextEffectHandler(next_effect)
    next_effect_text = next_effect
    countdown_text = 4
    nextEffectCountdown()
end
addEvent("onUpdateNextEffect", true)
addEventHandler("onUpdateNextEffect", localPlayer, GuiNextEffectHandler)

function nextEffectCountdown()
    Showcountdown = true
    if countdown_text > 1 then
        countdown_text = countdown_text - 1
        setTimer(nextEffectCountdown, 1000, 1)
    else
        countdown_text = 4
        Showcountdown = false
    end
end

function createText ( )
    dxDrawRectangle (screenWidth/17, screenHeight/1.63, screenWidth/3.6, screenHeight/15, tocolor ( 0, 0, 0, 55 ))
    dxDrawText ('Next', screenWidth / 16 , screenHeight / 1.64, screenWidth, screenHeight, tocolor ( 222, 222, 222, 255 ), 2*font_multiplier_width, 2*font_multiplier_height, "pricedown")
    dxDrawText ('EFFECT:', screenWidth / 16 , screenHeight / 1.54, screenWidth, screenHeight, tocolor ( 222, 222, 222, 255 ), 1.5*font_multiplier_width, 1.5*font_multiplier_height, "pricedown")
    dxDrawText (next_effect_text, screenWidth / 8.5 , screenHeight / 1.6, screenWidth, screenHeight, tocolor ( 222, 222, 222, 255 ), 2*font_multiplier_width, 2*font_multiplier_height, "pricedown")
    if Showcountdown == true then
        dxDrawText (countdown_text, screenWidth / 3.2 , screenHeight / 1.65, screenWidth, screenHeight, tocolor ( 222, 222, 222, 255 ), 4*font_multiplier_width, 4*font_multiplier_height, "pricedown")
    end
end
addEventHandler ("onClientRender", root, createText)