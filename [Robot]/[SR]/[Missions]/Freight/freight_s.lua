poll_active = false -- State for poll at the race start
laps = 1 -- Default amount of laps
raceStarted = 0 -- Midrace fixes
pollEnded = 0 -- Midrace fixes

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "Running" and oldState == "GridCountdown" then 
		triggerClientEvent("enableControlsEvent", getRootElement())
		raceStarted = 1
	elseif newState == "GridCountdown" then
		exports.scoreboard:addScoreboardColumn("Money")
		exports.votemanager:stopPoll {}
		
		poll = exports.votemanager:startPoll 
		{
			title = "Choose the number of laps for Freight:",
			percentage = 100,
			timeout = 15,
			allowchange = true,

			[1] = {"Casual playthrough (1 lap, ~10 mins)", "pollFinished" , resourceRoot, 1},		
			[2] = {"Speedrun Experience (2 laps, ~20 mins)", "pollFinished" , resourceRoot, 2},		
		}
		
		if not poll then
			applyPollResult(1)
		end
	end
end )

addEvent("isRaceStarted", true)
addEventHandler("isRaceStarted", getRootElement(), function()
	if raceStarted == 0 then return end
	
	triggerClientEvent(source, "enableControlsEvent", getRootElement())
	if pollEnded == 1 then 
		triggerClientEvent(source, "postVoteStuff", getRootElement(), laps) 
	end
end )

addEvent("setAlphaForSpectate", true)
addEventHandler("setAlphaForSpectate", getRootElement(), function()
	setElementData(source, "overrideAlpha.uniqueblah", 0, false)
end )

addEvent("setAlphaAfterSpectate", true)
addEventHandler("setAlphaAfterSpectate", getRootElement(), function()
	setElementData(source, "overrideAlpha.uniqueblah", nil, false)
end )
    

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult)
	laps = pollResult
	pollEnded = 1
	triggerClientEvent("postVoteStuff", getRootElement(), laps)
end )

addEvent("onPlayerReachCheckpoint", true)
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint, time)
	triggerClientEvent("checkpointHit", getRootElement())
end )

addEventHandler("onResourceStop", resourceRoot, function() exports.scoreboard:removeScoreboardColumn("Money") end )