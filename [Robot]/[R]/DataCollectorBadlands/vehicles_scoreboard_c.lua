-- Screen stuff
screenX, screenY = guiGetScreenSize()
s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
st_offsets = {0.27, 0.20, 0.45} -- X-left, Y1, Y2, textsize

-- Records
displayStats = false
statsInited = false
statsAlpha = 0
statsPage = 0
displayedRecords = {}
for i = 1, 128 do
	displayedRecords[i] = {}
	displayedRecords[i]["playername"] = ""
	displayedRecords[i]["vehiclename"] = ""
	displayedRecords[i]["time"] = 0
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
outputChatBox("#E7D9B0You can get records for your vehicle by pressing #00FF00" ..helpText, 0, 0, 0, true)

-- Function that draws stats on the screen
function drawStats()
	if not statsInited or not getPedOccupiedVehicle(localPlayer) then return end

	-- Draw vehicle's name
	dxDrawText("Badlands Records", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]-0.01+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), (screenY/1080)*4.02, (screenY/1080)*4.15, "beckett")
	dxDrawText("Badlands Records", screenX*st_offsets[1], screenY*(st_offsets[2]-0.01), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), (screenY/1080)*4, (screenY/1080)*4, "beckett")
	
	local box_height = screenY*s_offsets[4] * 0.9
	local textSize = box_height / 75 / 13
	local offset = box_height / 33

	-- Draw records
	for i = 1, 32 do		
		dxDrawText((i+statsPage*32).. ".", screenX*st_offsets[1], screenY*0.27 + offset, screenX*st_offsets[1]*1.105, screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic", "right")
		dxDrawText(tostring(displayedRecords[i+statsPage*32]["vehiclename"]), screenX*(st_offsets[1]*1.12), screenY*0.27 + offset, screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic")
		dxDrawText(tostring(displayedRecords[i+statsPage*32]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.8), screenY*0.27 + offset, screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic")
		dxDrawText(convertToRaceTime(displayedRecords[i+statsPage*32]["time"]), screenX*(st_offsets[1]+0.04), screenY*0.27 + offset, screenX*(st_offsets[1]+st_offsets[3]), screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic", "right")
		
		offset = offset + box_height / 33
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
	for i, recordsData in pairs(recordsStats) do 
		displayedRecords[i]["playername"] = recordsData["playername"]
		displayedRecords[i]["vehiclename"] = recordsData["vehiclename"]
		displayedRecords[i]["time"] = recordsData["score"]
	end
	
	if #recordsStats < 128 then
		for i = #recordsStats + 1, 128 do
			displayedRecords[i]["playername"] = "-- EMPTY --"
			displayedRecords[i]["vehiclename"] = "-- NIL --"
			displayedRecords[i]["time"] = 0
		end
	end
	
	statsInited = true
end )

-- Event used to manage player inputs when stats displayed
addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end
	
	if press and displayStats then
		if button == "arrow_r" then
			if statsPage == 3 then statsPage = 0
			else statsPage = statsPage + 1 end
		elseif button == "arrow_l" then
			if statsPage == 0 then statsPage = 3
			else statsPage = statsPage - 1 end
		end
	end
end )