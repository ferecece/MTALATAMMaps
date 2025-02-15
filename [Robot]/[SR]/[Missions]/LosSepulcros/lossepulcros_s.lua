--function WarpHomiesIntoCar()
--   local vehicles = getElementsByType("vehicle")
--    playerunpack = unpack(vehicles)
--    playerName = getPlayerName(playerunpack)
--    player = getPlayerFromName(playerName)

--    outputChatBox(tostring(vehicles))
--   if (getPedOccupiedVehicle(player)) then
--        local PlayerVehicle = getPedOccupiedVehicle(playerName)
--        outputChatBox(tostring(PlayerVehicle))
--       local SweetPed = createPed(270, 2500, -1651.1895, 15)
--        local Homie1Ped = createPed(105, 2500, -1651.1895, 15)
--        local Homie2Ped = createPed(106, 2500, -1651.1895, 15)
--        warpPedIntoVehicle(SweetPed, PlayerVehicle, 1)
--       warpPedIntoVehicle(Homie1Ped, PlayerVehicle, 2)
--        warpPedIntoVehicle(Homie2Ped, PlayerVehicle, 3)
--        outputChatBox("warping")
--    end
--end
--addEventHandler("onPlayerVehicleEnter", getRootElement(), WarpHomiesIntoCar)

addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", root, 
    
function (checkpoint)
    local vehicle = getPedOccupiedVehicle(source)
    if (getVehicleName(vehicle) == "Greenwood") then 
         if checkpoint == 1 then
                setElementPosition(vehicle, 925.7109, -1122.968, 23.8)   
                setElementModel (vehicle, 445)
                setElementRotation(vehicle, 0, 0, 330.8056)
                triggerClientEvent (source, "PlayAdmiralDialogue", getRootElement()) 
        end 
    end 
end 
)

addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish", root, 

function (FinishDialogue)
    triggerClientEvent (source, "PlayFinishDialogue", getRootElement())
end     

)

addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", root,

function(newState,oldState)
    if newState == "Running" and oldState == "GridCountdown" then
        triggerClientEvent (source, "PlayStartDialogue", getRootElement())
    end
end    
)

