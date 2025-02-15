local secondColor = tocolor(0, 255, 0, 255)
local sx, sy = guiGetScreenSize()
local ty = math.floor(sy * 0.65)
local tx = math.floor(ty / 0.807825)
local ex = math.floor(sx * 0.090625)
local ey = math.floor(ex * 0.8103)
local cx = math.floor(sx * 0.1276)
local cy = math.floor(cx * 0.6326)
local textScale = (math.floor((sy*0.00278)*10)/10)
local currentCount = 0
local systemUpTime = getTickCount()
local countdown = 0
local showtimer = 0
local bounce = false
local countdownValue = 4
local alpha = 255
local fadein = 0
local txtX = 32
local txtY = 0.097
local txtSize = 2.5
local txtsinRamp = 0
local Ramp = 0.5
local pCount = 0
local fCount = 0
local sCount = 0.01
local c = {}
local pops = {"sounds/pop1.mp3", "sounds/pop2.mp3", "sounds/pop3.mp3", "sounds/pop4.mp3", "sounds/pop5.mp3", "sounds/pop6.mp3", "sounds/pop7.mp3", "sounds/pop8.mp3", "sounds/pop9.mp3", "sounds/pop10.mp3", "sounds/pop11.mp3"}
local p = 1
showSplat1 = false
showSplat2 = false
showSplat3 = false
showSplat4 = false
splatAngle1 = 0
splatAngle2 = 0
splatAngle3 = 0
vol = 0.01
hurrybool = true

-- SHUFFLE POPS ------------------------------------------------------------------------------------------------------

local function shuffleTable(t)
    local size = #t
    for i = size, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

addEventHandler('onResourceStart', resourceRoot, function()
	shuffleTable(pops)
end)

---------------------------------------------------------------------------------------------------------------------

-- Make Icons -------------------------------------------------------------------------------------------------------

function makeicon()
	logo = guiCreateStaticImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/GTA.png", false )
	guiSetVisible (logo, false )
	br = guiCreateStaticImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/BRb.png", false )
	guiSetVisible (br, false )
	qual = guiCreateStaticImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/qual.png", false )
	guiSetVisible (qual, false )
	elim = guiCreateStaticImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/elim.png", false )
	guiSetVisible (elim, false )
	smalllogo = guiCreateStaticImage( sx-ex, sy-ey, ex, ey, "images/smalllogo.png", false )
	guiSetVisible (smalllogo, false )--   
	setElementData (localPlayer, "Finished" , 0, true)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), makeicon)

---------------------------------------------------------------------------------------------------------------------

-- DX Draw stuff-----------------------------------------------------------------------------------------------------

