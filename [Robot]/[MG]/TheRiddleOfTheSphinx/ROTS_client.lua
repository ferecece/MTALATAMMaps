-- The Riddle Of The Sphinx clientside script by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script\

-- Things handled in this script:
-- - Drawing of the color shapes on the ground
-- - progress bars
-- - laugh

local red = dxCreateTexture("red.png")
local blue = dxCreateTexture("blue.png")
local green = dxCreateTexture("green.png")
function drawAreas()
	dxDrawMaterialLine3D(-156.1,2136,  57.25,-156.1,2170.8,57.3,blue,30,tocolor(0,0,255,50),-156.1,2136,60) -- player blue
	dxDrawMaterialLine3D(-120.5,2202.5,57.25,-120.5,2242.5,57.3,red,25,tocolor(255,0,0,50),-120.5,2202.5,60) -- player red
	dxDrawMaterialLine3D(-158.4,2274.5,57.25,-158.4,2308.6,57.3,green,30,tocolor(0,255,0,50),-158.4,2268.5,60) -- player green
	
	dxDrawMaterialLine3D(-179.3,2218.65,52.05,-179.3,2228.65,52.2,red,10,tocolor(255,0,0,100),-179.3,2218.65,54) -- sphinx red
	dxDrawMaterialLine3D(-179.3,2205.2 ,52.05,-179.3,2215.2, 52.2,blue,10,tocolor(0,0,255,100),-179.3,2205.2,54) -- sphinx blue
	dxDrawMaterialLine3D(-179.3,2232.2 ,52.05,-179.3,2242.2, 52.2,green,10,tocolor(0,255,0,100),-179.3,2218.65,54) -- sphinx green
end
addEventHandler("onClientRender",root,drawAreas)


function playLaugh()
	local laugh = playSound("evil_laugh.wav")
end
addEvent("laugh",true)
addEventHandler("laugh",root,playLaugh)


screenWidth, screenHeight = guiGetScreenSize ( )
function displayStart()
	dxDrawText ("Remember where the cone without",screenWidth,screenHeight/4+2,0,0, tocolor ( 0, 0, 0, 255 ), 2.02,"pricedown","center")
	dxDrawText ("Remember where the cone without",screenWidth,screenHeight/4,0,0, tocolor ( 255, 120, 0, 255 ), 2,"pricedown","center")
	
	dxDrawText ("the explosives moves to...",screenWidth,screenHeight/4+52,0,0, tocolor ( 0, 0, 0, 255 ), 2.02,"pricedown","center")
	dxDrawText ("the explosives moves to...",screenWidth,screenHeight/4+50,0,0, tocolor ( 255, 120, 0, 255 ), 2,"pricedown","center")
end

function showText()
	addEventHandler("onClientRender",root,displayStart)
	
	setTimer(function()
		removeEventHandler("onClientRender",root,displayStart)
	end,10000,1)
	
	triggerServerEvent("lookatsphinx",localPlayer,localPlayer)
	playLaugh()
end
-- addEvent("showHelpText",true)
-- addEventHandler("showHelpText",root,showText)
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
