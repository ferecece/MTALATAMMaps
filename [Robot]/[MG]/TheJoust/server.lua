-- Reset client tournament data and sync
local tournament = {}
setElementData(resourceRoot, "tournament_data", tournament, true)

-- tournament contains:
-- [round][match][player 1 or 2][player, veh, name, score]

local arenas = {}

local round = 1
local subrounds_max = 3  --must be odd to ensure a winner in a 1v1
local subround = 1

function start(newstate,oldstate) --function to update the race states
	
	if (newstate == "LoadingMap") then

	end
	
	if (newstate == "GridCountdown") then
		----------------------------------------------------------------------------
		-- This is a DD so no players can join the tournament to play after this moment.
		----------------------------------------------------------------------------

		-- Expected tournament size:
		local player_count = getPlayerCount()  -- Set this to a value for testing

		-- Number of starting matches must be a power of 2 so that it converges into a final
		required_starting_matches = 1
		while required_starting_matches < math.ceil(player_count/2) do
			required_starting_matches = required_starting_matches*2
		end

		-- Initiate the round 1 bracket
		tournament[1]={}

		-- Add empty matches to round 1
		local open_spots = {}
		for i=1,required_starting_matches do
			tournament[1][i] = {}
			table.insert(open_spots, i*2-1)
			table.insert(open_spots, i*2)
		end

		
		-- Add existing players to a random spot
		for i, player in ipairs(getElementsByType('player')) do

			-- if you are not in a spawned veh at this point you are not playing
			local veh = getPedOccupiedVehicle(player)
			if veh then
				local _,_,z = getElementPosition(veh)
				if z < 1000 then
					local spot = table.remove(open_spots, math.random(1, #open_spots))
					local match = math.ceil(spot/2)
					
					player_pos = 'player1'
					if spot % 2 == 0 then
						player_pos = 'player2'
					end

					tournament[1][match][player_pos] = {}
					tournament[1][match][player_pos]['ped'] = player
					tournament[1][match][player_pos]['veh'] = getPedOccupiedVehicle(player)
					tournament[1][match][player_pos]['score'] = 0
					tournament[1][match][player_pos]['name'] = getPlayerName(player)

					setVehicleDamageProof(veh, true)
				end
			end

		end

		-- Fill the left over spots with bots
		for _, i in ipairs(open_spots) do
			local match = math.ceil(i/2)
			player_pos = 'player1'
			if i % 2 == 0 then
				player_pos = 'player2'
			end

			local bot = createPed ( 0, 0, 0, 3)
			local veh = createVehicle ( 459, 4, 0, 3 )
			warpPedIntoVehicle ( bot, veh )
			setElementFrozen(veh, true)
			setElementData ( veh, 'race.collideothers', 1 )
			setVehicleDamageProof(veh, true)


			tournament[1][match][player_pos] = {}
			tournament[1][match][player_pos]['ped'] = bot
			tournament[1][match][player_pos]['veh'] = veh
			tournament[1][match][player_pos]['score'] = 0
			tournament[1][match][player_pos]['name'] = "BOT_" .. i

		end

		setElementData(resourceRoot, "tournament_data", tournament, true)
		triggerClientEvent ("forceShow", resourceRoot, 1)
		setTimer(function()
			triggerClientEvent ("forceShow", resourceRoot, 0) -- show bracket
		end,6000,1)
		
		print('Starting matches: ' .. #tournament[1])

		for i=1,#tournament[1] do
			print('Match ' .. i .. ': ' .. tournament[1][i]['player1']['name'] .. ' - ' .. tournament[1][i]['player2']['name'])
		end
		
		----------------------------------------------------------------------------
		-- The tournament bracket is now complete, and will proceed with elimination
		----------------------------------------------------------------------------
		outputChatBox ("Welcome to The Joust!", root, 0, 255, 0, false)
		--outputChatBox ("W, S and Handbrake are disabled. Try to get closer to the target than your opponent!", root, 0, 255, 0, false)
		outputChatBox ("You will face your opponent 3 times, the winner moves on to the next bracket.", root, 0, 255, 0, false)

		setTimer(startManager,6000,1)

	end
	
	if (newstate == "Running" and oldstate == "GridCountdown") then

	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )


function assignSpot(round, player_data)
	-- find first empty spot, used only for rounds after round 1
	for i=1,1000 do
		if tournament[round][i] == nil then --This match doesn't exist so the player must go into slot 1
			tournament[round][i] = {}
			tournament[round][i]['player1'] = {}

			-- copy by value, lua tables are mutalbe. So tournament[round][i]['player1'] = player_data does not work
			-- becuase then you cannot change the score per match
			for key, value in pairs(player_data) do  
				tournament[round][i]['player1'][key] = value
			end
			tournament[round][i]['player1']['score'] = 0
			break -- found a spot
		end
		if tournament[round][i]['player2'] == nil then -- The match exists but slot 2 is empty
			tournament[round][i]['player2'] = {}
			for key, value in pairs(player_data) do
				tournament[round][i]['player2'][key] = value
			end
			tournament[round][i]['player2']['score'] = 0
			break -- found a spot
		end
		--match has both player 1 and player 2 filled so it should continue to the next one.
	end
end

--local games={slippery_slope,slippery_slope,slippery_slope}, can be extened in the future with more mini games
 --games[math.random(1,#games)]
local game
local first_time = true

function startManager()

	-- Create arena
	if subround == 1 then
		game = slippery_slope  --see slippery_slope_s.lua, it's essentially a table with data and functions.
		arenas = {}
		for i,match in ipairs(tournament[round]) do
			arenas[i] = game.createArena(_, 2857 + i*-19.5, 745, 20)
		end
	end

	print('Playing: ' .. game["name"] .. ", round" .. round .. ", subround " .. subround)

	triggerClientEvent ("showGameInfo", root, true, game['name'], game['instructions'])

	-- Spawn players
	for i, match in ipairs(tournament[round]) do
		for p=1,2 do
			if match['player' .. p]['veh'] ~= nil then  --not sure what happens when people leave, but I think their veh table entry will be nil
				local veh = match['player' .. p]['veh']
				if veh then
					local _,_,alive_z = getElementPosition(veh)
					if alive_z < 1000 then  --
						local x,y,z,rotx,roty,rotz = unpack(arenas[i][2][p]["position"]) -- spawnpoint position (absolute coordinates)
						setElementFrozen(veh,true)
						setElementPosition(veh,x,y,z)
						setElementRotation(veh,rotx,roty,rotz)
						setElementModel(veh,arenas[i][2][p]["model"])
						setVehicleColor(veh, math.random(0,255),math.random(0,255),math.random(0,255))
						setVehicleDamageProof(veh, true)
					end
				end
			end
		end
	end


	-- Countdown / Start game
	local delay_time
	if first_time then
		first_time = false
		delay_time = 4000
	else
		delay_time = 4000
		exports.race:startRaceCountdown(4) -- can skip for the first game because there is already a countdown
	end
	
	setTimer(function()
		-- Give control of the game loop to the active game.
		-- The game handles any specific starting conditions and will unfreeze the vehicles.
		-- The game will surrender control of the game loop by calling finishManager() when it's done.
		-- Most games will end by a timer but we can be flexible here to allow other ending conditions.
		game:startGame() 

	end,delay_time,1)
end


function finishManager()

	triggerClientEvent ("showGameInfo", root, false, _, _)

	-- round finished
	-- select winner
	-- The game determines who wins a match, the animations are done here.
	for i, match in ipairs(tournament[round]) do

		local target = arenas[i][3]
		winner = game:determineMatchWinner(match, arenas[i][3]) -- will always return 'player1' or 'player2'
		local loser = 'player2'
		if winner == 'player2' then
			loser = 'player1'
		end

		-- Animate winners / losers
		local colors = {}
		colors[winner] = {0, 255, 0}
		colors[loser] = {255, 0, 0}

		local vels = {}
		vels[winner] = {0,0,0.1}
		vels[loser]  = {0,0,0}

		for _, player in pairs({winner, loser}) do
			if match[player]['veh'] ~= nil then
				local veh = match[player]['veh']
				if veh then
					local r,g,b = unpack(colors[player])
					setVehicleColor(veh, r, g, b)
					local vx,vy,vz = unpack(vels[player])
					setElementVelocity(veh, vx,vy,vz)
				end
			end
		end

		-- update score
		if tournament[round][i][winner] ~= nil then
			tournament[round][i][winner]['score'] = tournament[round][i][winner]['score'] + 1
		end

	end
	setElementData(resourceRoot, "tournament_data", tournament, true) --update client

	-- Wait 2 seconds before starting next subround
	setTimer(function()

		-- Check for round end
		subround = subround + 1
		if subround > subrounds_max then
			-- goto next round

			-- Create next bracket
			tournament[round+1] = {}

			-- Check round winner per match
			for i, match in ipairs(tournament[round]) do
				local score1 = match['player1']['score']
				local score2 = match['player2']['score']

				local round_loser = 'player1'
				local round_winner = 'player2'
				if score1>score2 then
					round_winner = 'player1'
					round_loser = 'player2'
				end
				
				-- put the winner in the next bracket, this goes in order or ipairs so fills the slots up correctly
				assignSpot(round+1, match[round_winner])  
				
				-- kill the loser
				if match[round_loser]['veh'] ~= nil then
					local veh = match[round_loser]['veh']
					if veh then
						-- set timer to remove bot ped and veh
						local ped = getVehicleOccupant(veh)
						if ped then
							if getElementType(ped) == 'ped' then
								setTimer(function()
									destroyElement(ped)
									destroyElement(veh)
								end, 2000, 1)
							end
						end
						
						blowVehicle(veh)
					end
				end
			end

			-- update client with new bracket data
			setElementData(resourceRoot, "tournament_data", tournament, true) --update client


			if #tournament[round] > 1 then  -- If this round only had 1 match then the tournament is finished.
				setTimer(function()
					-- Round finished, destroy arena. The next game will rebuild it.
					for i,match in ipairs(tournament[round]) do
						for _, o in ipairs(arenas[i][1]) do
							destroyElement(o)
						end
					end

					-- Start next round
					round = round + 1
					subround = 1 
					startManager()
				end, 3000, 1)
			end
		else
			-- Round not finished, reset and continue match
			startManager()
		end

	end, 2000, 1)

end



local crown1 = createObject(11413, 0,0,0)
local crown2 = createObject(11413, 0,0,0)
setElementDoubleSided(crown1, true)
setObjectScale(crown1, 0.03)
setElementDoubleSided(crown2, true)
setObjectScale(crown2, 0.03)


setTimer(function()
	
	targetCount = {}

	for i,p in ipairs (getElementsByType("player")) do 
		local target = getCameraTarget(p) --note: can return false
		if target then
			-- when driving your camera target is your player
			-- when spectating your camera target is a vehicle
			if getElementType(target) == "player" then
				target = getPedOccupiedVehicle(target)
			end
		end

		if target then -- Count players watching this target
			if not targetCount[target] then -- Increase the count of the target
				targetCount[target] = 1
			else
				targetCount[target] = targetCount[target] + 1
			end
		end

	end

	local crowd_favourite = false
	local best_count = 0
	for target, count in pairs(targetCount) do
		if count > best_count then
			crowd_favourite = target
		end
	end

	if crowd_favourite then
		attachElements(crown1, crowd_favourite, 0, -0.7, 1.7, 0, 0, 0 )
		attachElements(crown2, crowd_favourite, 0, -0.7, 1.6, 0, 180, 0 )
	end

end, 1000, 0)