function onClientRenderClock()
	dxDrawImage(sx-(sx*0.1454), sy*0.1318, cx, cy, "images/count.png", 0, 0, 0, tocolor(255,255,255,fadein), false )
	dxDrawImage((sx/2) - 64, (sy * .09)-13, 128, 77, "images/clock.png", 0, 0, 0, tocolor(255,255,255,fadein), false)
	drawBorderedText(fCount .. "/" .. pCount, textScale, sx-(sx*0.1454)-(sx/150) + (((math.random()-0.5)*8)*sCount), sy*0.1318 + (sx/22) + (((math.random()-0.5)*8)*sCount), sx, sy, tocolor(255, 255, 255, 255), textScale, "default-bold", "center", "top", false, true, true, true)
	if showtimer == 1 then
		fadein = 255
		txtsin = (math.sin(getTickCount()/80)/4)+0.25
		txtsinRamp = txtsin - Ramp	
		if txtsinRamp <= 0 then
			txtsinRamp = 0
		end
		currentCount = getTickCount()
		countdown = 30-(currentCount - systemUpTime)/1000
		colorCount = math.abs((10-(currentCount - systemUpTime)/1000)*25.5)
		if countdown >= 20 then
			txtX = 32
			txtY = 0.097
			txtSize = 2.5
			secondColor = tocolor(255-colorCount, 255, 0, 255)
		elseif countdown >= 10 and countdown <=19.999 then
			txtX = 36
			txtY = 0.095
			txtSize = 2.8
			secondColor = tocolor(255, 255-(colorCount/1.133), 0+(colorCount/8.5), 255)
		elseif countdown <=10 and countdown >= 0.001 then
			txtX = 31
			txtY = 0.090
			txtSize = 3.5
			Ramp = Ramp - 0.005
			if Ramp <= 0 then
				Ramp = 0
			end	
			if hurrybool then
				hurryUp()
			end
		elseif countdown <= 0 then
			dxDrawText("0.0", (sx /2 - txtX), sy * txtY, sx, sy, tocolor(255, 30, 30, 255), 3.5, "default-bold")
		end
		if countdown >= 0.001 and countdown <= 30 then
			dxDrawText(string.format("%2.1f", countdown), (sx /2 - txtX)-(txtsinRamp*25), sy * txtY-(txtsinRamp*25), sx, sy, secondColor, txtSize*(txtsinRamp+1), "default-bold")
		end
		if countdown <= 0 then
			countdown = 0
		end
	elseif showtimer == 0 then 
		bounce = false
	end
	if countdownValue <= 3 and countdownValue >= 0 then
		fadein = fadein + 2.5
		if fadein >= 255 then
			fadein = 255
		end
		drawBorderedText(aCount .. " players remaining", textScale+2, 0, sy*0.2, sx, sy, tocolor(255, 255, 255, 255), textScale+2, "default-bold", "center", "top", false, true, true, true)
	end
	if countdownValue == 3 then
		dxDrawImage((sx/2) - 111-((255-alpha)/2), (sy/2)-111-((255-alpha)/2), 223+(255-alpha),223+(255-alpha), "images/3.png", 0, 0, 0, tocolor(255,255,255,alpha))
		dxDrawText("30.0", (sx /2 - 32), sy * 0.097, sx, sy, tocolor(0, 255, 0, fadein), 2.5, "default-bold")
		alpha = alpha-12
		if alpha <= 0 then
			alpha = 0
		end
		txtsinRamp = 0
		Ramp = 0.5
	elseif countdownValue == 2 then 
		dxDrawImage((sx/2) - 111-((255-alpha)/2), (sy/2)-111-((255-alpha)/2), 223+(255-alpha),223+(255-alpha), "images/2.png", 0, 0, 0, tocolor(255,255,255,alpha))
		dxDrawText("30.0", (sx /2 - 32), sy * 0.097, sx, sy, tocolor(0, 255, 0, fadein), 2.5, "default-bold")
		alpha = alpha-12
		if alpha <= 0 then
			alpha = 0
		end
	elseif countdownValue == 1 then 
		dxDrawImage((sx/2) - 111-((255-alpha)/2), (sy/2)-111-((255-alpha)/2), 223+(255-alpha),223+(255-alpha), "images/1.png", 0, 0, 0, tocolor(255,255,255,alpha))
		dxDrawText("30.0", (sx /2 - 32), sy * 0.097, sx, sy, tocolor(0, 255, 0, fadein), 2.5, "default-bold")
		alpha = alpha-12
		if alpha <= 0 then
			alpha = 0
		end
	elseif countdownValue == 0 then
		dxDrawImage((sx/2) - 211-((255-alpha)/2), (sy/2)-111-((255-alpha)/2), 422+(255-alpha),223+((255-alpha)/2), "images/GO.png", 0, 0, 0, tocolor(255,255,255,alpha))
		alpha = alpha-12
		if alpha <= 0 then
			alpha = 0
		end
	end
	if showSplat1 == true then
		dxDrawImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/splat1.png", splatAngle1, -(tx*0.137), -(ty*0.0356), tocolor(255,255,255,255), false )
	end
	if showSplat2 == true then
		dxDrawImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/splat2.png", splatAngle2, -(tx*0.0242), -(ty*0.034), tocolor(255,255,255,255), false )
	end
	if showSplat3 == true then
		dxDrawImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/splat3.png", splatAngle3, tx*0.178, ty*0.064, tocolor(255,255,255,255), false )
	end
	if showSplat4 == true then
		dxDrawImage( (sx/2)-(tx/2), (sy/2)-(ty/2), tx, ty, "images/win.png", 0, 0, 0, tocolor(255,255,255,255), false )
	end
end
addEventHandler("onClientRender", root, onClientRenderClock)

