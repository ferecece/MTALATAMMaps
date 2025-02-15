voteEnabled = 3 
meowPlayer = nil
votedPlayers = {}

addEventHandler("onVehicleEnter", getRootElement(), function()
	setVehicleColor(source, math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
end )

function startMeowVote(playerSource, commandName)
	if voteEnabled > 0 and not votedPlayers[playerSource] then
		meowPlayer = getRandomPlayer()
		votedPlayers[playerSource] = true
		
		exports.votemanager:stopPoll {}
		poll = exports.votemanager:startPoll 
		{
			title = "Meow " ..getPlayerName(meowPlayer):gsub("#%x%x%x%x%x%x", "").. "?",
			percentage = 100,
			timeout = 15,
			allowchange = true,

			[1] = {"Meow", "pollFinished" , resourceRoot, 80},
			[2] = {"Awoo", "pollFinished" , resourceRoot, 70},		
		}
		
		if not poll then applyPollResult(80) end
	end
	voteEnabled = voteEnabled - 1
end
addCommandHandler("votemeow", startMeowVote)

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult)
	if pollResult == 80 then outputChatBox(getPlayerName(meowPlayer).. " is meow! Meow!")
	elseif pollResult == 70 then outputChatBox(getPlayerName(meowPlayer).. " is awoo! Awoo!") end
end )