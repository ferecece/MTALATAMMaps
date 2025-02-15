-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- GUI 
	offsets = {0.8, 0.92} 
	messageSize = 1.2
	textSize = 3
	
	-- Info box
	b_offsets = {0.25, 0.4, 0.5, 0.35} -- X-left, Y-top, width, height for a box
	t_offsets = {0.27, 0.5, 0.63, screenX/1200} -- X-left, Y1, Y2, textsize
	i_size = {0.2, 0.207}
	
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
 -- 4:3 and others screens
else 
	-- GUI
	offsets = {0.72, 0.9}
	messageSize = 1
	textSize = 2
	
	-- Info box
	b_offsets = {0.25, 0.4, 0.5, 0.35} -- X-left, Y-top, width, height for a box
	t_offsets = {0.27, 0.5, 0.63, screenX/1200} -- X-left, Y1, Y2, textsize
	i_size = {0.27, 0.207}
	
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
end

arrowTexture = dxCreateTexture('arrows.png')

-- Records
displayStats = false
statsInited = false
statsPage = 1 -- NRG, Infernus, Hydra, Tug, BMX, Bike, Mountain Bike, Mower (1-7)
statsAlpha = 0
displayedRecords = {}
for j = 1, 8 do
	displayedRecords[j] = {}
	for i = 1, 10 do
		displayedRecords[j][i] = {}
		displayedRecords[j][i]["playername"] = ""
		displayedRecords[j][i]["time"] = 0
	end
end
helpText = "F5"

-- Function that enables stats and requests data from the database
-- Called from key bind and finish of the race
function showStats()
	triggerServerEvent("getStats", getLocalPlayer())
	
	-- Toggle stats
	displayStats = not displayStats
end

-- Generating text message
local b = 1
local button = {}
for vehicleMouseLookKey, state in pairs(getBoundKeys("radio_user_track_skip")) do
	button[b] = vehicleMouseLookKey
	bindKey(vehicleMouseLookKey, "down", showStats)
	
	b = b + 1 
	if b > 4 then 
		b = 4
		break
	end
end 

b = b - 1
helpText = string.upper(button[1])
if b > 1 then
	for i = 2, b do
		helpText = helpText.. " #E7D9B0or #00FF00" ..string.upper(button[i])
	end
end
outputChatBox("#E7D9B0You can get records for vehicles by pressing #00FF00" ..helpText, 0, 0, 0, true)

-- Function that draws stats on the screen
function drawStats()
	if not statsInited or not getPedOccupiedVehicle(localPlayer) or statsPage == 0 then return end

	-- Draw vehicle's name
	local vehicleName = ""
	
	if statsPage == 1 then vehicleName = "NRG-500"
	elseif statsPage == 2 then vehicleName = "Infernus"
	elseif statsPage == 3 then vehicleName = "Hydra"
	elseif statsPage == 4 then vehicleName = "Tug"
	elseif statsPage == 5 then vehicleName = "BMX" 
	elseif statsPage == 6 then vehicleName = "Bike" 
	elseif statsPage == 7 then vehicleName = "Mountain Bike" 
	elseif statsPage == 8 then vehicleName = "Mower" end
		
	dxDrawText(vehicleName.. " Records", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
	dxDrawText(vehicleName.. " Records", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")

	-- Draw records for this vehicle
	for i = 1, 10 do
		dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07+0.05*i), screenX*st_offsets[1]*1.105, screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*1.5, st_offsets[5]*1.5, "bankgothic", "right")
		dxDrawText(tostring(displayedRecords[statsPage][i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07+0.05*i), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*1.5, st_offsets[5]*1.5, "bankgothic")
		dxDrawText(convertToRaceTime(displayedRecords[statsPage][i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07+0.05*i), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*1.5, st_offsets[5]*1.5, "bankgothic", "right")
	end
	
	-- Draw arrow
	if displayStats then
		dxDrawImage((screenX*s_offsets[1])+(screenX*s_offsets[3])-(screenX/22), (screenY*b_offsets[2])-(screenY*i_size[2]/2)-(screenX/60), screenX/30, screenX/60, arrowTexture, 0, 0, 0, tocolor(255, 255, 255, statsAlpha))
	end
end

-- Function that convers time in ms into string in format "MM:SS.MS"
function convertToRaceTime(time)
	if time ~= nil then
		local m = math.floor(time / 1000 / 60)
		local s = math.floor((time / 1000) - m*60)
		local ms = math.floor(time - (m*60+s)*1000)
		
		if m < 1 then m = ""
		else m = m.. ":" end
		if s < 10 then s = "0" ..s end
		if ms < 10 then ms = "00" ..ms
		elseif ms < 100 and ms > 9 then ms = "0" ..ms end
		
		return m.. "" ..s.. "." ..ms
	end
end

-- Onscreen stuff and seed generation
addEventHandler("onClientRender", getRootElement(), function()
	if displayStats then
		-- Fade In
		if statsAlpha < 255 then statsAlpha = statsAlpha + 51
		else statsAlpha = 255 end
	else
		-- Fade out
		if statsAlpha > 0 then statsAlpha = statsAlpha - 51
		else statsAlpha = 0 end
	end
	
	-- Draw Stats
	if statsAlpha > 200 then
		dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, 200, 50))
	else
		dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, statsAlpha, 50))
	end
	drawStats()
end )

-- Event called from the server script for receiving stats data
addEvent("receiveStats", true)
addEventHandler("receiveStats", getRootElement(), function(recordsStats)		
	-- Handle Vehicle Records
	for j = 1, 8 do
		for i, recordsData in pairs(recordsStats[j]) do 
			displayedRecords[j][i]["playername"] = recordsData["playername"]
			displayedRecords[j][i]["time"] = recordsData["score"]
		end
		
		if #recordsStats[j] < 10 then
			for i = #recordsStats[j] + 1, 10 do
				displayedRecords[j][i]["playername"] = "-- EMPTY --"
				displayedRecords[j][i]["time"] = 0
			end
		end
	end
	
	statsInited = true
end )

-- Event used to manage player inputs when stats displayed
addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end
	
	if press and displayStats then
		if button == "arrow_r" then
			if statsPage == 8 then statsPage = 1
			else statsPage = statsPage + 1 end
		elseif button == "arrow_l" then
			if statsPage == 1 then statsPage = 8
			else statsPage = statsPage - 1 end
		end
	end
end )