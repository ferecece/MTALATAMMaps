local RACE_RESOURCE = getResourceDynamicElementRoot(getResourceFromName("race"))

function collectCheckpoints(target)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    local checkpoint = getElementData(localPlayer, "race.checkpoint")
	if checkpoint then
		for i=checkpoint, target do
			local colshapes = getElementsByType("colshape", RACE_RESOURCE)
			if (#colshapes == 0) then
				outputConsole("[FleischBerg Autos] SOMETHING WENT HORRIBLY WRONNNNGGGGG")
				iprint("[FleischBerg Autos] SOMETHING WENT HORRIBLY WRONNNNGGGGG")
				break
			end
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], vehicle, true)
		end
	end
end

function finishRace(new)
	setCameraMatrix (-213.5, -453.5, 63.5, -118.0, -353.8, 0.5)
	collectCheckpoints(#getElementsByType("checkpoint"))
end
addEvent("finishRace", true)
addEventHandler("finishRace", localPlayer, finishRace)