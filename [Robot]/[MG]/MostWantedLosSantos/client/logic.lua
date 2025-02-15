local honkProgress = 0
local honkTimer = nil

addEvent(g_STOP_JOB_EVENT, true)
addEventHandler(g_STOP_JOB_EVENT, resourceRoot, function(id)
	cleanupJobs()
end)

addEvent(g_FINISH_JOB_EVENT, true)
addEventHandler(g_FINISH_JOB_EVENT, resourceRoot, function(id)
	cleanupJobs()
end)

addEvent(g_JOB_STATUS_UPDATE_EVENT, true)
addEventHandler(g_JOB_STATUS_UPDATE_EVENT, resourceRoot, function(id, type, data)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if type == g_DELIVERY_JOB.type then
		triggerEvent(g_SHOW_DELIVERY_TARGET_EVENT, resourceRoot, data.pos)
		if data.subtype == g_DELIVERY_JOB.subtypes.DELIVERY then
			local col = createColCircle(data.pos.x, data.pos.y, g_DELIVERY_TARGET_SIZE)

			function finishDelivery(element)
				if getPedOccupiedVehicle(localPlayer) ~= element then return end
				removeEventHandler("onClientColShapeHit", col, finishDelivery)

				triggerServerEvent(g_FINISH_JOB_EVENT, resourceRoot, id)
			end
			addEventHandler("onClientColShapeHit", col, finishDelivery)
		elseif data.subtype == g_DELIVERY_JOB.subtypes.ELIMINATION then
			local ped = createPed(127, data.pos.x, data.pos.y, data.pos.z)
			local blip = nil
			setElementHealth(ped, 30)
			setElementRotation(ped, data.rot.x, data.rot.y, data.rot.z)
			setPedAnimation(ped, "dealer", "dealer_deal")

			local pedPositioner = setTimer(function()
				setElementPosition(ped, data.pos.x, data.pos.y, data.pos.z)
			end, 1000, 0)

			local turnPed = setTimer(function()
				setPedCameraRotation(ped, math.random(360))
			end, 100, 0)

			function pedTouched(ele)
				if ele == ped then
					killTimer(pedPositioner)
					removeEventHandler("onClientVehicleCollision", getPedOccupiedVehicle(localPlayer), pedTouched)
				end
			end

			local firstHit = false
			function pedHit()
				setPedControlState(ped, "forwards", true)
				if not firstHit then
					firstHit = true
					blip = createBlipAttachedTo(ped, 60)
					triggerEvent(g_HIDE_DELIVERY_TARGET_EVENT, resourceRoot)
				end
			end

			function pedDie()
				killTimer(turnPed)
				destroyElement(blip)
				removeEventHandler("onClientPedWasted", ped, pedDie)
				removeEventHandler("onClientPedDamage", ped, pedHit)
				triggerServerEvent(g_FINISH_JOB_EVENT, resourceRoot, id)
			end
			addEventHandler("onClientPedWasted", ped, pedDie)
			addEventHandler("onClientPedDamage", ped, pedHit)
			addEventHandler("onClientVehicleCollision", getPedOccupiedVehicle(localPlayer), pedTouched)
		end
	elseif type == g_HARVEST_JOB.type then
		triggerEvent(g_SHOW_DELIVERY_TARGET_EVENT, resourceRoot, data.pos)
		local col = createColCircle(data.pos.x, data.pos.y, g_DELIVERY_TARGET_SIZE)

		function finishDelivery(element)
			if getPedOccupiedVehicle(localPlayer) ~= element then return end
			removeEventHandler("onClientColShapeHit", col, finishDelivery)

			local organCount = 0
			local screenWidth, screenHeight = guiGetScreenSize()
			local width = 0.10
			local height = width / (screenHeight / screenWidth)
			local startX = (1 - width * 3) / 2
			local startY = (1 - height * 2) / 2

			local organs = {
				"client/resources/org_brain.png",
				"client/resources/org_eyeleft.png",
				"client/resources/org_eyeright.png",
				"client/resources/org_heart.png",
				"client/resources/org_intestines.png",
				"client/resources/org_kidleft.png",
				"client/resources/org_kidright.png",
				"client/resources/org_liver.png",
				"client/resources/org_lung.png",
				"client/resources/org_marrow.png",
				"client/resources/org_pancreas.png",
				"client/resources/org_test.png",
			}
			for i = 0, 5 do
				local organ = organs[math.random(#organs)]
				local window = guiCreateWindow(startX + width * (i % 3), startY + height * math.floor(i / 3), width, height, "CLICK TO HARVEST", true)
				local image = guiCreateStaticImage(0, 0.1, 1, 1, organ, true, window)
				guiSetEnabled(image, false) -- prevent clicks from targeting image instead

				-- idk whats up with window
				function grabOrgan(windowOrButton)
					local gui = isElement(windowOrButton) and windowOrButton or source
					if isElement(gui) then
						removeEventHandler("onClientGUIClick", gui, grabOrgan)
						destroyElement(gui)
						organCount = organCount + 1
						playSound("client/resources/snippy.mp3")
						triggerServerEvent(g_FINISH_JOB_EVENT, resourceRoot, id)
						if organCount == 6 then
							showCursor(false, false)
						end
					end
				end
				addEventHandler("onClientGUIClick", image, grabOrgan)

				setTimer(function()
					grabOrgan(window)
				end, 10000, 1)
			end

			showCursor(true, false)
		end
		addEventHandler("onClientColShapeHit", col, finishDelivery)
	elseif type == g_EXTORTION_JOB.type then
		honkProgress = 0
		honkTimer = setTimer(function()
			if honkProgress >= 1 then
				triggerServerEvent(g_FINISH_JOB_EVENT, resourceRoot, id)
			end

			if getPedControlState(localPlayer, "horn") then
				honkProgress = math.min(honkProgress + g_EXTORTION_JOB.progressRate, 1)
			else
				honkProgress = math.max(honkProgress - g_EXTORTION_JOB.decayRate, 0)
			end

			triggerEvent(g_SHOW_PROGRESS_BAR_EVENT, resourceRoot)
			triggerEvent(g_UPDATE_PROGRESS_BAR_EVENT, resourceRoot, { progress = honkProgress })
		end, g_EXTORTION_JOB.interval, 0)
	elseif type == g_GROUP_JOB.type then
		if data.playerCount < g_GROUP_JOB.minPlayers then
			triggerEvent(g_PAUSE_JOB_EVENT, resourceRoot, data.playerCount)
		else
			triggerEvent(g_RESUME_JOB_EVENT, resourceRoot, data.playerCount)
		end
		triggerEvent(g_SHOW_PROGRESS_BAR_EVENT, resourceRoot)
		triggerEvent(g_UPDATE_PROGRESS_BAR_EVENT, resourceRoot, data)
	elseif data.progress then
		triggerEvent(g_SHOW_PROGRESS_BAR_EVENT, resourceRoot)
		triggerEvent(g_UPDATE_PROGRESS_BAR_EVENT, resourceRoot, data)
	end
end)

addEvent(g_GAME_STATE_UPDATE_EVENT, true)
addEventHandler(g_GAME_STATE_UPDATE_EVENT, resourceRoot, function(state)
	if getPlayerTeam(localPlayer) == getTeamFromName(g_PED_TEAM_NAME) then return end

	if state == g_COREGAME_STATE then
		local policeTeam = getTeamFromName(g_POLICE_TEAM_NAME)
		if getPlayerTeam(localPlayer) == policeTeam then
			local cops = getPlayersInTeam(policeTeam)
			for _, cop in ipairs(cops) do
				createBlipAttachedTo(cop, 0, 2, 30, 190, 240, 255, 6, 80085)
			end
		else
			function createCopSirens()
				setTimer(function()
					local cops = getPlayersInTeam(policeTeam)
					-- because cops may not be loaded yet
					if #cops == 0 then return createCopSirens() end

					for _, cop in ipairs(cops) do
						local x, y, z = getElementPosition(cop)
						local sound = playSound3D("client/resources/siren.mp3", x, y, z, true)
						setSoundMinDistance(sound, 20)
						setSoundMaxDistance(sound, 200)
						setTimer(function()
							if not isElement(cop) or isPedDead(cop) then
								if isElement(sound) then
									destroyElement(sound)
								end
								return
							end
							local x, y, z = getElementPosition(cop)
							setElementPosition(sound, x, y, z)
						end, 100, 0)
					end
				end, 1000, 1)
			end
			createCopSirens()
		end
	elseif state == g_NO_CRIMS_STATE then
		triggerEvent("onClientCall_race", root, "checkpointReached", getPedOccupiedVehicle(localPlayer))
	end
end)

addEventHandler("onClientVehicleDamage", root, function(a, w, l, dx, dy, dz, tire)
	if tire then cancelEvent() end
end)
addEventHandler("onClientExplosion", root, function(x, y, z, t)
	if t == 4 then cancelEvent() end
end)

-- suppress race mode error
addEvent("onClientCall_race", true)

function cleanupJobs()
	triggerEvent(g_HIDE_PROGRESS_BAR_EVENT, resourceRoot)
	honkProgress = 0
	if isTimer(honkTimer) then
		killTimer(honkTimer)
	end
	honkTimer = nil
end
