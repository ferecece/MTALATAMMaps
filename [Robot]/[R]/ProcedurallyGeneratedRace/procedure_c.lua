local playerState = "not ready"

-- Screen stuff
local screenX, screenY = guiGetScreenSize()
local screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenY/1200} -- X-left, Y1, Y2, textsize
 -- 4:3 and others screens
else 
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenY/1200} -- X-left, Y1, Y2, textsize
end

-- Race Data
local environment = {}
local vehicle = {}
local race = {}
local clientMarkers = {}
for i = 0, 25 do
	clientMarkers[i] = {}
	clientMarkers[i][1] = 5000
	clientMarkers[i][2] = 5000
	clientMarkers[i][3] = 5000
end
local vehicleRadius = {3, 3.2, 3.2, 5.2, 3.2, 3.3, 6.6, 4.8, 5.9, 4.3, 2.8, 3.1, 3.9, 3.3, 3.9, 3, 4.4, 12, 3.3, 3.4, 3.3, 3.5, 3.1, 3.6, 2.4, 9.800000000000001, 3.2, 4.4, 3.7, 2.9, 6.5, 6.6, 5.1, 5.5, 2.6, 7.3, 3.1, 6.3, 3.3, 3, 3.2, 2, 3.7, 10.3, 3.8, 3.2, 6.7, 7.5, 1.3, 5.2, 7.1, 3, 5.9, 6, 8.300000000000001, 5.3, 5.1, 2, 3.4, 3.2, 8.9, 1.4, 1.3, 1.4, 1.2, 0.9, 3.4, 3.5, 1.3, 7.5, 3.2, 1.4, 4.5, 2.6, 3.3, 3.2, 8.1, 3.3, 3.2, 3.3, 2.9, 1.1, 3.3, 3.4, 9.9, 2.3, 4.6, 7.7, 6.5, 3.3, 3.9, 3.4, 3.4, 6.7, 3.5, 3.2, 2.7, 7.7, 4.1, 3.9, 2.9, 0.9, 3.3, 3.4, 3.3, 3.3, 2.9, 3.6, 4.5, 1.2, 1.1, 15, 6.5, 6.5, 5.5, 5.6, 3.4, 3.5, 3.3, 14.1, 8.6, 1.4, 1.4, 1.4, 5, 3.9, 2.9, 3.2, 3.2, 3.1, 2.6, 2.3, 7.3, 3, 3.3, 3.1, 3.5, 11, 8.199999999999999, 2.6, 3.4, 2.7, 3.5, 3.2, 6.7, 2.7, 3.3, 3.2, 12.7, 3.1, 3.3, 3.7, 4, 18.9, 3.5, 2.8, 3.8, 3.8, 2.9, 3, 3, 3.2, 2.9, 9.6, 0.9, 2.7, 3.5, 3.7, 2.7, 9.4, 10.6, 1.6, 1.7, 4.1, 2.4, 3.2, 3.4, 45.7, 6.3, 3.5, 3.3, 1.4, 3.9, 2.5, 8.199999999999999, 3.5, 1.5, 3.2, 5.5, 2.9, 9.6, 7.3, 36.4, 9.300000000000001, 0.5, 6.3, 3.2, 3.3, 3.2, 3.5, 3.3, 4.5, 3.1, 3.3, 3.4, 3.2, 2.4, 2.4, 4, 4.1, 1.5, 2.1 }

-- Race Elements
local marker = nil
local markerNext = nil
local markerBlip = nil
local markerNextBlip = nil
local markerCol = nil
local specCheckpoints = {}

-- States 
local spawnCheckCompleted = false
local firstSpawned = false
local dataReceived = false

-- Skips
local skipMarker = 30

-- Map
local mapTexture = dxCreateTexture("map.jpg")

