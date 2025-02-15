playerState = "not ready"
test = 0

-- Skin names
skinModelNames = { [0] = "CJ", "truth", "maccer", "cdeput", "sfpdm1", "bb", "wfycrp", "male01", "wmycd2", "bfori", "bfost", "vbfycrp", "bfyri", "bfyst", "bmori", "bmost", "bmyap", "bmybu", "bmybe", "bmydj", "bmyri", "bmycr", "bmyst", "wmybmx", "wbdyg1", "wbdyg2", "wmybp", "wmycon", "bmydrug", "wmydrug", "hmydrug", "dwfolc", "dwmolc1", "dwmolc2", "dwmylc1", "hmogar", "wmygol1", "wmygol2", "hfori", "hfost", "hfyri", "hfyst", "suzie", "hmori", "hmost", "hmybe", "hmyri", "hmycr", "hmyst", "omokung", "wmymech", "bmymoun", "wmymoun", "ofori", "ofost", "ofyri", "ofyst", "omori", "omost", "omyri", "omyst", "wmyplt", "wmopj", "bfypro", "hfypro", "vwmyap", "bmypol1", "bmypol2", "wmoprea", "sbfyst", "wmosci", "wmysgrd", "swmyhp1", "swmyhp2", "CJ", "swfopro", "wfystew", "swmotr1", "wmotr1", "bmotr1", "vbmybox", "vwmybox", "vhmyelv", "vbmyelv", "vimyelv", "vwfypro", "vhfyst", "vwfyst1", "wfori", "wfost", "wfyjg", "wfyri", "wfyro", "wfyst", "wmori", "wmost", "wmyjg", "wmylg", "wmyri", "wmyro", "wmycr", "wmyst", "ballas1", "ballas2", "ballas3", "fam1", "fam2", "fam3", "lsv1", "lsv2", "lsv3", "maffa", "maffb", "mafboss", "vla1", "vla2", "vla3", "triada", "triadb", "lvpdm1", "triboss", "dnb1", "dnb2", "dnb3", "vmaff1", "vmaff2", "vmaff3", "vmaff4", "dnmylc", "dnfolc1", "dnfolc2", "dnfylc", "dnmolc1", "dnmolc2", "sbmotr2", "swmotr2", "sbmytr3", "swmotr3", "wfybe", "bfybe", "hfybe", "sofybu", "sbmyst", "sbmycr", "bmycg", "wfycrk", "hmycm", "wmybu", "bfybu", "CJ", "wfybu", "dwfylc1", "wfypro", "wmyconb", "wmybe", "wmypizz", "bmobar", "cwfyhb", "cwmofr", "cwmohb1", "cwmohb2", "cwmyfr", "cwmyhb1", "bmyboun", "wmyboun", "wmomib", "bmymib", "wmybell", "bmochil", "sofyri", "somyst", "vwmybjd", "vwfycrp", "sfr1", "sfr2", "sfr3", "bmybar", "wmybar", "wfysex", "wmyammo", "bmytatt", "vwmycr", "vbmocd", "vbmycr", "vhmycr", "sbmyri", "somyri", "somybu", "swmyst", "wmyva", "copgrl3", "gungrl3", "mecgrl3", "nurgrl3", "crogrl3", "gangrl3", "cwfofr", "cwfohb", "cwfyfr1", "cwfyfr2", "cwmyhb2", "dwfylc2", "dwmylc2", "omykara", "wmykara", "wfyburg", "vwmycd", "vhfypro", "CJ", "omonood", "omoboat", "wfyclot", "vwmotr1", "vwmotr2", "vwfywai", "sbfori", "swfyri", "wmyclot", "sbfost", "sbfyri", "sbmocd", "sbmori", "sbmost", "shmycr", "sofori", "sofost", "sofyst", "somobu", "somori", "somost", "swmotr5", "swfori", "swfost", "swfyst", "swmocd", "swmori", "swmost", "shfypro", "sbfypro", "swmotr4", "swmyri", "smyst", "smyst2", "sfypro", "vbfyst2", "vbfypro", "vhfyst3", "bikera", "bikerb", "bmypimp", "swmycr", "wfylg", "wmyva2", "bmosec", "bikdrug", "wmych", "sbfystr", "swfystr", "heck1", "heck2", "bmycon", "wmycd1", "bmocd", "vwfywa2", "wmoice", "tenpen", "pulaski", "hern", "dwayne", "smoke", "sweet", "ryder", "forelli", "mediatr", "laemt1", "lvemt1", "sfemt1", "lafd1", "lvfd1", "sffd1", "lapd1", "sfpd1", "lvpd1", "csher", "lapdm1", "swat", "fbi", "army", "dsher", "somyap", "rose", "paul", "cesar", "ogloc", "wuzimu", "torino", "jizzy", "maddogg", "cat", "claude", "ryder2", "ryder3", "emmet", "andre", "kendl", "jethro", "zero", "tbone", "sindaco", "janitor", "bbthin", "smokev", "psycho" }

