-- SERVERSIDE script for A Wise Man From The East, by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script.

-- This script handles the following:
-- - Handling of the question displays
-- - Generating questions, randomZone question and guess the vehicle
-- - Round Cycler
-- - Answer handling, move players up and down tiers as they answer questions


-- creation of the display items in which the answers are displayed. each answer has two displays, one with low alpha and one with high alpha
question = textCreateDisplay()
questionText = textCreateTextItem("",0.5,0.05,"medium",255,255,255,255,2,"center",_,100)
textDisplayAddText (question,questionText) 

answer1 = textCreateDisplay()
answer1Text = textCreateTextItem("",0.25,0.15,"medium",255,0,0,200,2,"left",_,100)
textDisplayAddText (answer1,answer1Text) 

answer2 = textCreateDisplay()
answer2Text = textCreateTextItem("",0.55,0.15,"medium",0,255,0,200,2,"left",_,100)
textDisplayAddText (answer2,answer2Text) 

answer3 = textCreateDisplay()
answer3Text = textCreateTextItem("",0.25,0.20,"medium",255,0,255,200,2,"left",_,100)
textDisplayAddText (answer3,answer3Text) 

answer4 = textCreateDisplay()
answer4Text = textCreateTextItem("",0.55,0.20,"medium",255,255,0,200,2,"left",_,100)
textDisplayAddText (answer4,answer4Text)

answer5 = textCreateDisplay()
answer5Text = textCreateTextItem("",0.25,0.15,"medium",255,0,0,255,2,"left",_,100)
textDisplayAddText (answer5,answer5Text) 

answer6 = textCreateDisplay()
answer6Text = textCreateTextItem("",0.55,0.15,"medium",0,255,0,255,2,"left",_,100)
textDisplayAddText (answer6,answer6Text) 

answer7 = textCreateDisplay()
answer7Text = textCreateTextItem("",0.25,0.20,"medium",255,0,255,255,2,"left",_,100)
textDisplayAddText (answer7,answer7Text) 

answer8 = textCreateDisplay()
answer8Text = textCreateTextItem("",0.55,0.20,"medium",255,255,0,255,2,"left",_,100)
textDisplayAddText (answer8,answer8Text)


-- Tables with different types of vehicles, for picking vehicles from the same catagory
vehicleGuess = {}
vehicleGuess[1] = 	{602,496,401,518,527,589,419,533,526,474,545,517,410,600,436,580,439,549,491} -- compact cars
vehicleGuess[2] =  	{445,604,507,585,587,466,492,546,551,516,467,426,547,405,409,550,566,540,421,529} -- luxuryCars 
vehicleGuess[3] =  	{592,577,511,548,512,593,425,520,417,487,553,497,563,476,447,519,460,469,513} -- aircraft
vehicleGuess[4] =  	{581,509,481,462,521,463,510,522,461,448,468,586} -- bikes
vehicleGuess[5] =  	{472,473,493,595,484,430,453,452,446,454} -- boats
vehicleGuess[6] =  	{536,575,534,567,535,576,412} --lowriders
vehicleGuess[7] =  	{441,464,501,465,564} --rc vehicles
vehicleGuess[8] = 	{485,552,431,438,437,574,420,525,408,416,596,433,597,427,599,490,432,528,601,407,
					 428,544,523,470,598,583,530,572,568,424,504,457,483,508,571,500,444,471,495,539} --other vehicles
vehicleGuess[9] =	{499,609,498,524,532,578,486,406,573,455,588,403,514,423,414,443,515,531,456,459,543,
					 422,482,478,605,554,418,582,413,440} -- trucks
vehicleGuess[10] = 	{429,541,415,480,562,565,434,494,402,542,603,475,411,559,561,560,506,451,558,555,477} -- sports cars
vehicleGuess[11] =	{579,400,404,489,479,442,458} -- SUV

-- vehicle tier list, used for giving vehicles
tier = {}
tier[-5] = 	{473,453,606,610,611,608} --dingy,reefer,baggage trailer,farmtrailer,cleantrailer,stairs
tier[-4] = 	{574,583,530,571,572,539} --sweeper,tug,forklift,kart,mower,vortex
tier[-3] = 	{509,481,462,510,448} -- bike,bmx,faggio, mountain bike,pizza boy
tier[-2] = 	{486,532,531,423,522,461,463} --Dozer,Combine,tractor,mr.Whoopee,nrg-500,pcj600,freeway
tier[-1] = 	vehicleGuess[1] --compact cars
tier[0] = 	vehicleGuess[2] --luxery cars
tier[1] = 	vehicleGuess[10]--sportscars
tier[2] = 	{455,515,443,524,431,437,408} --,roadTrain,packer,cementtruck,bus,coach,trashmaster
tier[3] = 	{444,573,455,433} --Monster,Dune,flatbed,barracks
tier[4] = 	{406,425,520,447} -- Dumper,hunter,hydra,seasparrow
tier[5] = 	{432} --rhino



