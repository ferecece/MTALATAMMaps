local currentJobs = {}
local deliveryTarget = nil
local showProgressBar = false
local progressBarProgress = 0
local money = {
	total = 0,
	handicap = 0,
	quota = 0
}
local deadPlayer = nil
local role = g_CRIMINAL_ROLE
local moneyScaler = 1000
local uiTimer = nil
local endGameStartedAt = nil

local showText = {}
local groupJobAppeared = "groupJobAppeared"
local harvestJobAppeared = "harvestJobAppeared"
local pickupJobInfo = "pickupJobInfo"
local deliveryJobInfo = "deliveryJobInfo"
local eliminationJobInfo = "eliminationJobInfo"
local extortionJobInfo = "extortionJobInfo"
local groupJobInfo = "groupJobInfo"
local harvestJobInfo = "harvestJobInfo"
local groupJobNeedsPeople = "groupJobNeedsPeople" -- value is the current people
local applyInfo = "applyInfo"
local roleInfo = "roleInfo"
local abandonedJob = "abandonedJob"
local jobAlreadyInProgress = "jobAlreadyInProgress"
local endGameInfo = "endGameInfo"
local crimeReported = "crimeReported"
local endGameInfo = "endGameInfo"
local escapeReady = "escapeReady"
local endEndGameInfo = "endEndGameInfo"
local endEndGameScrollTimer = nil
local badEndGameInfo = "badEndGameInfo"

addEvent(g_JOB_ALREADY_IN_PROGRESS_EVENT, true)
addEventHandler(g_JOB_ALREADY_IN_PROGRESS_EVENT, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	show(jobAlreadyInProgress, 1500)
end)

addEvent(g_SHOW_JOB_EVENT, true)
addEventHandler(g_SHOW_JOB_EVENT, resourceRoot, function(id, type, pos, data)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	local job = g_JOBS_BY_TYPE[type]

	currentJobs[id] = {
		marker = createMarker(pos.x, pos.y, pos.z - 1, "cylinder", job.zoneRadius, job.color.r, job.color.g, job.color.b, 73),
		blip = createBlip(pos.x, pos.y, pos.z, job.blip, 1, 255, 0, 0, 255, 0, job.detectionRadius),
	}

	if type == g_GROUP_JOB.type then
		show(groupJobAppeared, 3000)
	elseif type == g_HARVEST_JOB.type then
		deadPlayer = data
		show(harvestJobAppeared, 3000)
	end
end)

addEvent(g_HIDE_JOB_EVENT, true)
addEventHandler(g_HIDE_JOB_EVENT, resourceRoot, function(id)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end
	if not currentJobs[id] then return end

	destroyElement(currentJobs[id].marker)
	destroyElement(currentJobs[id].blip)

	currentJobs[id] = nil
end)

addEvent(g_START_JOB_EVENT, true)
addEventHandler(g_START_JOB_EVENT, resourceRoot, function(id, type)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if type == g_PICKUP_JOB.type then
		showText[pickupJobInfo] = true
	elseif type == g_EXTORTION_JOB.type then
		showText[extortionJobInfo] = true
	elseif type == g_GROUP_JOB.type then
		showText[groupJobInfo] = true
	end
end)

addEvent(g_STOP_JOB_EVENT, true)
addEventHandler(g_STOP_JOB_EVENT, resourceRoot, function(id, type)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	show(abandonedJob, 1500)

	if type == g_PICKUP_JOB.type then
		showText[pickupJobInfo] = false
	elseif type == g_EXTORTION_JOB.type then
		showText[extortionJobInfo] = false
	elseif type == g_GROUP_JOB.type then
		showText[groupJobInfo] = false
		showText[groupJobNeedsPeople] = false
	end
end)

addEvent(g_JOB_STATUS_UPDATE_EVENT, true)
addEventHandler(g_JOB_STATUS_UPDATE_EVENT, resourceRoot, function(id, type, data)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if type == g_DELIVERY_JOB.type then
		if data.subtype == g_DELIVERY_JOB.subtypes.DELIVERY then
			showText[deliveryJobInfo] = true
		elseif data.subtype == g_DELIVERY_JOB.subtypes.ELIMINATION then
			showText[eliminationJobInfo] = true
		end
	elseif type == g_HARVEST_JOB.type then
			showText[harvestJobInfo] = true
	end
end)

