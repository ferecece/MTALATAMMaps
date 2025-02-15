local printLine1 = true
local printLine2 = true
local printLine3 = true
local player1name = ""
local player2name = ""
outputChatBox("If you don't want to fly the Hydra, follow the flag icon on your map to race to Grove Street!", getRootElement(), 231, 50, 50)
createBlip(2489, -1671, 13, 53)

function MarkerHit ( hitElement, matchingDimension )
	if getElementType(hitElement) == "player" then -- Make sure its the local player that hit the marker
		local x,y,z = getElementPosition ( source ) -- Get the position of the marker

			-- If its the side race END
		if x == 2489 then
			if y == -1671 then
				if printLine1 == true then
					outputChatBox( "" .. getPlayerNametagText(hitElement) .. " got to Grove Street FIRST using a " .. getVehicleName(getPedOccupiedVehicle(hitElement)) .. "!", getRootElement(), 231, 50, 50)
					printLine1 = false
					player1name = getPlayerNametagText(hitElement)
					
				elseif printline2 == true  then
					if player1name ~= getPlayerNametagText(hitElement) then
						outputChatBox( "" .. getPlayerNametagText(hitElement) .. " got to Grove Street SECOND using a " .. getVehicleName(getPedOccupiedVehicle(hitElement)) .. "!", getRootElement(), 231, 50, 50)
						printLine2 = false
						player2name = getPlayerNametagText(hitElement)
					end
					
				elseif printline3 == true then
					if player1name ~= getPlayerNametagText(hitElement) and player2name ~= getPlayerNametagText(hitElement) then
						outputChatBox( "" .. getPlayerNametagText(hitElement) .. " got to Grove Street THIRD using a " .. getVehicleName(getPedOccupiedVehicle(hitElement)) .. "!", getRootElement(), 231, 50, 50)
						printLine3 = false
					end
				end
			end
		end
	end
end
addEventHandler ( "onMarkerHit", getRootElement(), MarkerHit )
