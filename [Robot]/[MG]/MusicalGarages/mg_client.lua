local customModels = {
	[3043] = {
--		["dff"] = 'files/cuntainer.dff',
		["col"] = 'files/cuntainer.col',
	},
}

--Load Models from customModels Array
addEventHandler('onClientResourceStart', resourceRoot,
function()
	for i,v in pairs (customModels) do
--		engineReplaceModel(engineLoadDFF(tostring(v["dff"])), i)
		engineReplaceCOL(engineLoadCOL(tostring(v["col"])), i)
		engineSetModelLODDistance(i, 10000)
	end
	outputChatBox("Custom models loaded")
	addEventHandler("onClientRender", root, drawUI)  -- Keep everything visible with onClientRender.
end
)

local screenWidth, screenHeight = guiGetScreenSize() -- Get the clients screenWidth and Height

local isNoteRotated = false
local isShowNote    = false

local noteRotatePeriod = 15
local currectPeriod    = 0

addEvent("seChangeNoteState", true)
addEventHandler("seChangeNoteState", localPlayer, function(newStatus)
    isShowNote = newStatus
	toggleMusic()
end
)

local isMutePressed = false
addEventHandler("onClientKey", root, function(button, pressDown)
	if button == "m" and pressDown then
        isMutePressed = not isMutePressed
		toggleMusic()
    end
end
)

local musicObject
function toggleMusic()
	if isMutePressed then
		if musicObject then
			stopSound(musicObject)
		end
	else
		if isShowNote then
			musicObject = playSFX("genrl", 72, 3, true)
			setSoundVolume(musicObject, 1.0)
		else
			stopSound(musicObject)
		end
	end
end

local R = 125
local G = 230
local B = 247
local iR = false
local iG = true
local iB = false
function getNextColor()
	-- I know that I should've use an array/table instead
	if R <= 80 or R >= 248 then
		iR = not iR
	end
	if G <= 80 or G >= 248 then
		iG = not iG
	end
	if B <= 80 or B >= 248 then
		iB = not iB
	end
	
	if iR then
		R = R - math.random(1,4)
	else
		R = R + math.random(1,4)
	end
	if iG then
		G = G - math.random(1,4)
	else
		G = G + math.random(1,4)
	end
	if iB then
		B = B - math.random(1,4)
	else
		B = B + math.random(1,4)
	end
	
	R = math.clamp(R, 80, 250)
	G = math.clamp(G, 80, 250)
	B = math.clamp(B, 80, 250)
	
	return tocolor(R, G, B, 255)
end

function math.clamp(value, lower, upper) 
	if value < lower then  
		value = lower 
	elseif value > upper then  
		value = upper  
	end 
	return value 
end 

function drawUI()
	if isShowNote then
		-- Draw note
		if isNoteRotated then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25 - 4, 128, 128, 'files/note.png', 0, 0, 0, getNextColor())
		else
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25 - 4, 128, 128, 'files/note.png', 15, 0, 0, getNextColor())
		end
	end
	currectPeriod = currectPeriod + 1
	if noteRotatePeriod < currectPeriod then
		isNoteRotated = not isNoteRotated
		currectPeriod = 0
	end
	
	-- Draw empty box
	dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'files/box.png')
	
	-- Draw NOTICE FOR PLAYERS
	dxDrawText ("Press 'M' to toggle music", screenWidth / 2 - 128, screenHeight - 30, 256, 256, tocolor ( 255, 72, 72, 255 ), 0.8, "bankgothic")
end