function drawBorderedText(text, borderSize, width, height, width2, height2, color, size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	text2 = string.gsub(text, "#%x%x%x%x%x%x", "")
	dxDrawText(text2, width+borderSize, height, width2+borderSize, height2, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height+borderSize, width2, height2+borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height-borderSize, width2, height2-borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height, width2-borderSize, height2, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height+borderSize, width2+borderSize, height2+borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height-borderSize, width2-borderSize, height2-borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height-borderSize, width2+borderSize, height2-borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height+borderSize, width2-borderSize, height2+borderSize, tocolor(111, 3, 118, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text, width, height, width2, height2, tocolor(254, 183, 41, fadein), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
end

function qualiShake()
	setTimer( function()
		if pCount == fCount then
			sCount = 0
		else
			sCount = 1-((pCount-fCount)/pCount)
		end
	end, 200, 0)
end

function hurryUp()
	hurrybool = false
	hurryTime = setTimer( function()
		local tik = playSound("sounds/tik.mp3")
		setSoundVolume(tik, vol)
		vol = vol + 0.02
	end, 440, 22)
end

---------------------------------------------------------------------------------------------------------------------

-- LAST CHECKPOINT --------------------------------------------------------------------------------------------------

function lastCP (v) -- Create Last VISIBLE Checkpoint
	c = v
	finishLine = createMarker (c[1][4][1], c[1][4][2], c[1][4][3], "checkpoint", 6, 241, 99, 233, 150)--, true)
end
addEvent( "finishCheckpoint", true )
addEventHandler( "finishCheckpoint", localPlayer, lastCP )

function lastCPIcon () -- Set last checkpoint's chequered flag Icon
	setMarkerIcon (finishLine, "finish")
end
addEvent( "finishCheckpointIcon", true )
addEventHandler( "finishCheckpointIcon", localPlayer, lastCPIcon )

function killLastCP () -- Destroy the last checkpoint
	if finishLine and isElement(finishLine) then
		destroyElement(finishLine); finishLine = nil
	end
end
addEvent( "destroyFinishCheckpoint", true )
addEventHandler( "destroyFinishCheckpoint", localPlayer, killLastCP )

---------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------

function resetTimer () 
	systemUpTime = getTickCount()
end
addEvent( "timeFunc", true )
addEventHandler( "timeFunc", localPlayer, resetTimer )

function playersAlive (threshold, alive)
	pCount = threshold
	if pCount <= 0 then pCount = 0 end
	aCount = alive
end
addEvent( "alivePlayersFunc", true )
addEventHandler( "alivePlayersFunc", localPlayer, playersAlive )

function playersFinished (fin) 
	fCount = fin
end
addEvent( "finishedPlayers", true )
addEventHandler( "finishedPlayers", localPlayer, playersFinished )

function timerShowOn () 
	showtimer = 1
end
addEvent( "timeSwitchOn", true )
addEventHandler( "timeSwitchOn", localPlayer, timerShowOn )

function timerShowOff () 
	showtimer = 0
	fadein = 0
	countdownValue = 4
	if isTimer ( hurryTime ) then 
		killTimer ( hurryTime ) 
		vol = 0.01
		hurrybool = true
	end
	setTimer ( function()
		alpha = 255
		countdownValue = countdownValue - 1
	end, 1000, 5)
end
addEvent( "timeSwitchOff", true )
addEventHandler( "timeSwitchOff", localPlayer, timerShowOff )

function timerShowOffEnd () 
	showtimer = 0
	fadein = 0
	if isTimer ( hurryTime ) then 
		killTimer ( hurryTime ) 
		vol = 0.01
		hurrybool = true
	end
end
addEvent( "timeSwitchOffEnd", true )
addEventHandler( "timeSwitchOffEnd", localPlayer, timerShowOffEnd )

function Eliminated () 
		splatAngle1 = math.random(0, 359)
		splatAngle2 = math.random(0, 359)
		splatAngle3 = math.random(0, 359)
		showSplat1 = true
		setTimer(function()
			showSplat2 = true
			poppers()
		end, 50, 1)
		setTimer(function()
			showSplat3 = true
			poppers()
		end, 100, 1)
		setTimer(function()
			guiSetVisible (elim, true )
			poppers()
		end, 150, 1)
		setTimer(function()
			guiSetVisible (elim, false )
			poppers()
		end, 2850, 1)
		setTimer(function()
			showSplat1 = false
			poppers()
		end, 2900, 1)
		setTimer(function()
			showSplat2 = false
			poppers()
		end, 2950, 1)
		setTimer(function()
			showSplat3 = false
			poppers()
		end, 3000, 1)
	-- end
end
addEvent( "Eliminated", true )
addEventHandler( "Eliminated", localPlayer, Eliminated )

function poppers() 
	local sound = playSound(pops[p])
	setSoundVolume(sound, 0.5)
	p=p+1
	if p == 12 then p = 1 end
end

function quali() 
	splatAngle1 = math.random(0, 359)
	splatAngle2 = math.random(0, 359)
	splatAngle3 = math.random(0, 359)
	showSplat1 = true
	poppers()
	setTimer(function()
		showSplat2 = true
		poppers()
	end, 50, 1)
	setTimer(function()
		showSplat3 = true
		poppers()
	end, 100, 1)
	setTimer(function()
		guiSetVisible (qual, true )
		poppers()
	end, 150, 1)
	setTimer(function()
		guiSetVisible (qual, false )
		poppers()
	end, 2850, 1)
	setTimer(function()
		showSplat1 = false
		poppers()
	end, 2900, 1)
	setTimer(function()
		showSplat2 = false
		poppers()
	end, 2950, 1)
	setTimer(function()
		showSplat3 = false
		poppers()
	end, 3000, 1)
end
addEvent( "qualified", true )
addEventHandler( "qualified", localPlayer, quali )

function startAnim () 
	qualiShake()
	setCameraMatrix(3857, 395, 61, 3857, 395, 0, 0, 2)
	guiSetVisible (logo, true )
	poppers()
    playSoundFrontEnd ( 10 )
	setTimer ( function ()
		poppers()
		guiSetVisible (br, true )
	end, 1000, 1)
	setTimer(function()
		showSplat1 = true
		poppers()
	end, 1050, 1)
	setTimer(function()
		showSplat2 = true
		poppers()
	end, 1100, 1)
	setTimer(function()
		showSplat3 = true
		poppers()
	end, 1150, 1)
	setTimer ( function ()
		guiSetVisible (br, false )
		poppers()
	end, 4750, 1)
	setTimer ( function ()
		guiSetVisible (logo, false )
		poppers()
	end, 4800, 1)
	setTimer ( function ()
		showSplat1 = false
		poppers()
	end, 4850, 1)
	setTimer ( function ()
		showSplat2 = false
		poppers()
	end, 4900, 1)
	setTimer ( function ()
		showSplat3 = false
		poppers()
	end, 4950, 1)
	setTimer ( function ()
		guiSetVisible (smalllogo, true )
		setCameraTarget(localPlayer) 
	end, 5000, 1)
end
addEvent( "startup", true )
addEventHandler( "startup", localPlayer, startAnim )

function prestartAnim () 
	setCameraMatrix(3857, 395, 61, 3857, 395, 0, 0, 2)
end
addEvent( "prestartup", true )
addEventHandler( "prestartup", localPlayer, prestartAnim )

function winner ()
	setElementFrozen(getPedOccupiedVehicle(localPlayer), true)
	splatAngle1 = math.random(0, 359)
	splatAngle2 = math.random(0, 359)
	splatAngle3 = math.random(0, 359)
	showSplat1 = true
	poppers()
	setTimer(function()
		showSplat2 = true
		poppers()
	end, 50, 1)
	setTimer(function()
		showSplat3 = true 
		poppers()
	end, 100, 1)
	setTimer(function()
		showSplat4 = true
		local winsound = playSound("sounds/win.mp3")
		setSoundVolume(winsound, 0.5)
		poppers()
	end, 150, 1)
end
addEvent( "WINNER", true )
addEventHandler( "WINNER", localPlayer, winner )

function varClear(n, m)
	playSoundFrontEnd(m[1])
	setTimer ( function()
		playSoundFrontEnd(m[2])	
	end, n[1], 14)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[3])
	end, n[2], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
	end, n[3], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[1])
	end, n[4], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[3])
	end, n[5], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[1])
	end, n[6], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
	end, n[7], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[3])
	end, n[8], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
	end, n[9], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[3])
		playSoundFrontEnd(m[1])
	end, n[10], 1)
	setTimer ( function()
		playSoundFrontEnd(m[4])
		playSoundFrontEnd(m[5])
		playSoundFrontEnd(m[3])
	end, n[11], 1)
end
addEvent( "clearVar", true )
addEventHandler( "clearVar", localPlayer, varClear )
