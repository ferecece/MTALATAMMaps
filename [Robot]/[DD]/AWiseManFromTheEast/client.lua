-- CLIENTSIDE script for A Wise Man From The East, by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script.

-- This script handles the following:
-- - creation and timing of the time left bar at the bottom of the screen, triggered from serverside.
-- - play the gong sound

function actualBar()
	dxDrawRectangle (screenWidth/4, screenHeight, screenWidth/2, 30, tocolor(0,0,0,200) ) -- black background
	
	local scale = getTimerDetails(barTimer)/g_Time*1000
	timeLeft = math.max(scale - 250, 0)/750
	local p = -510*(timeLeft^2)
	local r,g = math.max(math.min(p + 255*timeLeft + 255, 255), 0), math.max(math.min(p + 765*timeLeft, 255), 0)
	dxDrawRectangle ( 	screenWidth/4 + 2.5, 
						screenHeight + 2.5, 
						screenWidth/2 - 5, 
						30-5, 
						tocolor(r,g,0,150) 
					)
		--Finally, the actual timeLeft
	dxDrawRectangle ( 	screenWidth/4 + 2.5, 
						screenHeight + 2.5, 
						(1-scale/1000)*(screenWidth/2 - 5), 
						30-5, 
						tocolor(r,g,0,150) 
					)
end

screenWidth, screenHeight = guiGetScreenSize ( )
screenHeight = screenHeight * 0.9

function progressBar(time)
	g_Time = time
	addEventHandler("onClientRender",root,actualBar)
	barTimer = setTimer(function()
		removeEventHandler("onClientRender",root,actualBar)
	end,time,1)
end
addEvent("showProgressBar",true)
addEventHandler("showProgressBar",root,progressBar)

function soundHandler()
	local sound = playSound("gong.wav")
end
addEvent("sound",true)
addEventHandler("sound",root,soundHandler)