-- Skin names
skinModelNames = { [0] = "CJ", "truth", "maccer", "cdeput", "sfpdm1", "bb", "wfycrp", "male01", "wmycd2", "bfori", "bfost", "vbfycrp", "bfyri", "bfyst", "bmori", "bmost", "bmyap", "bmybu", "bmybe", "bmydj", "bmyri", "bmycr", "bmyst", "wmybmx", "wbdyg1", "wbdyg2", "wmybp", "wmycon", "bmydrug", "wmydrug", "hmydrug", "dwfolc", "dwmolc1", "dwmolc2", "dwmylc1", "hmogar", "wmygol1", "wmygol2", "hfori", "hfost", "hfyri", "hfyst", "suzie", "hmori", "hmost", "hmybe", "hmyri", "hmycr", "hmyst", "omokung", "wmymech", "bmymoun", "wmymoun", "ofori", "ofost", "ofyri", "ofyst", "omori", "omost", "omyri", "omyst", "wmyplt", "wmopj", "bfypro", "hfypro", "vwmyap", "bmypol1", "bmypol2", "wmoprea", "sbfyst", "wmosci", "wmysgrd", "swmyhp1", "swmyhp2", "CJ", "swfopro", "wfystew", "swmotr1", "wmotr1", "bmotr1", "vbmybox", "vwmybox", "vhmyelv", "vbmyelv", "vimyelv", "vwfypro", "vhfyst", "vwfyst1", "wfori", "wfost", "wfyjg", "wfyri", "wfyro", "wfyst", "wmori", "wmost", "wmyjg", "wmylg", "wmyri", "wmyro", "wmycr", "wmyst", "ballas1", "ballas2", "ballas3", "fam1", "fam2", "fam3", "lsv1", "lsv2", "lsv3", "maffa", "maffb", "mafboss", "vla1", "vla2", "vla3", "triada", "triadb", "lvpdm1", "triboss", "dnb1", "dnb2", "dnb3", "vmaff1", "vmaff2", "vmaff3", "vmaff4", "dnmylc", "dnfolc1", "dnfolc2", "dnfylc", "dnmolc1", "dnmolc2", "sbmotr2", "swmotr2", "sbmytr3", "swmotr3", "wfybe", "bfybe", "hfybe", "sofybu", "sbmyst", "sbmycr", "bmycg", "wfycrk", "hmycm", "wmybu", "bfybu", "CJ", "wfybu", "dwfylc1", "wfypro", "wmyconb", "wmybe", "wmypizz", "bmobar", "cwfyhb", "cwmofr", "cwmohb1", "cwmohb2", "cwmyfr", "cwmyhb1", "bmyboun", "wmyboun", "wmomib", "bmymib", "wmybell", "bmochil", "sofyri", "somyst", "vwmybjd", "vwfycrp", "sfr1", "sfr2", "sfr3", "bmybar", "wmybar", "wfysex", "wmyammo", "bmytatt", "vwmycr", "vbmocd", "vbmycr", "vhmycr", "sbmyri", "somyri", "somybu", "swmyst", "wmyva", "copgrl3", "gungrl3", "mecgrl3", "nurgrl3", "crogrl3", "gangrl3", "cwfofr", "cwfohb", "cwfyfr1", "cwfyfr2", "cwmyhb2", "dwfylc2", "dwmylc2", "omykara", "wmykara", "wfyburg", "vwmycd", "vhfypro", "CJ", "omonood", "omoboat", "wfyclot", "vwmotr1", "vwmotr2", "vwfywai", "sbfori", "swfyri", "wmyclot", "sbfost", "sbfyri", "sbmocd", "sbmori", "sbmost", "shmycr", "sofori", "sofost", "sofyst", "somobu", "somori", "somost", "swmotr5", "swfori", "swfost", "swfyst", "swmocd", "swmori", "swmost", "shfypro", "sbfypro", "swmotr4", "swmyri", "smyst", "smyst2", "sfypro", "vbfyst2", "vbfypro", "vhfyst3", "bikera", "bikerb", "bmypimp", "swmycr", "wfylg", "wmyva2", "bmosec", "bikdrug", "wmych", "sbfystr", "swfystr", "heck1", "heck2", "bmycon", "wmycd1", "bmocd", "vwfywa2", "wmoice", "tenpen", "pulaski", "hern", "dwayne", "smoke", "sweet", "ryder", "forelli", "mediatr", "laemt1", "lvemt1", "sfemt1", "lafd1", "lvfd1", "sffd1", "lapd1", "sfpd1", "lvpd1", "csher", "lapdm1", "swat", "fbi", "army", "dsher", "somyap", "rose", "paul", "cesar", "ogloc", "wuzimu", "torino", "jizzy", "maddogg", "cat", "claude", "ryder2", "ryder3", "emmet", "andre", "kendl", "jethro", "zero", "tbone", "sindaco", "janitor", "bbthin", "smokev", "psycho" }

