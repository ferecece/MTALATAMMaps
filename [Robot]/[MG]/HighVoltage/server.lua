

local x,y,z = -2850,-70,80
base = createObject(1337,x,y,z,0,0,90)
setElementAlpha(base,0)
setElementCollisionsEnabled(base,false)
for i=-6,6 do
	local fence1 = createObject(7657,x,y,z)
	local fence2 = createObject(7657,x,y,z)
	attachElements(fence1,base,10,i*3.45,0,90,0,0)
	attachElements(fence2,base,-10,i*3.45,0,90,0,0)
end
local fence1 = createObject(3458,x,y,z)
local fence2 = createObject(3458,x,y,z)
local fence3 = createObject(3458,x,y,z)
attachElements(fence1,base,0,7*3.45,-1.5)
attachElements(fence2,base,0,-7*3.45,-1.5)
attachElements(fence3,base,0,0,-1.5,0,0,90)

spawn1 = createObject(3458,-2879.4,-70,78.5,0,0,90)
spawn2 = createObject(3458,-2884.5,-70,78.5,0,0,90)
			-- Setting water properties.
height = 35
SizeVal = 2998
-- Defining variables.
southWest_X = -SizeVal
southWest_Y = -SizeVal
southEast_X = SizeVal
southEast_Y = -SizeVal
northWest_X = -SizeVal
northWest_Y = SizeVal
northEast_X = SizeVal
northEast_Y = SizeVal
	
water = createWater ( southWest_X, southWest_Y, height, southEast_X, southEast_Y, height, northWest_X, northWest_Y, height, northEast_X, northEast_Y, height )
setWaterLevel ( height )
setWaterColor(255,0,0)

function start(newstate,oldstate) --function to update the race states
	
	if (newstate == "GridCountdown") then
		-- creating the text displays and adding observers
		
		outputChatBox("Stay on the platform as long as you can!",root,0,255,0)
		
		countdownDisplay = textCreateDisplay()
		countdownText = textCreateTextItem("15",0.5,0.25,"medium",255,0,0,255,3,"center","center",255)
		textDisplayAddText (countdownDisplay,countdownText)
		
		for index,thePlayer in ipairs (getElementsByType("player")) do
			textDisplayAddObserver(countdownDisplay,thePlayer)
		end
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
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
			moveObject(base,400000,x+4000,y,z)
			local vel = 4000/400000 --get the velocity of the tower (in meters/miliseconds)
			for index,veh in ipairs (getElementsByType("vehicle")) do
				setElementVelocity(veh,vel*1000/50,0,0)
			end
			
			destroyElement(spawn1)
			destroyElement(spawn2)
			
		end,15000,1)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )
