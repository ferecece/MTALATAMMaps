-- Clientside Script
-- Author: Ali_Digitali
-- twitch.tv/AliDigitali
-- Anyone reading this has permission to copy parts of this script

--setDevelopmentMode(true)

-- Generate a string that is unique for this resource (the resource name) to be used as a data key.
uniqueKey = tostring(getResourceName(getThisResource()))

--function to update the race states
function clientRaceState(dataName,oldValue)
	if dataName == uniqueKey.."raceState" then
		local newstate = getElementData(source,uniqueKey.."raceState")
		if (newstate == "GridCountdown") then
			
			local x,y,z = 2083,-133.2,36.8
			createEffect("carwashspray", 2083,-133.2,36.8)
			createEffect("carwashspray", 2051,-133.2,36.8)
			
			
			createEffect("carwashspray", 2065.1,-115,36.8)
			createEffect("carwashspray", 2065.1,-152,36.8)
		end
	end
end
addEventHandler("onClientElementDataChange",root,clientRaceState)



local white = dxCreateTexture("black.png")
function drawAreas()
	for i=1,4 do
	local x,y,z = getElementPosition(getElementByID("answer"..i))
	dxDrawMaterialLine3D(x-15,y,z+100,x+15,y,z+100,white,35,tocolor(0,255,0,50),x,y,z) -- player 
	end
end
addEventHandler("onClientRender",root,drawAreas)


screenWidth, screenHeight = guiGetScreenSize ( )
function displayStart()
	local text = "Count the number of DUMPERS\n that enter the pirates' depot without leaving!"
	dxDrawText (text,screenWidth,screenHeight/4+2,0,0, tocolor ( 0, 0, 0, 255 ), 1.5,"pricedown","center")
	dxDrawText (text,screenWidth,screenHeight/4,0,0, tocolor ( 0, 255, 0, 255 ), 1.5,"pricedown","center")
end

function showText()
	addEventHandler("onClientRender",root,displayStart)
	
	setTimer(function()
		removeEventHandler("onClientRender",root,displayStart)
	end,10000,1)
	
	triggerServerEvent("fadeIn",localPlayer,localPlayer)
end
addEvent("onClientScreenFadedIn",true)
addEventHandler("onClientScreenFadedIn",root,showText)


function actualBar()
	dxDrawRectangle (screenWidth/4, 50, screenWidth/2, 30, tocolor(0,0,0,200) ) -- black background
	
	local scale = getTimerDetails(barTimer)/g_Time*1000
	timeLeft = math.max(scale - 250, 0)/750
	local p = -510*(timeLeft^2)
	local r,g = math.max(math.min(p + 255*timeLeft + 255, 255), 0), math.max(math.min(p + 765*timeLeft, 255), 0)
	dxDrawRectangle ( 	screenWidth/4 + 2.5, 
						50 + 2.5, 
						screenWidth/2 - 5, 
						30-5, 
						tocolor(r,g,0,150) 
					)
		--Finally, the actual timeLeft
	dxDrawRectangle ( 	screenWidth/4 + 2.5, 
						50 + 2.5, 
						(1-scale/1000)*(screenWidth/2 - 5), 
						30-5, 
						tocolor(r,g,0,150) 
					)
end


function progressBar(time)
	g_Time = time
	addEventHandler("onClientRender",root,actualBar)
	barTimer = setTimer(function()
		removeEventHandler("onClientRender",root,actualBar)
	end,time,1)
end
addEvent("showProgressBar",true)
addEventHandler("showProgressBar",root,progressBar)