-- Records
displayStats = false
statsInited = false
statsAlpha = 0
displayedRecords = {}
for i = 1, 11 do
	displayedRecords[i] = {}
	displayedRecords[i]["playername"] = ""
	displayedRecords[i]["time"] = 0
end
helpText = "F5"

-- Function checks spectate mode
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 1000 then return true	
	else return false end
end

-- Recreate markers when player's gone back from spectate mode or died
function resetCheckpoints()
	if dataReceived and firstSpawned then
		exports.race:setCheckpointText((getElementData(localPlayer, "race.checkpoint") - 1) .. ' / ' .. race["maxCP"])
		
		-- Learning stuff
		setTimer(learnNodes, math.random(1000, 5000), 1)
		
		-- Delete old race elements
		if isElement(marker) then destroyElement(marker) end
		if isElement(markerNext) then destroyElement(markerNext) end
		if isElement(markerBlip) then destroyElement(markerBlip) end
		if isElement(markerNextBlip) then destroyElement(markerNextBlip) end
		if isElement(markerCol) then destroyElement(markerCol) end
		
		local offset = 0 -- offset for checkpoints from the ground
		if race["markerType"] == "ring" then offset = 3 
		elseif race["markerType"] == "corona" then offset = 1 end
		
		-- Request vehicle model
		triggerServerEvent("resetVehicleModel", getLocalPlayer())
		
		-- Get current race checkpoint
		local c = getElementData(localPlayer, "race.checkpoint")
		
		if c == 1 then 
			if vehicle["type"] == "Plane" then
				if isTimer(planePushTimer) then killTimer(planePushTimer) end
				planePushTimer = setTimer(function() 
					if not isElementFrozen(getPedOccupiedVehicle(localPlayer)) then
						local matrix = getElementMatrix(getPedOccupiedVehicle(localPlayer))
						local x, y, z = matrix[2][1]*5, matrix[2][2]*5, matrix[2][3]
						setElementVelocity(getPedOccupiedVehicle(localPlayer), x, y, z)
						killTimer(planePushTimer)
					end
				end, 50, 0)
			elseif vehicle["type"] == "Train" then
				setTrainSpeed(getPedOccupiedVehicle(localPlayer), 0)
				setTrainDerailed(getPedOccupiedVehicle(localPlayer), false)
			end
		end
		
		-- Finish check
		if c > race["maxCP"] then
			-- Trigger the rest of checkpoints for triggering the actual "race" finish
			for i = getElementData(localPlayer, "race.checkpoint"), 26 do
				local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
				if (#colshapes == 0) then break end
				triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
			end
		elseif c == skipMarker and c <= race["maxCP"] then
			local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
			if #colshapes ~= 0 then 
				triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
				setElementData(localPlayer, "skipped", 1)
				resetCheckpoints()
			end
		else
			-- Create new checkpoint
			marker = createMarker(clientMarkers[c][1], clientMarkers[c][2], clientMarkers[c][3] + offset, race["markerType"], race["markerSize"], race["cpColorR"], race["cpColorG"], race["cpColorB"], 200)
			
			-- Blip for new checkpoint
			local blipIcon = 0
			if c == race["maxCP"] then
				if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then blipIcon = 5
				elseif vehicle["type"] == "Boat" then blipIcon = 9
				else blipIcon = 53 end
			end 
			markerBlip = createBlip(clientMarkers[c][1], clientMarkers[c][2], clientMarkers[c][3], blipIcon, 2, race["cpColorR"], race["cpColorG"], race["cpColorB"])
			
			-- Create colshape
			if race["markerType"] == "ring" or race["markerType"] == "corona" or race["markerType"] == "arrow" then
				markerCol = createColSphere(clientMarkers[c][1], clientMarkers[c][2], clientMarkers[c][3], race["markerSize"] + 5)
			elseif race["markerType"] == "checkpoint" then
				markerCol = createColCircle(clientMarkers[c][1], clientMarkers[c][2], race["markerSize"] + 10)
			end
			
			-- Create "next" checkpoint if current one not last
			if c ~= race["maxCP"] then
				markerNext = createMarker(clientMarkers[c+1][1], clientMarkers[c+1][2], clientMarkers[c+1][3] + offset, race["markerType"], race["markerSize"], race["cpColorR"], race["cpColorG"], race["cpColorB"], 128)
				
				local blipIcon = 0
				if c == race["maxCP"] - 1 then
					if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then blipIcon = 5
					elseif vehicle["type"] == "Boat" then blipIcon = 9
					else blipIcon = 53 end
				end 
				markerNextBlip = createBlip(clientMarkers[c+1][1], clientMarkers[c+1][2], clientMarkers[c+1][3], blipIcon, 1, race["cpColorR"], race["cpColorG"], race["cpColorB"])
				
				setMarkerIcon(marker, "arrow")
				setMarkerTarget(marker, clientMarkers[c+1][1], clientMarkers[c+1][2], clientMarkers[c+1][3])
			else setMarkerIcon(marker, "finish") end
			
			-- Set target for the "next" checkpoint for rings
			if race["markerType"] == "ring" and c ~= race["maxCP"] then
				setMarkerTarget(markerNext, clientMarkers[c+2][1], clientMarkers[c+2][2], clientMarkers[c+2][3])
			end
			
			-- Respawn check on first checkpoint
			if getElementData(localPlayer, "race.checkpoint") == 1 then
				setElementPosition(getPedOccupiedVehicle(localPlayer), vehicle["spawnX"], vehicle["spawnY"], vehicle["spawnZ"])
				setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, vehicle["spawnRot"])
			end
		end
	end
