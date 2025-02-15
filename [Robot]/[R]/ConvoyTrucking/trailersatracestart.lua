
-----------------------------------------------
-------------- Trailer Attach -----------------
-----------------By: Stijger-------------------
-----------------------------------------------

players = getElementsByType("player")

addEvent("onRaceStateChanging", true)
function trailerAttach(newStateName, oldStateName)
    if newStateName == "GridCountdown" then
		outputChatBox ( "A trailer will be attached", getRootElement(), 255, 0, 0 )
		for _,player in pairs(players) do
		veh = getPedOccupiedVehicle (player)
		trailer = createVehicle ( 435, 2682, -2127.5, 15, 0, 0, 90) -- create a trailer
		setTimer (attachTrailerToVehicle, 1500, 1, veh, trailer) -- Attach trailer to roadtrain after 1.5 sec
		end
    end
end
addEventHandler("onRaceStateChanging", getRootElement(),trailerAttach)

function reattachTrailer(theTruck)
    setTimer (attachTrailerToVehicle, 500, 1, theTruck, source) -- Reattach the truck and trailer after 0.5 sec
end

addEventHandler("onTrailerDetach", getRootElement(), reattachTrailer)
