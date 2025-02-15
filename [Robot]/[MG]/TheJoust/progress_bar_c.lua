screenWidth, screenHeight = guiGetScreenSize ( )

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
	addEventHandler("onClientRender", root, actualBar)
	barTimer = setTimer(function()
		removeEventHandler("onClientRender", root, actualBar)
		playSFX("script", 6, 1, false) -- airhorn sound
	end,time,1)
end
addEvent("showProgressBar",true)
addEventHandler("showProgressBar",root,progressBar)




local game_name = ""
local game_info = ""
function drawGameInfo()
    dxDrawText (game_name,
				screenWidth/4,
				50,
				3/4*screenWidth, 
				80, 
				tocolor ( 255, 255, 255, 255 ),
				1.5,
				"default-bold",
				"center",
				"center",
				false,
				true,
				true)
    dxDrawText (game_info,
			screenWidth/4,
			90,
			3/4*screenWidth, 
			screenHeight, 
			tocolor ( 255, 255, 255, 255 ),
			1,
			"default",
			"center",
			"top",
			false,
			true,
			true)
end

function showGameInfo(show, gameName, gameInfo)
	if show then
		game_name = gameName
		game_info = gameInfo
		addEventHandler("onClientRender", root, drawGameInfo)
	else
		removeEventHandler("onClientRender", root, drawGameInfo)
	end
end
addEvent("showGameInfo",true)
addEventHandler("showGameInfo", root, showGameInfo)