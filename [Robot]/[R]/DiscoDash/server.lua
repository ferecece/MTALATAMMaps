local fence,fence2,fence3,fence4
function createThings()
	-- fences at the start
	fence  = createObject(987,1644.3,3071,103.5,0,0,180)
	fence2 = createObject(987,1632.3,3071,103.5,0,0,180)
	fence3 = createObject(987,1620.3,3071,103.5,0,0,180)
	fence4 = createObject(987,1608.3,3071,103.5,0,0,180)

	local x,y,z = getElementPosition(getElementByID("start")) -- starting pathway
	for i=1,40,1 do
		local obj = createObject(8172,x,y-i*158,z) -- creating the path
		local objUp = createObject(8172,x,y-i*158,z+100,0,0,0) -- creating the path
		setElementDoubleSided(obj,true)
	end
		
	for b=1,10,1 do
		for a=-4,4,1 do
			createObject(3080,x+a*4.1,y-b*600,z+1,0,0,180) -- creating ramps
		end
	end
	for c=-1,158,1 do
		--local obj1 = createObject(4585,x-37.5,y-c*47,z+50)-- creating the barrier
		--local obj2 = createObject(4585,x+37.5,y-c*47,z+50)
		local obj1 = createObject(8171,x-19.5,y-c*40,z+60,90,270,0)-- creating the barrier
		local obj2 = createObject(8171,x+19.5,y-c*40,z+60,90,90,0)
		setElementAlpha(obj1,0)
		setElementAlpha(obj2,0)
	end
end
createThings()

function start(newstate,oldstate) --function to update the race states
	setElementData(root,"racestate",newstate,true) -- used to synchronise with the client
	currentstate = newstate
	if (newstate == "GridCountdown") then
		for index,theVehicle in ipairs (getElementsByType("vehicle")) do
			local newcar = (vehicles[math.random(#vehicles)]) -- generates a random car from entered ID's
			setElementModel(theVehicle,newcar) -- sets the player car to the random generated vehicle
		end
		
		-- creating the text displays and adding observers
		countdownDisplay = textCreateDisplay()
		countdownText = textCreateTextItem("15",0.5,0.25,"medium",255,0,0,255,3,"center","center",255)
		textDisplayAddText (countdownDisplay,countdownText)
		
		for index,thePlayer in ipairs (getElementsByType("player")) do
			textDisplayAddObserver(countdownDisplay,thePlayer)
		end
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		--outputChatBox("The gate will open in 15 seconds!",root,255,0,0)
		triggerClientEvent ("changeGrav",resourceRoot)
		
		local timeLeft = 15
		setTimer(function()
			timeLeft = timeLeft - 1
			if (timeLeft <= 0) then
				textDestroyDisplay(countdownDisplay)
			else
				textItemSetText(countdownText,tostring(timeLeft))
			end
		end,1000,15)
		
		
		setTimer(function()
			setTimer( spawnRandomVehicle, 8000,0)
		end,7000,1)
		
		setTimer(function()
			moveObject(fence ,5000,1644.3,3071,113.5)
			moveObject(fence2,5000,1632.3,3071,113.5)
			
			moveObject(fence3,5000,1620.3,3071,113.5)
			moveObject(fence4,5000,1610.3,3071,113.5)
		end,15000,1)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function vehicleEnter ( theVehicle, seat, jacked )
		setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0)
		addNeon(theVehicle,true)
		setNeonColor(theVehicle,0,255,0)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(),vehicleEnter)

function addNeon(theVehicle)
	local x,y,z = getElementPosition(theVehicle)
	
	local marker1 = createMarker(x,y,z,"corona",2,0,255,0)
	setTimer(attachElements,200,1,marker1,theVehicle,0,-1,-1.2)
	
	local marker2 = createMarker(x,y,z,"corona",2,0,255,0)
	setTimer(attachElements,200,1,marker2,theVehicle,0,1,-1.2)
	
	local neon1 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon1,theVehicle,-0.9,0,-0.6)
	
	local neon2 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon2,theVehicle,0.9,0,-0.6)
	
	local neon3 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon3,theVehicle,0,2,-0.55,0,0,90)
	
	local neon4 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon4,theVehicle,0,-2,-0.55,0,0,90)
end

neons = {[1576]=true,[1577]=true,[1578]=true,[1580]=true}