end

-- Function that enables stats and requests data from the database
-- Called from key bind and finish of the race
function showStats()
	-- Request data for stats
	triggerServerEvent("getStats", getLocalPlayer())
	
	-- Show stats
	displayStats = not displayStats
end

-- Function that draws stats on the screen
function drawStats()
	if not statsInited then return end
	
	if vehicle["trailer"] == nil then
		dxDrawText(vehicle["name"].. " Records", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
		dxDrawText(vehicle["name"].. " Records", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
	else
		if vehicle["model"] == 525 then
			dxDrawText(vehicle["trailerName"].. " (trailer) Records", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
			dxDrawText(vehicle["trailerName"].. " (trailer) Records", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		else
			dxDrawText(vehicle["trailerName"].. " Records", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
			dxDrawText(vehicle["trailerName"].. " Records", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		end
	end
	
	local box_height = (screenY*s_offsets[4]) * 0.9
	local textSize = box_height / 75 / (12 / 2)
	local offset = box_height / 12

	-- Draw stats
	for i = 1, 11 do
		local color
		if displayedRecords[i]["playername"]:gsub("#%x%x%x%x%x%x", "") == getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") then
			color = tocolor(0, 200, 200, statsAlpha)
		else
			color = tocolor(175, 202, 230, statsAlpha)
		end
		
		if i == 11 and displayedRecords[11]["id"] ~= nil then
			dxDrawText(displayedRecords[11]["id"].. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
		else
			dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
		end
		
		dxDrawText(tostring(displayedRecords[i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1], screenY, color, textSize, textSize, "bankgothic")
		dxDrawText(convertToRaceTime(displayedRecords[i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07) + offset, screenX*(st_offsets[1]+0.45), screenY, color, textSize, textSize, "bankgothic", "right")
		offset = offset + (box_height / 12)
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

addEvent("setSkip", true)
addEventHandler("setSkip", getRootElement(), function(markerID)
	if getElementData(localPlayer, "race.checkpoint") == markerID then
		local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
		if #colshapes ~= 0 then
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
		end
	end
	
	resetCheckpoints()
	setElementData(localPlayer, "skipped", 1)
	skipMarker = markerID
end )

function learnNodes()
	if isLocalPlayerSpectating() or not getPedOccupiedVehicle(localPlayer) then return end
	if getVehicleType(getPedOccupiedVehicle(localPlayer)) == "Boat" then return end
	local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	
	local scannedNodesList = {}
	local scanX, scanY
	for i = 1, 200 do
			repeat scanX = math.random(x-200, x+200)
			until scanX > x+50 or scanX < x-50
			
			repeat scanY = math.random(y-200, y+200)	
			until scanY > y+50 or scanY < y-50
			
			hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(scanX, scanY, z + 100, scanX, scanY, -10, true, false, false, true, false, false, false, false, nil, true, false, true)
		
		if hit and hitZ > 0 and (material == 1 or material == 5 or material == 7 or material == 34 or material == 144 or material == 2 or material == 3 or material == 85 or material == 160 or material == 30 or material == 25 or material == 145 or material == 86) then
			local savePoint = true
			for i = 1, #scannedNodesList do
				if getDistanceBetweenPoints2D(scanX, scanY, scannedNodesList[i][1], scannedNodesList[i][2]) < 50 then
					savePoint = false
					break
				end
			end
			
			if savePoint then 
				table.insert(scannedNodesList, {scanX, scanY, hitZ, material})
			end 
		end
	end
	
	if #scannedNodesList > 0 then triggerServerEvent("saveLearnedNodes", getLocalPlayer(), scannedNodesList) end
end

-- Onscreen stuff and seed generation
addEventHandler("onClientRender", getRootElement(), function()
	-- Player State Checks
	local newPlayerState = "not ready"
	
	if getElementData(localPlayer, "state") ~= nil and getElementData(localPlayer, "state") ~= false then
		newPlayerState = getElementData(localPlayer, "state")
		if isLocalPlayerSpectating() then newPlayerState = "spectating" end
	end
	
	if newPlayerState ~= playerState then -- Player race state changed
		--outputChatBox("new: " ..newPlayerState.. " old: " ..playerState)
		if playerState == "spectating" and newPlayerState == "alive" then
			for i = 1, #specCheckpoints do
				if isElement(specCheckpoints[i]) then destroyElement(specCheckpoints[i]) end
			end
			resetCheckpoints() 
		end
		
		if newPlayerState == "spectating" and dataReceived then
			for i = 1, race["maxCP"] do
				specCheckpoints[i] = createMarker(clientMarkers[i][1], clientMarkers[i][2], clientMarkers[i][3], race["markerType"], race["markerSize"], race["cpColorR"], race["cpColorG"], race["cpColorB"], 200)
			end
		end
		
		playerState = newPlayerState
		if isLocalPlayerSpectating() then playerState = "spectating" end
	end
	
	if not dataReceived and not firstSpawned and getPedOccupiedVehicle(localPlayer) and not checkFirstPosition then
		setElementData(localPlayer, "gotdata", 0)
		
		if not seed then 
			seed = true
			
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
			
			setElementData(localPlayer, "skipped", 0)
			setTimer(function() outputChatBox("#E7D9B0You can #00FF00skip #E7D9B0unattainable checkpoint by command #00FF00/voteskip", 0, 0, 0, true) end, 90000, 1)
		end
	end
	
	if dataReceived then
		if getKeyState("tab") then
			setPlayerHudComponentVisible("radar", false)
			
			-- Map
			local centerX, centerY = screenX/2, screenY/2
			
			if screenAspect < 1.7 then centerX = screenX/2 + screenX*0.12 end
			
			-- Bounds detection
			local maxX, maxY = -6000, -6000
			local minX, minY = 6000, 6000
			
			for i = 0, race["maxCP"] do
				maxX = math.max(clientMarkers[i][1], maxX)
				maxY = math.max(clientMarkers[i][2], maxY)
				
				minX = math.min(clientMarkers[i][1], minX)
				minY = math.min(clientMarkers[i][2], minY)
			end
			
			maxX = math.min(maxX + 50, 3000)
			minX = math.max(minX - 50, -3000)
			maxY = math.min(maxY + 50, 3000)
			minY = math.max(minY - 50, -3000)
	
			local u = 1024 + minX * (1024/3000)
			local v = 1024 - maxY * (1024/3000)
			
			local usize = (1024 + maxX * (1024/3000)) - u
			local vsize = (1024 - minY * (1024/3000)) - v
			
			local image_width = (usize / vsize) * (screenY*0.5 - screenY*0.25)
			local image_height = (screenY*0.5 - screenY*0.25)
			
			local box_width = (screenX*0.98 - screenX*0.7)
			if centerX/2 + image_width > screenX*0.05 + (screenX*0.98 - screenX*0.7) then
				box_width = (centerX/2 + image_width) - (screenX*0.05 + (screenX*0.98 - screenX*0.7)) + box_width + (screenX*0.06 - screenX*0.05)
			end
			
			dxDrawRectangle(screenX*0.05, screenY*0.6, box_width, (screenY*0.5 - screenY*0.2), tocolor(0, 0, 0, 200, 50))
			dxDrawImageSection(centerX/2, screenY*0.62, image_width, image_height, u, v, usize, vsize, mapTexture)
			
			-- Player pos
			local px, py, pz = getElementPosition(getPedOccupiedVehicle(localPlayer))
			px = math.min(px, maxX)
			px = math.max(px, minX)
			py = math.min(py, maxY)
			py = math.max(py, minY)
					
			local x = (px - minX) / ((maxX - minX) / image_width)
			local y = (py - maxY) / ((minY - maxY) / image_height)
			dxDrawCircle(centerX/2 + x, (screenY*0.62) + y, 5, 0, 360, tocolor(0, 255, 0, 255))
			
			-- Draw CPs
			local oldX, oldY
			for i = getElementData(localPlayer, "race.checkpoint"), race["maxCP"] do
				local x = (clientMarkers[i][1] - minX) / ((maxX - minX) / image_width)
				local y = (clientMarkers[i][2] - maxY) / ((minY - maxY) / image_height)
				
				if oldX == nil and oldY == nil then
					local u, w, v = getElementPosition(localPlayer)
					
					u = math.min(u, maxX)
					u = math.max(u, minX)
					w = math.min(w, maxY)
					w = math.max(w, minY)
					
					oldX = (u - minX) / ((maxX - minX) / image_width)
					oldY = (w - maxY) / ((minY - maxY) / image_height)
				end
				
				if oldX ~= nil and oldY ~= nil then
					dxDrawLine(centerX/2 + oldX, (screenY*0.62) + oldY, centerX/2 + x, (screenY*0.62) + y, tocolor(0, 255, 0, 255))
				end
				
				oldX = x
				oldY = y
				
				dxDrawCircle(centerX/2 + x, (screenY*0.62) + y, 4, 0, 360, tocolor(race["cpColorR"], race["cpColorG"], race["cpColorB"], 255))
			end
			
			local data = {
				"Model: " ..vehicle["name"].. " (" ..vehicle["model"].. ")",
				"Type: " ..vehicle["type"],
				"Moon size: " ..environment["Moon"],
				"Checkpoint type: " ..race["markerType"],
				"Generated in: " ..race["timems"].. " ms (" ..race["bends"].. ")",
				"Generated by: " ..race["generator"]:gsub("#%x%x%x%x%x%x", ""),
				"Using nodes: " ..race["usednodes"],
				"Checkpoints: " ..race["maxCP"].. " (" ..race["raceDistance"].. " m.)",
				"Ped: " ..race["pedID"].. " (" ..skinModelNames[race["pedID"]].. ")"
			}
			
			if vehicle["type"] == "Automobile" or vehicle["type"] == "Monster Truck" or vehicle["type"] == "Quad" then
				local hydraulics = "false"
				if vehicle["hydraulics"] == 1 then hydraulics = "true" end
			
				table.insert(data, "Paintjob: " ..vehicle["paintjob"])
				table.insert(data, "Hydraulics: " ..hydraulics)
				
				if vehicle["nitros"] == 3 then table.insert(data, "Nitro: true") 
				else table.insert(data, "Nitro: false") end
			end
			
			if vehicle["type"] == "Train" then
				if vehicle["trainDerailable"] == 1 then table.insert(data, "Derailable: true")
				else table.insert(data, "Derailable: false") end
				
				if vehicle["trainDirection"] == 1 then table.insert(data, "Clockwise: false")
				else table.insert(data, "Clockwise: true") end
				
				if vehicle["trainCarts"] then table.insert(data, "Carts: " ..#vehicle["trainCarts"]) end
			end
			
			if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then
				table.insert(data, "Clip distance: " ..environment["clipDistance"])
			end
			
			if vehicle["type"] == "Boat" then
				table.insert(data, "Wave height: " ..environment["waveHeight"])
			end
			
			if vehicle["trailer"] ~= nil and vehicle["type"] ~= "Train" then
				table.insert(data, "Trailer: " ..tostring(vehicle["trailerName"]).. " (" ..tostring(vehicle["trailer"]).. ")")
				if vehicle["nitros"] == 3 then table.insert(data, "Nitro: true") 
				else table.insert(data, "Nitro: false") end
			end
			
			local box_height = (screenY*0.5 - screenY*0.2) * 0.9
			local textSize = box_height / 75 / (6)
			local offset = box_height / 12

			-- Draw records
			for i = 1, #data do		
				dxDrawText(data[i], screenX*0.06, screenY*0.60 + offset, screenX, screenY, tocolor(175, 202, 230, 200), textSize, textSize, "bankgothic")
				offset = offset + (box_height / 12)
			end
		else setPlayerHudComponentVisible("radar", true) end
	end
	
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
	if getElementData(localPlayer, "gotdata") == 1 then
		if statsAlpha > 200 then
			dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, 200, 50))
		else
			dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, statsAlpha, 50))
		end
		drawStats()
	end
	
	if isLocalPlayerSpectating() then
		if isElement(marker) then destroyElement(marker) end
		if isElement(markerNext) then destroyElement(markerNext) end
		if isElement(markerBlip) then destroyElement(markerBlip) end
		if isElement(markerNextBlip) then destroyElement(markerNextBlip) end
		if isElement(markerCol) then destroyElement(markerCol) end
		
		return 
	end
	
	if getPedOccupiedVehicle(localPlayer) then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local k, l = getVehicleTurretPosition(getPedOccupiedVehicle(localPlayer))
		
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 432 then
			setVehicleTurretPosition(getPedOccupiedVehicle(localPlayer), math.rad((getPedCameraRotation(localPlayer)*(-1) - z)-180), l)
		elseif getElementModel(getPedOccupiedVehicle(localPlayer)) == 524 then
			setVehicleAdjustableProperty(getPedOccupiedVehicle(localPlayer), 20000000000)
		else
			setVehicleTurretPosition(getPedOccupiedVehicle(localPlayer), math.rad(getPedCameraRotation(localPlayer)*(-1) - z), l)
		end
	end
end )

-- Event used for checking if vehicle spawned inside building 
-- Did not worked that well but who cares anyway? 
addEventHandler("onClientVehicleCollision", root, function(collider, damageImpulseMag, bodyPart, x, y, z, nx, ny, nz, hitElementForce, model)
	if not getPedOccupiedVehicle(localPlayer) or not firstSpawned or spawnCheckCompleted then return end 
	
	if source == getPedOccupiedVehicle(localPlayer) then
		if collider == nil and hitElementForce == 0 and damageImpulseMag < 2 then
			local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
			setElementPosition(getPedOccupiedVehicle(localPlayer), x, y, -200)
			fixVehicle(getPedOccupiedVehicle(localPlayer))
			spawnCheckCompleted = true
		end
	end
end )

-- No double B glitch for you 
addEventHandler("onClientVehicleEnter", getRootElement(), function(ped, seat)
	if ped == localPlayer then resetCheckpoints() end
end )

-- No damage from explosions 
addEventHandler("onClientExplosion", root, function(x, y, z, theType)
	if theType == 2 or theType == 3 or theType == 10 and source ~= localPlayer then
		createExplosion(x, y, z, 1)
		cancelEvent()
	end
end )

-- No damage from weapons 
addEventHandler("onClientVehicleDamage", root, function(attacker, weapon)
	if source == getPedOccupiedVehicle(localPlayer) and (weapon == 37 or weapon == 31 or weapon == 38 or weapon == 28) then cancelEvent() end
end )

-- Event called from the server for client to process current race data
addEvent("recieveMarkers", true)
addEventHandler("recieveMarkers", localPlayer, function(data)
	if getElementData(localPlayer, "gotdata") == 0 then
		setElementData(localPlayer, "gotdata", 1)
		
		clientMarkers = data[1]
		vehicle = data[2]
		race = data[3]
		environment = data[4]
		dataReceived = true
		
		setWorldProperty("AmbientColor", environment["AmbientColor"][1], environment["AmbientColor"][2], environment["AmbientColor"][3])
		setWorldProperty("Illumination", environment["Illumination"])
		
		setElementPosition(getPedOccupiedVehicle(localPlayer), vehicle["spawnX"], vehicle["spawnY"], vehicle["spawnZ"])
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, vehicle["spawnRot"])
		
		firstSpawned = true
		
		resetCheckpoints()
		
		-- Extra jumps for Area 69
		if vehicle["type"] ~= "Plane" and vehicle["type"] ~= "Helicopter" and vehicleRadius[vehicle["model"]-399] > 4.6 then
			createObject(3080, 139.2, 1950.7, 19.7, 0, 0, -180)
			createObject(3080, 135.5, 1950.7, 19.7, 0, 0, 180)
			createObject(3080, 131.39999, 1950.7, 19.7, 0, 0, 179.995)
			createObject(3080, 131.39999, 1945, 23, 15, 0, 179.995)
			createObject(3080, 135.5, 1945, 23, 14.996, 0, 179.995)
			createObject(3080, 183.39999, 1929.2, 18.1, 14.996, 0, -0.005)
			createObject(3080, 139.2002, 1945, 23, 14.996, 0, 179.995)
			createObject(3080, 179.39999, 1929.2, 18.1, 14.991, 0, -0.011)
			createObject(3080, 175.8, 1929.2, 18.1, 14.991, 0, -0.011)
			createObject(3080, 175.8, 1936, 23.2, 14.996, 0, -0.005)
			createObject(3080, 179.39999, 1936, 23.2, 14.991, 0, -0.011)
			createObject(3080, 183.39999, 1936, 23.2, 14.991, 0, -0.011)
		end
		
		setTimer(function() spawnCheckCompleted = true end, 5000, 1)
		
		-- Messages
		if vehicle["trailer"] ~= nil and vehicle["type"] ~= "Train" then
			if vehicle["model"] == 525 then outputChatBox("#E7D9B0Today we are playing #00FF00" ..race["generator"].. "#E7D9B0's #00FF00car delivery #E7D9B0race with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0with #00FF00" ..vehicle["trailerName"].. " #E7D9B0(#00FF00" ..race["raceDistance"].. " #E7D9B0m.)", 0, 0, 0, true)
			else outputChatBox("#E7D9B0Today we are playing #00FF00" ..race["generator"].. "#E7D9B0's #00FF00trailer delivery #E7D9B0race with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0with #00FF00" ..vehicle["trailerName"].. " #E7D9B0(#00FF00" ..race["raceDistance"].. " #E7D9B0m.)", 0, 0, 0, true) end
		else
			if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then outputChatBox("#E7D9B0Today we are playing #00FF00" ..race["generator"].. "#E7D9B0's #00FF00air race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..race["raceDistance"].. " #E7D9B0m.)", 0, 0, 0, true)
			elseif vehicle["type"] == "Boat" then outputChatBox("#E7D9B0Today we are playing #00FF00" ..race["generator"].. "#E7D9B0's #00FF00boat race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..race["raceDistance"].. " #E7D9B0m.)", 0, 0, 0, true)
			else outputChatBox("#E7D9B0Today we are playing #00FF00" ..race["generator"].. "#E7D9B0's #00FF00race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..race["raceDistance"].. " #E7D9B0m.)", 0, 0, 0, true) end
		end

		if vehicle["trailer"] == nil then outputChatBox("#E7D9B0You can get records for #00FF00" ..vehicle["name"].. " #E7D9B0by pressing #00FF00" ..helpText, 0, 0, 0, true)
		else outputChatBox("#E7D9B0You can get records for #00FF00" ..vehicle["trailerName"].. " #E7D9B0by pressing #00FF00" ..helpText, 0, 0, 0, true) end
		
		outputChatBox("#E7D9B0Use the #00FF00/votesave #E7D9B0command to #00FF00save #E7D9B0good races. You can play them on the #00FF00'Player for Generated Races' #E7D9B0map. ", 0, 0, 0, true)
	end
end )

-- Event called from the server script for receiving stats data
addEvent("receiveStats", true)
addEventHandler("receiveStats", getRootElement(), function(recordsStats)	
	-- Handle Vehicle Records
	for i, recordsData in pairs(recordsStats) do 
		displayedRecords[i]["playername"] = recordsData["playername"]
		displayedRecords[i]["time"] = recordsData["score"]
		
		if i == 11 and recordsData["id"] ~= nil then
			displayedRecords[11]["id"] = recordsData["id"]
		end
	end
	
	if #recordsStats < 11 then
		for i = #recordsStats + 1, 11 do
			displayedRecords[i]["playername"] = "-- EMPTY --"
			displayedRecords[i]["time"] = 0
		end
	end
	
	statsInited = true
end )

-- Checkpoints handler
addEventHandler("onClientColShapeHit", root, function(element, dim)
	if element == localPlayer and not isLocalPlayerSpectating() and source == markerCol then
		-- Increment player's race score
		local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
		if #colshapes ~= 0 then  
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
		end
		
		resetCheckpoints()
	end
end )