addEvent(g_PAUSE_JOB_EVENT)
addEventHandler(g_PAUSE_JOB_EVENT, resourceRoot, function(count)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	showText[groupJobNeedsPeople] = count
end)

addEvent(g_RESUME_JOB_EVENT)
addEventHandler(g_RESUME_JOB_EVENT, resourceRoot, function(count)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	showText[groupJobNeedsPeople] = false
end)

addEvent(g_FINISH_JOB_EVENT, true)
addEventHandler(g_FINISH_JOB_EVENT, resourceRoot, function(id, type, reportedCriminals)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if role == g_CRIMINAL_ROLE then
		playSound("client/resources/lodsofemone.mp3")

		for _, player in pairs(reportedCriminals) do
			if player == localPlayer then
				show(crimeReported, 3500)
				break
			end
		end

		if type == g_PICKUP_JOB.type then
			showText[pickupJobInfo] = false
		elseif type == g_DELIVERY_JOB.type then
			showText[deliveryJobInfo] = false
			showText[eliminationJobInfo] = false
			triggerEvent(g_HIDE_DELIVERY_TARGET_EVENT, resourceRoot)
		elseif type == g_EXTORTION_JOB.type then
			showText[extortionJobInfo] = false
		elseif type == g_GROUP_JOB.type then
			showText[groupJobInfo] = false
			showText[groupJobNeedsPeople] = false
		elseif type == g_HARVEST_JOB.type then
			showText[harvestJobInfo] = false
			triggerEvent(g_HIDE_DELIVERY_TARGET_EVENT, resourceRoot)
		end
	elseif role == g_POLICE_ROLE then
		-- lets police track criminals when they finish a job
		for _, criminal in pairs(reportedCriminals) do
			local blip = createBlipAttachedTo(criminal, 0, 2, 160, 0, 210, 255, 6, 80085)
			setTimer(function() destroyElement(blip) end, 5000, 1)
		end

		if #reportedCriminals > 0 then
			show(crimeReported, 5000)
		end
	end
end)

addEvent(g_SHOW_DELIVERY_TARGET_EVENT)
addEventHandler(g_SHOW_DELIVERY_TARGET_EVENT, resourceRoot, function(pos)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	deliveryTarget = {
		marker = createMarker(pos.x, pos.y, pos.z - 0.6, "checkpoint", g_DELIVERY_TARGET_SIZE, 255, 0, 0, 50),
		blip = createBlip(pos.x, pos.y, pos.z, 0, 3, 255, 0, 0, 255, 5)
	}
end)

addEvent(g_HIDE_DELIVERY_TARGET_EVENT)
addEventHandler(g_HIDE_DELIVERY_TARGET_EVENT, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if deliveryTarget then
		destroyElement(deliveryTarget.marker)
		destroyElement(deliveryTarget.blip)

		deliveryTarget = nil
	end
end)

addEvent(g_SHOW_PROGRESS_BAR_EVENT)
addEventHandler(g_SHOW_PROGRESS_BAR_EVENT, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end
	showProgressBar = true
end)

addEvent(g_HIDE_PROGRESS_BAR_EVENT)
addEventHandler(g_HIDE_PROGRESS_BAR_EVENT, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end
	showProgressBar = false
end)

addEvent(g_UPDATE_PROGRESS_BAR_EVENT)
addEventHandler(g_UPDATE_PROGRESS_BAR_EVENT, resourceRoot, function(data)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end
	progressBarProgress = data.progress
end)