function setNeonColor(theVehicle,r,g,b)
	local neonObject
	
	if (r == 255) and (g == 255) then
		neonObject = 1577
	elseif (r==255) then
		neonObject = 1580
	elseif (g == 255) then
		neonObject = 1578
	end
	
	for index,theObject in ipairs (getAttachedElements(theVehicle)) do
		if getElementType(theObject) == "marker" then
			if getMarkerType(theObject) == "corona" then
				setMarkerColor(theObject,r,g,b,255)
			end
		end
		if neons[getElementModel(theObject)] then
			setElementModel(theObject,neonObject)
		end
	end
end

function sendGrav ( )
	if (currentstate == "Running") then
		triggerClientEvent (source,"changeGrav",resourceRoot)
	end
end
addEventHandler ( "onPlayerJoin", getRootElement(), sendGrav )

-- all the possible vehicles you can get --
vehicles = {400,402,403,404,405,409,410,411,412,413,414,415,416,418,419,420,422,423,424,426,427,428,
			429,431,436,439,440,441,442,443,444,445,451,455,456,457,458,459,461,462,463,466,467,468,
			471,474,475,477,478,479,480,481,482,483,489,490,491,492,495,498,499,500,502,504,505,506,
			507,508,509,510,514,515,516,517,518,521,522,526,527,529,530,531,533,534,535,536,539,540,
			541,542,543,544,545,546,547,549,550,551,552,554,555,558,559,560,561,562,565,566,567,571,
			572,573,574,575,576,578,579,580,581,582,583,585,586,587,588,589,596,597,598,599,600,602,
			603,488,513}


-- all the random extra delays you can get --
extratimes = {3000,5000,7000}
  
function spawnRandomVehicle( )
discoChance = 0.1
	for index, playerid in ipairs (getElementsByType("player")) do
		local thePlayer =  getPedOccupiedVehicle(playerid)
		if thePlayer then 
			local time1 = (extratimes[math.random(#extratimes)]) --gets extra time randomly on top of counter at end of script--
			local time2 = time1-2000 --timer duration to paint orange--
			local time3 = time1-1000 --timer duration to paint red--
			
			-- timer to paint the car orange after time 2 --	
			setTimer ( function()
					if thePlayer then
						setVehicleColor(thePlayer, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
						setNeonColor(thePlayer,255,255,0)
					end
				end, time2, 1 )
			
			-- timer to paint the car red after time 3--	
			setTimer ( function()
					if thePlayer then
						setVehicleColor(thePlayer, 255, 0, 0, 255, 0, 0,  255, 0, 0,  255, 0, 0 )
						setNeonColor(thePlayer,255,0,0)
					end
				end, time3, 1 )
			
			setTimer ( function()
				if thePlayer then
					local newcar = (vehicles[math.random(#vehicles)]) -- generates a random car from entered ID's
					local x, y, z = getElementPosition(thePlayer) --gets location of player--
		
					setElementModel(thePlayer,newcar) -- sets the player car to the random generated vehicle --
					setElementRotation(thePlayer,0,0,180)
					setElementPosition(thePlayer, x, y, z + 0.5) -- sets new player location 4and small boost in case someone gets stuck--
					--local velx,vely,velz = getElementVelocity(thePlayer)
					--setElementVelocity(thePlayer,velx,vely,velz)
					
					if math.random() < discoChance then				
						discoColors(thePlayer)
						setElementData(thePlayer,"disco",true,true)	
					else
					setElementData(thePlayer,"disco",false,true)
					setVehicleColor(thePlayer, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paints it green --
					setNeonColor(thePlayer,0,255,0)
					end
				end
			end, time1, 1 )
		end
	end
end

function changeVehColors(theVehicle,r1,g1,b1,r2,g2,b2)
	if theVehicle then
		setVehicleColor(theVehicle,r1,g1,b1,r2,g2,b2)     -- yellow		
		setNeonColor(theVehicle,r1,g1,b1)
	end
end


function discoColors(theVehicle)
	changeVehColors(theVehicle,255,255,0,0,255,255)     -- yellow		

	setTimer ( function()
		changeVehColors(theVehicle,0,255,255,0,255,0) -- cyan
	end, 200, 1 )

	setTimer ( function()
		changeVehColors(theVehicle,0,255,0,255,0,255)	   -- lime
	end, 400, 1 )

	setTimer ( function()
		changeVehColors(theVehicle,255,0,255,255,255,0) -- magenta
	end, 600, 1 )

	setTimer ( function()
		if getElementData(theVehicle,"disco") == true and getVehicleOccupant(theVehicle) then
		discoColors(theVehicle)
		else
		setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paints it green --
		setNeonColor(theVehicle,0,255,0)
		end
	end, 800, 1 )
end
