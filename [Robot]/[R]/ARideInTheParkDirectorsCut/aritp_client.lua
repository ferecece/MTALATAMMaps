-- Pair this with the any_order_cp edf resource in the map editor.
-- Place an checkpoint_any_order where you want it, however many you want (don't crash the game though)
-- Then place an equivalent number of race gamemode checkpoints in an unreachable spot and set their blipsize to 0
-- Everytime a player hits an checkpoint_any_order it will disappear and a race checkpoint will be collected remotely, increasing the player's race progress.
-- If there are fewer race checkpoints than checkpoint_any_order, the player will not need to collect all the checkpoints to win (they can choose which to collect).
-- If there are more race checkpoints than checkpoint_any_order, nothing special takes place.
-- Base code by Ali_Digitali. Modified and generalized by LotsOfS.

local INTRO_CHAT_MSG = "#568F65You have #D1BD6630 minutes #568F65to collect #D1BD6630 #568F65checkpoints!! You may collect them in #D1BD66ANY ORDER."
local INTRO_CHAT_COLOR = "#FFFFFF"

checkpointCounter = 0
function colHit(hitEl,dim)
	if getElementType(hitEl) == "vehicle" then
		if getVehicleOccupant(hitEl) == localPlayer then
			-- if getElementModel(hitEl)==400 then
				checkpointCounter = checkpointCounter+1
				--playSoundFrontEnd(101)
				destroyElement(markers[source])
				destroyElement(blips[source])
				destroyElement(source)

				local target = math.min(#getElementsByType("checkpoint", resourceRoot), #getElementsByType("checkpoint_any_order", resourceRoot))
				if checkpointCounter == target then
					finishRace()
				else
					collectCheckpoints(checkpointCounter)
				end
			-- end
		end
	end
end

markers = {}
blips = {}
setTimer(function()
	for i,m in ipairs(getElementsByType("checkpoint_any_order", resourceRoot)) do
		local posX = getElementData(m, "posX")
		local posY = getElementData(m, "posY")
		local posZ = getElementData(m, "posZ")
		local size = getElementData(m, "size")
		local blipsize = getElementData(m, "blipsize")
		local cpType = getElementData(m, "type")
		local extracolshapesize = getElementData(m, "extracolshapesize")
		local color = getElementData(m, "color")
		local blipcolor = getElementData(m, "blipcolor")
		if (cpType == "checkpoint") then
			col = createColCircle(posX, posY, size + extracolshapesize)
		else
			col = createColSphere(posX, posY, posZ, size + extracolshapesize)
		end
		markers[col]= createMarker(posX, posY, posZ, cpType, size, getColorFromString(color))
		blips[col] = createBlipAttachedTo(markers[col],0,blipsize,getColorFromString(blipcolor))
		addEventHandler("onClientColShapeHit",col,colHit)
	end

	if (INTRO_CHAT_MSG) then
		local r,g,b,a = getColorFromString(INTRO_CHAT_COLOR or "#000000")
		outputChatBox(INTRO_CHAT_MSG, r, g, b, true)
	end
end,500,1)

local race_resource = getResourceDynamicElementRoot(getResourceFromName("race"))
function collectCheckpoints(target)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    local checkpoint = getElementData(localPlayer, "race.checkpoint")
    for i=checkpoint, target do
		local colshapes = getElementsByType("colshape", race_resource)
		if (#colshapes == 0) then
			outputConsole("[Any Order CPs] SOMETHING WENT HORRIBLY WRONNNNGGGGG")
			iprint("[Any Order CPs] SOMETHING WENT HORRIBLY WRONNNNGGGGG")
			break
		end
		triggerEvent("onClientColShapeHit", colshapes[#colshapes], vehicle, true)
    end
end

function finishRace()
	collectCheckpoints(#getElementsByType("checkpoint"))
end
addEvent("finishRace", true)
addEventHandler("finishRace", localPlayer, finishRace)