-- Screen stuff
local screenX, screenY = guiGetScreenSize()
local screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.22, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
 -- 4:3 and others screens
else 
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.22, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
end

-- Records
displayStats = false
statsInited = false
statsAlpha = 0
displayedRecords = {}
for i = 1, 10 do
	displayedRecords[i] = {}
	displayedRecords[i]["playername"] = ""
	displayedRecords[i]["time"] = 0
end
helpText = "F5"

-- Race Data
environment = {}
vehicle = {}
race = {}
clientMarkers = {}
for i = 1, 25 do
	clientMarkers[i] = {}
	clientMarkers[i][1] = 5000
	clientMarkers[i][2] = 5000
	clientMarkers[i][3] = 5000
end

-- Race Elements
marker = nil
markerNext = nil
markerBlip = nil
markerNextBlip = nil
markerCol = nil

-- States 
spawnCheckCompleted = false
showSplashScreen = false
firstSpawned = false
dataReceived = false
failedCP = false

-- Function checks spectate mode
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 20000 then return true	
	else return false end
end

-- Recreate markers when player's gone back from spectate mode or died
function resetCheckpoints()
	if dataReceived and firstSpawned then
		exports.race:setCheckpointText((getElementData(localPlayer, "race.checkpoint") - 1) .. ' / ' .. race["maxCP"])
		
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
				markerCol = createColCircle(clientMarkers[c][1], clientMarkers[c][2], race["markerSize"] + 5)
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
	
	dxDrawText(race["mapname"], screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003+0.03), screenX, screenY, tocolor(0, 0, 0, statsAlpha), (screenY/1200)*3.02, (screenY/1200)*3.15, "beckett")
	dxDrawText(race["mapname"], screenX*st_offsets[1], screenY*(st_offsets[2]+0.03), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), (screenY/1200)*3, (screenY/1200)*3, "beckett")
	
	local box_height = (screenY*s_offsets[4]) * 0.9
	local textSize = box_height / 75 / (11 / 2)
	local offset = box_height / 11

	-- Draw stats
	for i = 1, 10 do
		dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic", "right")
		dxDrawText(tostring(displayedRecords[i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic")
		dxDrawText(convertToRaceTime(displayedRecords[i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07) + offset, screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), textSize, textSize, "bankgothic", "right")
		offset = offset + (box_height / 11)
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
	-- Player State Checks
	local newPlayerState = "not ready"
	--outputChatBox(tostring(getElementData(localPlayer, "state")))
	
	if getElementData(localPlayer, "state") ~= nil and getElementData(localPlayer, "state") ~= false then
		newPlayerState = getElementData(localPlayer, "state")
		if isLocalPlayerSpectating() then newPlayerState = "spectating" end
	end
	
	if newPlayerState ~= playerState then -- Player race state changed
		--outputChatBox("new: " ..newPlayerState.. " old: " ..playerState)
		if playerState == "spectating" and newPlayerState == "alive" then 
			resetCheckpoints() 
		end
		
		playerState = newPlayerState
		if isLocalPlayerSpectating() then playerState = "spectating" end
	end
	
	if not dataReceived and not firstSpawned and getPedOccupiedVehicle(localPlayer) and not checkFirstPosition then
		setElementData(localPlayer, "gotdata", 0)
		
		if not seed then 
			seed = true
			setTimer(function() showSplashScreen = true end, 3800, 1)
			setElementData(localPlayer, "skipped", 0)
			setElementData(localPlayer, "nogen", 0)
			
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
			
			outputChatBox("#E7D9B0You can get records for this map by pressing #00FF00" ..helpText, 0, 0, 0, true)
			setTimer(function() outputChatBox("#E7D9B0You can #00FF00skip #E7D9B0unattainable checkpoint by command #00FF00/voteskip", 0, 0, 0, true) end, 90000, 1)
		end
	end
	
	if dataReceived then
		if getKeyState("tab") then
			setPlayerHudComponentVisible("radar", false)
			--dxDrawRectangle(screenX*0.7, screenY*0.2, (screenX*0.98 - screenX*0.7), (screenY*0.5 - screenY*0.2), tocolor(0, 0, 0, 200, 50))
			dxDrawRectangle(screenX*0.05, screenY*0.6, (screenX*0.98 - screenX*0.7), (screenY*0.5 - screenY*0.2), tocolor(0, 0, 0, 200, 50))
			
			local data = {
				"Model: " ..vehicle["name"].. " (" ..vehicle["model"].. ")",
				"Type: " ..vehicle["type"],
				"Moon size: " ..environment["Moon"],
				"Checkpoint type: " ..race["markerType"],
				"Generated by: " ..race["generator"]:gsub("#%x%x%x%x%x%x", "")
			}
			
			if race["timems"] ~= nil then 
				table.insert(data, "Generated in: " ..tostring(race["timems"]).. " ms (" ..tostring(race["bends"]).. ")")
				table.insert(data, "Using nodes: " ..tostring(race["usednodes"]))
			end
			
			table.insert(data, "Date: " ..os.date(_, tostring(race["timestamp"]):sub(1, 10)))
			
			table.insert(data, "Checkpoints: " ..race["maxCP"].. " (" ..tostring(race["raceDistance"]).. " m.)")
			table.insert(data, "Ped: " ..race["pedID"].. " (" ..skinModelNames[race["pedID"]].. ")")
			
			if vehicle["type"] == "Automobile" or vehicle["type"] == "Monster Truck" or vehicle["type"] == "Quad" then
				local hydraulics = "false"
				if vehicle["hydraulics"] == 6 then hydraulics = "true" end
			
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
			end
			
			if vehicle["trailer"] ~= nil then
				table.insert(data, "Trailer: " ..tostring(vehicle["trailerName"]).. " (" ..tostring(vehicle["trailer"]).. ")")
				if vehicle["nitros"] == 3 then table.insert(data, "Nitro: true") 
				else table.insert(data, "Nitro: false") end
			end
			
			local pos 
			if #data < 11 then pos = 11
			else pos = #data end
			
			local box_height = (screenY*0.5 - screenY*0.2) * 0.9
			local textSize = box_height / 75 / (pos / 2)
			local offset = box_height / pos

			-- Draw info
			for i = 1, #data do		
				dxDrawText(data[i], screenX*0.06, screenY*0.60 + offset, screenX, screenY, tocolor(175, 202, 230, 200), textSize, textSize, "bankgothic")
				offset = offset + (box_height / pos)
			end
		else
			setPlayerHudComponentVisible("radar", true)
		end
	end
	
	if (not dataReceived) and showSplashScreen and not isLocalPlayerSpectating() then
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
		dxDrawText("Select the race", screenX / 2, screenY /2, screenX, screenY, tocolor(255, 255, 255, 255), 2, "default-bold")
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
		showSplashScreen = false
		
		if isElement(marker) then destroyElement(marker) end
		if isElement(markerNext) then destroyElement(markerNext) end
		if isElement(markerBlip) then destroyElement(markerBlip) end
		if isElement(markerNextBlip) then destroyElement(markerNextBlip) end
		if isElement(markerCol) then destroyElement(markerCol) end
		
		return
	end
	
	if getPedOccupiedVehicle(localPlayer) then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local k,l = getVehicleTurretPosition(getPedOccupiedVehicle(localPlayer))
		
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 432 then
			setVehicleTurretPosition(getPedOccupiedVehicle(localPlayer), math.rad((getPedCameraRotation(localPlayer)*(-1) - z)-180), l)
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
addEventHandler("recieveMarkers", localPlayer, function(servermarkers, servervehicle, serverrace, serverenvironment)
	if getElementData(localPlayer, "gotdata") == 0 then
		showSplashScreen = false
	
		clientMarkers = servermarkers
		vehicle = servervehicle
		race = serverrace
		environment = serverenvironment
		dataReceived = true
		
		setTimer(function() spawnCheckCompleted = true end, 3000, 1)
		
		setWorldProperty("AmbientColor", environment["AmbientColor"][1], environment["AmbientColor"][2], environment["AmbientColor"][3])
		setWorldProperty("Illumination", environment["Illumination"])
		
		setElementPosition(getPedOccupiedVehicle(localPlayer), vehicle["spawnX"], vehicle["spawnY"], vehicle["spawnZ"])
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, vehicle["spawnRot"])
		
		firstSpawned = true
		
		if vehicle["type"] == "Helicopter" or vehicle["type"] == "Plane" then
			setVehicleRotorSpeed(getPedOccupiedVehicle(localPlayer), 1.0)
			setVehicleLandingGearDown(getPedOccupiedVehicle(localPlayer), false)
			race["markerSize"] = 15
		else race["markerSize"] = 10 end
		
		if getElementRadius(getPedOccupiedVehicle(localPlayer)) > race["markerSize"] then
			race["markerSize"] = getElementRadius(getPedOccupiedVehicle(localPlayer)) * 2
		end
		
		resetCheckpoints()
		
		-- Extra jumps for Area 69
		if vehicle["type"] ~= "Plane" and vehicle["type"] ~= "Helicopter" and getElementRadius(getPedOccupiedVehicle(localPlayer)) > 4.6 then
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
		
		setElementData(localPlayer, "gotdata", 1)
		
		-- Messages
		if vehicle["trailer"] == nil then
			if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then outputChatBox("#E7D9B0Today we are playing an #00FF00air race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..tostring(race["raceDistance"]).. " #E7D9B0m.)", 0, 0, 0, true)
			elseif vehicle["type"] == "Boat" then outputChatBox("#E7D9B0Today we are playing a #00FF00boat race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..tostring(race["raceDistance"]).. " #E7D9B0m.)", 0, 0, 0, true)
			else outputChatBox("#E7D9B0Today we are playing a #00FF00race #E7D9B0with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0(#00FF00" ..tostring(race["raceDistance"]).. " #E7D9B0m.)", 0, 0, 0, true) end
		else
			if vehicle["model"] == 525 then outputChatBox("#E7D9B0Today we are playing a #00FF00car delivery #E7D9B0race with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0with #00FF00" ..vehicle["trailerName"].. " #E7D9B0(#00FF00" ..tostring(race["raceDistance"]).. " #E7D9B0m.)", 0, 0, 0, true)
			else outputChatBox("#E7D9B0Today we are playing a #00FF00trailer delivery #E7D9B0race with #00FF00" ..race["maxCP"].. " #E7D9B0checkpoints using #00FF00" ..vehicle["name"].. " #E7D9B0with #00FF00" ..vehicle["trailerName"].. " #E7D9B0(#00FF00" ..tostring(race["raceDistance"]).. " #E7D9B0m.)", 0, 0, 0, true) end
		end
		
		outputChatBox("#E7D9B0Remember to #00FF00rate #E7D9B0saved maps using #00FF00/ratemap [0-10] #E7D9B0command", 0, 0, 0, true)
	end
end )

-- Event called from the server script for receiving stats data
addEvent("receiveStats", true)
addEventHandler("receiveStats", getRootElement(), function(recordsStats)	
	-- Handle Vehicle Records
	for i, recordsData in pairs(recordsStats) do 
		displayedRecords[i]["playername"] = recordsData["playername"]
		displayedRecords[i]["time"] = recordsData["score"]
	end
	
	if #recordsStats < 10 then
		for i = #recordsStats + 1, 10 do
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