addEvent(g_PLAYER_APPLY_FOR_POLICE_EVENT, true)
addEventHandler(g_PLAYER_APPLY_FOR_POLICE_EVENT, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	local prefer = true
	function togglePolicePreference()
		prefer = not prefer
		destroyElement(guiRoot)

		local screenWidth, screenHeight = guiGetScreenSize()
		if prefer then
			guiCreateStaticImage(screenWidth / 2 - 120, screenHeight * 0.6, 240, 240, "client/resources/iwannabeacop.png", false)
			playSound("client/resources/apply.mp3")
		else
			guiCreateStaticImage(screenWidth / 2 - 120, screenHeight * 0.6, 240, 240, "client/resources/iwannabeacop_bw.png", false)
		end
	end
	togglePolicePreference() -- to false which is what server thinks
	bindKey("space", "down", togglePolicePreference)

	uiTimer = show(applyInfo, g_POLICE_APPLICATION_DURATION, true, function()
		unbindKey("space", "down", togglePolicePreference)
		destroyElement(guiRoot)
		uiTimer = nil
	end)
end)

addEvent(g_PLAYER_ROLE_SELECTED_EVENT, true)
addEventHandler(g_PLAYER_ROLE_SELECTED_EVENT, resourceRoot, function(rolee)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	role = rolee

	function selectPerk(_, _, i)
		destroyElement(guiRoot)
		local screenWidth, screenHeight = guiGetScreenSize()


		if i == 1 then
			guiCreateStaticImage(screenWidth / 2 - 48 - 240, screenHeight * 0.7, 96, 96, "client/resources/fugitive.png", false)
			playSound("client/resources/select_fug.mp3")
		else
			guiCreateStaticImage(screenWidth / 2 - 48 - 240, screenHeight * 0.7, 96, 96, "client/resources/fugitive_bw.png", false)
		end
		if i == 2 then
			guiCreateStaticImage(screenWidth / 2 - 48, screenHeight * 0.7, 96, 96, "client/resources/mechanic.png", false)
			playSound("client/resources/select_mech.mp3")
		else
			guiCreateStaticImage(screenWidth / 2 - 48, screenHeight * 0.7, 96, 96, "client/resources/mechanic_bw.png", false)
		end
		if i == 3 then
			guiCreateStaticImage(screenWidth / 2 - 48 + 240, screenHeight * 0.7, 96, 96, "client/resources/hotshot.png", false)
			playSound("client/resources/select_hot.mp3")
		else
			guiCreateStaticImage(screenWidth / 2 - 48 + 240, screenHeight * 0.7, 96, 96, "client/resources/hotshot_bw.png", false)
		end
	end
	if role == g_CRIMINAL_ROLE then
		selectPerk(nil, nil, 0)
		bindKey("1", "down", selectPerk, 1)
		bindKey("2", "down", selectPerk, 2)
		bindKey("3", "down", selectPerk, 3)
	end

	uiTimer = show(roleInfo, g_PERK_SELECTION_DURATION, true, function()
		unbindKey("1", "down", selectPerk)
		unbindKey("2", "down", selectPerk)
		unbindKey("3", "down", selectPerk)
		destroyElement(guiRoot)
		uiTimer = nil
	end)
end)

addEvent(g_MONEY_UPDATE_EVENT, true)
addEventHandler(g_MONEY_UPDATE_EVENT, resourceRoot, function(data)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	money.total = math.floor(data.money * moneyScaler)
	money.quota = math.floor(data.moneyQuota * moneyScaler)
	money.handicap = math.floor(data.moneyHandicap * moneyScaler)
end)

addEvent(g_GAME_STATE_UPDATE_EVENT, true)
addEventHandler(g_GAME_STATE_UPDATE_EVENT, resourceRoot, function(state)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if state == g_ENDGAME_STATE then
		show(endGameInfo, 8000)
		endGameStartedAt = getRealTime().timestamp
	elseif state == g_ENDENDGAME_STATE then
		playSound("client/resources/pag.mp3")
		endEndGameScrollTimer = show(endEndGameInfo, 10000)
	elseif state == g_NO_CRIMS_STATE then
		show(badEndGameInfo, 8000)
	end
end)