---------------------------------------
-- Function to initiate a zone question
---------------------------------------
function randomZoneQuestion()
	local x,y = math.random(-2980,2960),math.random(-2950,2960)
	local alive = getAlivePlayers()
	local aPlayer = alive[math.random(1,#alive)]
	local vehicle = getPedOccupiedVehicle(aPlayer)
	outputChatBox("The Wise Man from the East requires your assistance with picking the next zone!",aPlayer,255,0,0)

	local vehx,vehy,vehz = getElementPosition(vehicle)
	local rotx,roty,rotz = getElementRotation(vehicle)
	setElementPosition(vehicle,x,y,-50)
	
	setTimer(function()
		local x,y,z = getRandomZone(vehicle)
		local correctZone = getZoneName(x,y,z)
		local falseZone1,falseZone2,falseZone3
		repeat
			falseZone1 = getZoneName(math.random(-2980,2960),math.random(-2950,2960),0)
		until (falseZone1 ~= correctZone)
		repeat
			falseZone2 = getZoneName(math.random(-2980,2960),math.random(-2950,2960),0)
		until (falseZone2 ~= correctZone) and (falseZone2 ~= falseZone1)
		
		local tempx = x
		repeat
			tempx = tempx+5
			falseZone3 = getZoneName(tempx,y,z) -- get zone right next to the correct zone for extra difficulty
		until (falseZone3 ~= correctZone) and (falseZone3 ~= falseZone1) and (falseZone3 ~= falseZone2)
		
		displayAnswers(correctZone,falseZone1,falseZone2,falseZone3)
		textItemSetText(questionText,"What zone are you shown?")
	end,4000,1)
	
	setTimer(function()
		setElementPosition(vehicle,vehx,vehy,vehz+1)
		setElementRotation(vehicle,rotx,roty,rotz)
		resetCam()
	end,14000,1)
	
end

function getRandomZone(vehicle)
	local x,y,z = getElementPosition(vehicle)
	local rotz = math.random(0,360)
	
	local camx,camy,camz = x,y,z+40
	local lookx,looky,lookz = x-150*math.sin(math.rad(rotz)), y+150*math.cos(math.rad(rotz)),z
	
	setAndRememberCam(camx,camy,camz,lookx,looky,lookz)

	return lookx+75*math.sin(math.rad(rotz)),looky-75*math.cos(math.rad(rotz)),z
end

--------------------------
-- Random Vehicle question
--------------------------
function randomVehicleQuestion()
	local vehicleType = math.random(1,11)
	local tableLenght = #vehicleGuess[vehicleType]
	local vehicleID = vehicleGuess[vehicleType][math.random(1,tableLenght)]

	local questionVehicles = {}
	local i = 1
	for index,theElement in ipairs (getElementsByType("object")) do
		if (getElementModel(theElement) == 3515) then
			local x,y,z = getElementPosition(theElement)
			local veh = createVehicle(vehicleID,x,y,z+6)
			attachElements(veh,theElement,0,0,6)
			questionVehicles[i] = veh
			i = i + 1
			moveObject (theElement,20000,x,y,z,0,0,1080)
		end
	end
	
	local correctVeh = getVehicleNameFromModel(vehicleID)
	local falseVeh1,falseVeh2,falseVeh3
	repeat
		falseVeh1 = getVehicleNameFromModel(vehicleGuess[vehicleType][math.random(1,tableLenght)]) -- get a wrong answer from the same type as the correct vehicle
	until (falseVeh1 ~= correctVeh)
	repeat
		falseVeh2 = getVehicleNameFromModel(vehicleGuess[vehicleType][math.random(1,tableLenght)]) -- get a wrong answer from the same type as the correct vehicle
	until (falseVeh2 ~= correctVeh) and (falseVeh2 ~= falseVeh1)
	repeat
		local rand = math.random(1,11)
		falseVeh3 = getVehicleNameFromModel(vehicleGuess[rand][math.random(1,#vehicleGuess[rand])]) -- get a wrong answer
	until (falseVeh3 ~= correctVeh) and (falseVeh3 ~= falseVeh2) and (falseVeh3 ~= falseVeh1)

	displayAnswers(correctVeh,falseVeh1,falseVeh2,falseVeh3)
	textItemSetText(questionText,"What vehicle is on display?")
	
	setTimer(function()
		for index,theElement in ipairs (questionVehicles) do
			destroyElement(theElement)
		end
	end,20000,1)
end



----------------------------------
-- functions for camera management
----------------------------------
cameraTarget = {}
function setAndRememberCam(x,y,z,a,b,c)
	for index,thePlayer in ipairs (getElementsByType("player")) do -- make players watch the sphinx and save their camera target and freeze them
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			setElementFrozen(veh,true)
		end
		cameraTarget[thePlayer] = getCameraTarget(thePlayer)
		setCameraMatrix(thePlayer,x,y,z,a,b,c)
	end
end

function resetCam()
	for index,thePlayer in ipairs (getElementsByType("player")) do
		setCameraTarget(thePlayer,cameraTarget[thePlayer])
	end

	setTimer(function()
		for index,alivePlayer in ipairs (getAlivePlayers()) do
			setElementFrozen(getPedOccupiedVehicle(alivePlayer),false)
		end
	end,1000,1)
end

------------------------------------------
-- function to handle answers and displays
------------------------------------------
function displayAnswers(correctZone,falseZone1,falseZone2,falseZone3)
	clearAnswers()
	
	-- assign a random index between 1 and 4 for every answer
	correctKey = math.random(1,4)
	repeat false1 = math.random(1,4) until (false1 ~= correctKey)
	repeat false2 = math.random(1,4) until (false2 ~= correctKey) and (false2 ~= false1)
	repeat false3 = math.random(1,4) until (false3 ~= correctKey) and (false3 ~= false2) and (false3 ~= false1)
	
	g_Answer = tostring(correctKey) --the correct answer is stored globally, this coresponds to the key pressed
	-- outputDebugString("The correct answer is " .. g_Answer)
	
	local answerTable = {} --make a table with the answers with as index the random numbers generated above
	answerTable[correctKey] = correctZone
	answerTable[false1] = falseZone1
	answerTable[false2] = falseZone2
	answerTable[false3] = falseZone3
	
	-- display the answers
	textItemSetText(answer1Text,"1. " .. answerTable[1])
	textItemSetText(answer2Text,"2. " .. answerTable[2])
	textItemSetText(answer3Text,"3. " .. answerTable[3])
	textItemSetText(answer4Text,"4. " .. answerTable[4])
	textItemSetText(answer5Text,"-> 1. " .. answerTable[1])
	textItemSetText(answer6Text,"-> 2. " .. answerTable[2])
	textItemSetText(answer7Text,"-> 3. " .. answerTable[3])
	textItemSetText(answer8Text,"-> 4. " .. answerTable[4])
end

function clearAnswers() -- empty all text items
	answers = {} -- clear answers given by players
	for index,player in ipairs (getElementsByType("player")) do
		textDisplayAddObserver(answer1,player)
		textDisplayAddObserver(answer2,player)
		textDisplayAddObserver(answer3,player)
		textDisplayAddObserver(answer4,player)
		
		textDisplayRemoveObserver(answer5,player)
		textDisplayRemoveObserver(answer6,player)
		textDisplayRemoveObserver(answer7,player)
		textDisplayRemoveObserver(answer8,player)
	end
	textItemSetText(questionText,"")
	textItemSetText(answer1Text,"")
	textItemSetText(answer2Text,"")
	textItemSetText(answer3Text,"")
	textItemSetText(answer4Text,"")
	textItemSetText(answer5Text,"")
	textItemSetText(answer6Text,"")
	textItemSetText(answer7Text,"")
	textItemSetText(answer8Text,"")
end

answers = {}
function funcInput ( player, key, keyState ) --function handler from pressing the keys.
	if not changeAns then return end
	local answer = answers[player]
	if answer then -- if you already have given an answer and you wish to change it, remove the player from the display of the previous answer
		local text1,text2 = getTextItem(player)
		textDisplayRemoveObserver(text1,player)
		textDisplayAddObserver(text2,player)
	end
	answers[player] = key -- assign the answer given by the player to the answers table
	local text1,text2 = getTextItem(player)
	textDisplayRemoveObserver(text2,player)
	textDisplayAddObserver(text1,player) -- and bold the answer
	
	-- setting vehicle colors
	local r,b,g,a = getTextItemColor(player)
	local veh = getPedOccupiedVehicle(player)
	setVehicleColor(veh,r,b,g)
end

function getTextItem(player) --returns the text item the player is currently assigned to based on their answer
	local key
	local key = answers[player]
	if not key then 
		key = g_Answer
	end
	
	local textItem
	local textItem2
	if key == "1" then
		textItem = answer5
		textItem2 = answer1
	elseif key == "2" then
		textItem = answer6
		textItem2 = answer2
	elseif key == "3" then
		textItem = answer7
		textItem2 = answer3
	elseif key == "4" then
		textItem = answer8
		textItem2 = answer4
	end
	return textItem,textItem2
end

function getTextItemColor(player) -- returns the color of the text item the player is assigned to
	local key = answers[player]
	if not key then 
		return false 
	end
	local textItem
	if key == "1" then
		textItem = answer5Text
	elseif key == "2" then
		textItem = answer6Text
	elseif key == "3" then
		textItem = answer7Text
	elseif key == "4" then
		textItem = answer8Text
	end
	local r,g,b,a = textItemGetColor(textItem)
	return r,g,b,a
end

function checkAnswers()
	local answer = tonumber(g_Answer)
	local text1,text2 = getTextItem()
	
	for index,thePlayer in ipairs (getAlivePlayers()) do
		local score = getElementData(thePlayer,"quizScore")
		if not score then score = 0 end
		
		if (answers[thePlayer] == g_Answer) then
			score = score + 1
			 -- the player has the correct answer, so the display with -> stays visible
			textDisplayRemoveObserver(answer1,thePlayer)
			textDisplayRemoveObserver(answer2,thePlayer)
			textDisplayRemoveObserver(answer3,thePlayer)
			textDisplayRemoveObserver(answer4,thePlayer)
			
		else
			score = score - 1
			-- the thePlayer has the wrong answer, so the display without -> is shown
			textDisplayRemoveObserver(answer1,thePlayer)
			textDisplayRemoveObserver(answer2,thePlayer)
			textDisplayRemoveObserver(answer3,thePlayer)
			textDisplayRemoveObserver(answer4,thePlayer)
			textDisplayRemoveObserver(answer5,thePlayer)
			textDisplayRemoveObserver(answer6,thePlayer)
			textDisplayRemoveObserver(answer7,thePlayer)
			textDisplayRemoveObserver(answer8,thePlayer)
			textDisplayAddObserver(text2,thePlayer)
		end
		setElementData (thePlayer, "quizScore",score)
		--outputChatBox(score)
		
		if score < -5 then score = -5 end
		if score > 5 then score = 5 end
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			local x,y,z = getElementPosition(veh)
			setElementModel(veh,tier[score][math.random(1,#tier[score])])
			setElementPosition(veh,x,y,z+0.5)
		end
	end
end


-----------------------------------------
-- Main functions
-----------------------------------------
function start(newstate,oldstate)
	currentState = newstate
	
	if (newstate == "PreGridCountdown") then
	end
	
	if (newstate == "GridCountdown") then
		outputChatBox("Answer the questions by pressing the corresponding number!",getRootElement(),0,255,0)
		for index,thePlayer in ipairs(getElementsByType("player")) do
			setElementData(thePlayer, "quizScore",0)
			
			textDisplayAddObserver (question, thePlayer )
			textDisplayAddObserver (answer1, thePlayer )
			textDisplayAddObserver (answer2, thePlayer )
			textDisplayAddObserver (answer3, thePlayer )
			textDisplayAddObserver (answer4, thePlayer )
			
			bindKey (thePlayer,"1", "down",funcInput)
			bindKey (thePlayer,"2", "down",funcInput)
			bindKey (thePlayer,"3", "down",funcInput)
			bindKey (thePlayer,"4", "down",funcInput)
		end
	end
	
	if (newstate == "Running" and oldstate == "GridCountdown") then
		cycler()
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

randomZoneFirst = true
function cycler()
	clearAnswers()
	changeAns = true
	
	for index,theVehicle in ipairs (getElementsByType("vehicle")) do
		local x,y,z = getElementPosition(theVehicle)
		if z<10 then 
			blowVehicle(theVehicle) 
		end
	end
	
	if (math.random()<0.5) or randomZoneFirst then
		randomZoneFirst = false
		randomZoneQuestion()
		setTimer(function()
			triggerClientEvent("showProgressBar",resourceRoot,20000)
		end,14000,1)
		roundTime = 34000
	else
		randomVehicleQuestion()
		roundTime = 20000
		triggerClientEvent("showProgressBar",resourceRoot,20000)
	end
	triggerClientEvent("sound",resourceRoot)
	
	setTimer(function()
		changeAns = false
	end,roundTime-500,1)
	
	setTimer(function()
		checkAnswers()
		setTimer(function()
			cycler()
		end,3000,1)
	end,roundTime,1)
end
