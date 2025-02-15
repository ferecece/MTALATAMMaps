-- Skip marker mechanics
local skipEnabled = false
local voteEnabled = false
votePlayer = nil
local votedPlayers = {}
local markerToSkip = 30

function startSkipVote(playerSource, commandName)
	if voteEnabled and not skipEnabled and not votedPlayers[playerSource] then
		if not getElementData(playerSource, "race.finished") then
			votePlayer = playerSource
			votedPlayers[playerSource] = true
			local checkpointIsAttainable = false
			
			for _, players in ipairs(getElementsByType("player")) do 
				if getElementData(players, "race.checkpoint") ~= nil and getElementData(players, "race.checkpoint") ~= false and players ~= playerSource then
					if getElementData(players, "race.checkpoint") > getElementData(playerSource, "race.checkpoint") then
						checkpointIsAttainable = true
						break
					end
				end
			end
			
			if not checkpointIsAttainable then
				exports.votemanager:stopPoll {}
				poll = exports.votemanager:startPoll 
				{
					title = getPlayerName(playerSource):gsub("#%x%x%x%x%x%x", "").. " found unattainable checkpoint " ..getElementData(playerSource, "race.checkpoint").. ". Skip it?",
					percentage = 100,
					timeout = 15,
					allowchange = true,

					[1] = {"Yes", "pollFinished" , resourceRoot, 80},
					[2] = {"No", "pollFinished" , resourceRoot, 2},		
				}
				
				if not poll then applyPollResult(2) end
			else
				outputChatBox("Voteskip: that's not an unattainable checkpoint", playerSource)
			end
		end
	else
		if skipEnabled then outputChatBox("Voteskip: marker already skipped", playerSource)
		elseif votedPlayers[playerSource] then outputChatBox("Voteskip: you already voted once", playerSource)
		else outputChatBox("Voteskip: command disabled right now", playerSource) end
	end
end
addCommandHandler("voteskip", startSkipVote)

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "Running" then
		voteEnabled = true
	elseif newState == "MidMapVote" or newState == "SomeoneWon" or newState == "NextMapVote"
		or newState == "TimesUp" or newState == "EveryoneFinished" or newState == "NextMapSelect" then
		voteEnabled = false
	end
end )