addEvent(g_ESCAPE_ROUTE_APPEARED, true)
addEventHandler(g_ESCAPE_ROUTE_APPEARED, resourceRoot, function()
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	show(escapeReady, 3000)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	addEventHandler("onClientRender", root, function()
		if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

		local screenWidth, screenHeight = guiGetScreenSize()

		-- pager messages
		if showText[endEndGameInfo] then
			local timeLeft, _, totalTime = getTimerDetails(endEndGameScrollTimer)
			if timeLeft then
				if role == g_CRIMINAL_ROLE then
					local offset = (screenWidth + 1500) * (totalTime - timeLeft) / totalTime
					dxDrawText("WOULD YOU LOOK AT THAT......YOU HAVE FARMED LOS SANTOS THOROUGHLY WELL......GO SLAUGHTER SOME PIGS!!!  -BIG PIG", screenWidth - offset, screenHeight * 0.95,  screenWidth, screenHeight, tocolor(40, 255, 10, 250), 2, "default", center, top, false, false, false, true)
					dxDrawText("WOULD YOU LOOK AT THAT......YOU HAVE FARMED LOS SANTOS THOROUGHLY WELL......GO SLAUGHTER SOME PIGS!!!  -BIG PIG", screenWidth + 2 - offset, screenHeight * 0.95 + 2,  screenWidth, screenHeight, tocolor(200, 255, 200, 100), 2, "default", center, top, false, false, false, true)
					dxDrawText("WOULD YOU LOOK AT THAT......YOU HAVE FARMED LOS SANTOS THOROUGHLY WELL......GO SLAUGHTER SOME PIGS!!!  -BIG PIG", screenWidth - 2 - offset, screenHeight * 0.95 + 2,  screenWidth, screenHeight, tocolor(200, 255, 200, 100), 2, "default", center, top, false, false, false, true)
				elseif role == g_POLICE_ROLE then
					local offset = (screenWidth + 1200) * (totalTime - timeLeft) / totalTime
					dxDrawText("HAHAHAHAHA.......STUPID GREASY PIGS......YOU ARE ABOUT TO BE TURNED INTO BACON BITS!!!  -BIG PIG", screenWidth - offset, screenHeight * 0.95,  screenWidth, screenHeight, tocolor(40, 255, 10, 250), 2, "default", center, top, false, false, false, true)
					dxDrawText("HAHAHAHAHA.......STUPID GREASY PIGS......YOU ARE ABOUT TO BE TURNED INTO BACON BITS!!!  -BIG PIG", screenWidth + 2 - offset, screenHeight * 0.95 + 2,  screenWidth, screenHeight, tocolor(200, 255, 200, 100), 2, "default", center, top, false, false, false, true)
					dxDrawText("HAHAHAHAHA.......STUPID GREASY PIGS......YOU ARE ABOUT TO BE TURNED INTO BACON BITS!!!  -BIG PIG", screenWidth - 2 - offset, screenHeight * 0.95 + 2,  screenWidth, screenHeight, tocolor(200, 255, 200, 100), 2, "default", center, top, false, false, false, true)
				end
			end
		end

		-- random multi-purpose timer counter display
		if uiTimer and isTimer(uiTimer) then
			local timeLeft = getTimerDetails(uiTimer)
			if timeLeft then
				-- relative to CRIMINAL/POLICE text minus some
				dxDrawBorderedText(0.5,tostring(math.ceil(timeLeft / 1000)), screenWidth / 2, 80,  screenWidth, screenHeight, tocolor(222, 26, 26, 255), 4, "sans", center, top, false, false, false, true)
			end
		end

		-- fullscreen ui
		if showText[badEndGameInfo] then
			if role == g_POLICE_ROLE then
				dxDrawBorderedText(0.5, "All#A000D2 criminals#C8C8C8 are gone...", screenWidth / 2, screenHeight * 0.35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 3.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Temporary peace has returned to the city.", screenWidth / 2, screenHeight * 0.35 + 50,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 3.5, "sans", center, top, false, false, false, true)
			end
			return
		elseif showText[endGameInfo] then
			if role == g_CRIMINAL_ROLE then
				dxDrawBorderedText(0.5, "QUOTA REACHED!!!", screenWidth / 2, screenHeight * 0.25,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 4, "arial", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Evade the#33A5FF police#C8C8C8 until an #FFDC00escape route#C8C8C8 is ready!", screenWidth / 2, screenHeight * 0.75,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "There's also still more crimes to commit with your fellow #A000D2criminals#C8C8C8.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			elseif role == g_POLICE_ROLE then
				dxDrawBorderedText(1.0, "CHIEF of POLICE:", screenWidth / 2, screenHeight * 0.2,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Usage of M4 ASSAULT RIFLE approved.", screenWidth / 2, screenHeight * 0.2 + 40,  screenWidth, screenHeight, tocolor(30, 190, 240, 255), 3.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "EFFECTIVE IMMEDIATELY!", screenWidth / 2, screenHeight * 0.2 + 120,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)

				dxDrawBorderedText(0.5,"The#A000D2 criminals#C8C8C8 are trying to escape the city!", screenWidth / 2, screenHeight * 0.75,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
				dxDrawBorderedText(0.5,"Stop them before they circumvent our roadblocks!", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			end
			return
		elseif showText[applyInfo] then
				dxDrawBorderedText(0.5, "Not criminally-minded?", screenWidth / 2, screenHeight * 0.35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 3, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Attempt to apply to the#33A5FF LSPD#C8C8C8 by pressing space NOW!", screenWidth / 2, screenHeight * 0.35 + 55,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 3.8, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "SPACEBAR", screenWidth / 2, screenHeight * 0.6 + 245,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.2, "bankgothic", center, top, false, false, false, true)
				return
		elseif showText[roleInfo] then
			if role == g_CRIMINAL_ROLE then
				dxDrawBorderedText(0.5, "CRIMINAL", screenWidth / 2, screenHeight * 0.18,  screenWidth, screenHeight, tocolor(150, 0 , 200, 255), 5, "bankgothic")
				dxDrawBorderedText(0.5, "Complete the various jobs available in the city for money.", screenWidth / 2, screenHeight * 0.35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Once the money quota is reached, it's time to escape.", screenWidth / 2, screenHeight * 0.35 + 50,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "The police is out to get you. Evade them at all costs!", screenWidth / 2, screenHeight * 0.35 + 120,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)

				-- perk ui
				dxDrawBorderedText(0.5,"PRESS THE NUMBER KEY TO SELECT A PERK", screenWidth / 2, screenHeight * 0.6,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.3, "sans", center, top, false, false, false, true)

				dxDrawBorderedText(0.5, "1", screenWidth / 2 - 240, screenHeight * 0.7 - 35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.4, "FUGITIVE", screenWidth / 2 - 240, screenHeight * 0.7 + 130, screenWidth, screenHeight, tocolor(170, 0 , 220, 255), 2.7, "arial", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "Turn invisible with", screenWidth / 2 - 240, screenHeight * 0.7 + 165, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "handbrake while driving", screenWidth / 2 - 240, screenHeight * 0.7 + 185, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)

				dxDrawBorderedText(0.5, "2", screenWidth / 2, screenHeight * 0.7 - 35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.4, "MECHANIC", screenWidth / 2, screenHeight * 0.7 + 130, screenWidth, screenHeight, tocolor(170, 0 , 220, 255), 2.7, "arial", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "When standing still,", screenWidth / 2, screenHeight * 0.7 + 165, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "slowly regain health", screenWidth / 2, screenHeight * 0.7 + 185, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)

				dxDrawBorderedText(0.5, "3", screenWidth / 2 + 240, screenHeight * 0.7 - 35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.4, "HOTSHOT", screenWidth / 2 + 240, screenHeight * 0.7 + 130, screenWidth, screenHeight, tocolor(170, 0 , 220, 255), 2.7, "arial", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "The lower your health,", screenWidth / 2 + 240, screenHeight * 0.7 + 165, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)
				dxDrawBorderedText(0.5, "the higher your top speed", screenWidth / 2 + 240, screenHeight * 0.7 + 185, screenWidth, screenHeight, tocolor(210, 210, 210, 255), 1.3, "sans", center, top, false, false, false, false, true)
			elseif role == g_POLICE_ROLE then
				dxDrawBorderedText(0.5, "POLICE", screenWidth / 2, screenHeight * 0.18,  screenWidth, screenHeight, tocolor(30, 190, 240, 255), 5, "bankgothic")
				dxDrawBorderedText(0.5, "Criminals are planning to go on a crime spree.", screenWidth / 2, screenHeight * 0.35,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Once they've stolen enough, they will attempt to skip town.", screenWidth / 2, screenHeight * 0.35 + 50,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
				local vehicleSecondaryFireKey = next(getBoundKeys("vehicle_secondary_fire")) or "vehicle_secondary_fire"
				dxDrawBorderedText(0.5, "Deploy your firearm by pressing " .. vehicleSecondaryFireKey, screenWidth / 2, screenHeight * 0.35 + 140,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
				dxDrawBorderedText(0.5, "Use any force necessary to eliminate them!", screenWidth / 2, screenHeight * 0.35 + 190,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.5, "sans", center, top, false, false, false, true)
			end
			return
		end

		-- hud
		if money.quota > 0 then
			local width = 300
			local leftEdge = screenWidth * 0.75 - width / 2
			local topEdge = screenHeight * 0.22

			local crimWidth = math.min(g_SECRET_ENDING_REQUIREMENT_MULTIPLIER, money.total / money.quota) * width / g_SECRET_ENDING_REQUIREMENT_MULTIPLIER
			local handicapWidth = math.min(1, money.handicap / money.quota) * width / g_SECRET_ENDING_REQUIREMENT_MULTIPLIER
			local policeWidth = width - width / g_SECRET_ENDING_REQUIREMENT_MULTIPLIER
			local threshold = leftEdge + width - policeWidth - handicapWidth

			if endGameStartedAt then
				policeWidth = policeWidth * math.max(0, 1 - (getRealTime().timestamp - endGameStartedAt) / (g_FIRST_EXIT_SPAWN_DELAY / 1000))
				threshold = leftEdge + math.min(crimWidth, width / g_SECRET_ENDING_REQUIREMENT_MULTIPLIER)
			end

			dxDrawBorderedText(2, "CRIME-O-METER", leftEdge + width / 2, topEdge - 20, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 0.9, "bankgothic", center, top, false, false, false, true)
			dxDrawRectangle(leftEdge - 4, topEdge, width + 8, 27, tocolor(0, 0, 0))
			dxDrawRectangle(leftEdge, topEdge + 4, crimWidth, 10, tocolor(170, 0 , 220))
			dxDrawRectangle(threshold, topEdge + 14, handicapWidth, 10, tocolor(255, 220, 00))
			dxDrawRectangle(threshold + handicapWidth, topEdge + 14, policeWidth, 10, tocolor(30, 190, 240))

			dxDrawRectangle(threshold, topEdge, 3, 29, tocolor(190, 222, 222))
			if endGameStartedAt then
				dxDrawBorderedText(2, "escape", threshold, topEdge + 40, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 0.5, "bankgothic", center, top, false, false, false, true)
			else
				dxDrawBorderedText(2, "target", threshold, topEdge + 40, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 0.5, "bankgothic", center, top, false, false, false, true)
			end

			dxDrawRectangle(leftEdge + width, topEdge, 3, 29, tocolor(190, 222, 222))
			dxDrawBorderedText(2, "??", leftEdge + width, topEdge + 40, screenWidth, screenHeight, tocolor(190, 222, 222, 255), 0.5, "bankgothic", center, top, false, false, false, true)
		end

		-- top middle ui
		if showText[crimeReported] then
			if role == g_CRIMINAL_ROLE then
				dxDrawBorderedText(0.5,"CRIME REPORTED! LOCATION REVEALED!", screenWidth / 2, screenHeight * 0.24, 800, screenHeight, tocolor(222, 26, 26, 255), 3, "arial", center, top, false, false, false, true)
			elseif role == g_POLICE_ROLE then
				dxDrawBorderedText(0.5,"A #B100B4criminal#D2D2D2 was spotted fleeing a crime!", screenWidth / 2, screenHeight * 0.75 + 40, 800, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			end
		elseif showText[abandonedJob] then
			dxDrawBorderedText(0.5,"JOB ABANDONED", screenWidth / 2, screenHeight * 0.35, 800, screenHeight, tocolor(222, 26, 26, 255), 3, "arial", center, top, false, false, false, true)
		end

		-- slightly under top middle ui
		if showText[harvestJobAppeared] then
			dxDrawBorderedText(0.5, deadPlayer .. " #C8C8C8died, but their corpse might be useful...", screenWidth / 2, screenHeight * 0.32,  screenWidth, screenHeight, tocolor(160, 0, 210, 255), 2.8, "arial", center, top, false, false, false, true)
		elseif showText[groupJobAppeared] then
			dxDrawBorderedText(0.5,"A heist is being organised somewhere!", screenWidth / 2, screenHeight * 0.3,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "arial", center, top, false, false, false, true)
		end

		-- bottom middle ui
		if showText[escapeReady] then
			if role == g_CRIMINAL_ROLE then
				dxDrawBorderedText(0.5,"Received possible#FFDC00 escape routes#C8C8C8!", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			elseif role == g_POLICE_ROLE then
				dxDrawBorderedText(0.5,"Some#FFDC00 escape routes#C8C8C8 have been reported!", screenWidth / 2, screenHeight * 0.75 + 40 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			end
		elseif showText[jobAlreadyInProgress] then
			dxDrawBorderedText(0.5,"Complete your current#DE1A1A job#D2D2D2 first.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[harvestJobInfo] then
			dxDrawBorderedText(0.5,"Looks like some things are still in decent condition, probably.", screenWidth / 2, screenHeight * 0.75,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			dxDrawBorderedText(0.5,"Drop the body off at the#DE1A1A crooked doctor#D2D2D2 nearby.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[pickupJobInfo] then
			dxDrawBorderedText(0.5,"Wait in place. The money is coming.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[extortionJobInfo] then
			dxDrawBorderedText(0.5,"Intimidate by honking until you get the money.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[groupJobNeedsPeople] then
			dxDrawBorderedText(0.5,"You will need " .. (g_GROUP_JOB.minPlayers - showText[groupJobNeedsPeople]) .. " more associate(s) to start this heist.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[groupJobInfo] then
			dxDrawBorderedText(0.5,"The heist has started!", screenWidth / 2, screenHeight * 0.75,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
			dxDrawBorderedText(0.5,"Stay in the area to receive money when the job is completed!", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[deliveryJobInfo] then
			dxDrawBorderedText(0.5,"Deliver the goods to this#DE1A1A location#D2D2D2 to get the money.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		elseif showText[eliminationJobInfo] then
			dxDrawBorderedText(0.5,"Eliminate the#DE1A1A snitch#D2D2D2 to get the money.", screenWidth / 2, screenHeight * 0.75 + 40,  screenWidth, screenHeight, tocolor(210, 210, 210, 255), 2.8, "default-bold", center, top, false, false, false, true)
		end

		-- slightly under bottom middle ui
		if showProgressBar then
			local color = tocolor(255, 255, 255)

			dxDrawRectangle(screenWidth / 2 - 126, screenHeight * 0.85, 252, 27, tocolor(0, 0, 0))
			dxDrawRectangle(screenWidth / 2 - 122, screenHeight * 0.85 + 4, 244, 19, tocolor(40, 40, 40))
			dxDrawRectangle(screenWidth / 2 - 122, screenHeight * 0.85 + 4, 244 * progressBarProgress, 19, color)
		end
	end)
end)

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local textWidth, textHeight = dxGetTextSize(text, 0, scale, scale, font, false, true)
    local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline - textWidth / 2, top - outline - textHeight / 2, right - outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline - textWidth / 2, top - outline - textHeight / 2, right + outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline - textWidth / 2, top + outline - textHeight / 2, right - outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline - textWidth / 2, top + outline - textHeight / 2, right + outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline - textWidth / 2, top - textHeight / 2, right - outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline - textWidth / 2, top - textHeight / 2, right + outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - textWidth / 2, top - outline - textHeight / 2, right, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - textWidth / 2, top + outline - textHeight / 2, right, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left - textWidth / 2, top - textHeight / 2, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function show(key, duration, val, cleanup)
	showText[key] = val or true
	return setTimer(function()
		showText[key] = false
		if cleanup then cleanup() end
	end, duration, 1)
end

