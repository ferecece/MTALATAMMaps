

function enterVehicle(v, seat, jacked )
	setTimer(function()
		if getElementModel(v) == 437 then
			setElementAlpha(v,0)
			setVehicleOverrideLights(v,1) -- turn lights off
		end
	end,500,1)
end
addEventHandler ( "onPlayerVehicleEnter", root, enterVehicle )

function raceState(newstate,oldstate)

	if (newstate == "LoadingMap") then
		setCloudsEnabled(false)
		--setTimer(function()
			-- outputChatBox("You can read the story of #126B57 The Haunted Revenge of Captain Marquis de La Fayette and his Trusted Compagnions #FFFFFFin the console by pressing #126B57F8#FFFFFF.", root, 255,255,255, true)
			-- outputConsole(" ")
			-- outputConsole("--------------------------------------------------------------------------------")
			-- outputConsole(" ")
			-- outputConsole("The Haunted Revenge of Captain Marquis de La Fayette and his Trusted Compagnions")
			-- outputConsole(" ")
			-- outputConsole(" ")
			-- outputConsole("Once upon a moonlit night in the heart of the San Andrean Sea, where the whispers of ghostly tales mingled with the salty breeze, there sailed the formidable vessel, the 'Phantom's Fury'. Captained by the enigmatic Marquis de La Fayette, a man with a shadowy past and a quest for vengeance that transcended even death. Legend had it that Captain La Fayette and his trusted companions, a band of loyal souls bound by a code of honor and duty, had met a cruel fate at the hands of treacherous foes. Their spirits, restless and aggrieved, returned to the mortal realm seeking retribution for the injustices done unto them.")
			-- outputConsole(" ")
			-- outputConsole("As the fog rolled in, obscuring the moon and shrouding the seas in a veil of mystery, the Phantom's Fury emerged from the mist like a specter from the depths. Its tattered sails billowed in the ghostly wind, and its hull groaned with the weight of centuries-old grudges.")
			-- outputConsole(" ")
			-- outputConsole("On the shores of a remote island, nestled amidst jagged cliffs and swirling mists, stood the fortress of Captain La Fayette's betrayers. Ignorant of the spectral storm brewing offshore, they reveled in their ill-gotten gains, unaware of the impending doom that loomed over them.")
			-- outputConsole(" ")
			-- outputConsole("With a thunderous crash, the Phantom's Fury descended upon the unsuspecting fortress like a wrathful tempest. Ghostly apparitions, clad in tattered remnants of their former glory, stormed the ramparts with a ferocity born of righteous fury. Captain La Fayette, his eyes ablaze with vengeance, led the charge with his trusted companions at his side. Their translucent forms cut through the mortal ranks like shadows, striking fear into the hearts of those who had wronged them.")
			-- outputConsole(" ")
			-- outputConsole("In the chaos that ensued, justice was swift and merciless. ")
			-- outputConsole(" ")
			-- outputConsole("The fortress, once a symbol of tyranny and oppression, crumbled beneath the weight of its own corruption. ")
			-- outputConsole(" ")
			-- outputConsole("And as the first light of dawn broke over the horizon, the spirits of Captain La Fayette and his companions found peace at last, their thirst for revenge sated by the sweet taste of victory.")
			-- outputConsole(" ")
			-- outputConsole("From that day forth, the tale of the haunted revenge of Captain Marquis de La Fayette and his trusted companions echoed through the annals of history.")
			-- outputConsole(" ")
			-- outputConsole("A warning to all who dare to cross the line between honor and treachery in the waters of the San Andrean Sea.")
			-- outputConsole(" ")
			-- outputConsole("--------------------------------------------------------------------------------")
			-- outputConsole(" ")
		--end,1000,1)
	end
	
	if (newstate == "GridCountdown") then

	end


	if (newstate == "Running" and oldstate == "GridCountdown") then
		--setCloudsEnabled(false)
		--setWaterLevel (-10,false,false)
		-- for i,p in ipairs(getElementsByType("player")) do
		-- 	local v = getPedOccupiedVehicle(p)
		-- 	if v then
		-- 		setElementAlpha(v,0)
		-- 		setVehicleOverrideLights(v,1) -- turn lights off
		-- 	end
		-- end
	--setWindVelocity ( 1000, 1000, 0)

	-- gravity does not influence flying cars		
	-- 	grav = 100
	-- 	setTimer(function()
	-- 		for i,p in ipairs(getElementsByType("player")) do
	-- 			--setPedGravity(p,grav)
	-- 			grav = grav*-1
	-- 			outputChatBox(grav)
	-- 		end
	-- 	end,1000,0)
	end

end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

-- onlyOnce = {}
-- function enterVehicle ( v, seat, jacked ) --when a player enters a vehicle
	
-- 	if not onlyOnce[v] then
-- 		onlyOnce[v] = true
-- 		attachMarquis(v)
-- 		--attachPirateShip(v)
-- 	end
-- end
--addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onPlayerVehicleEnter

function attachMarquis(v)
	-- Attach dummy boat to car:
	local vDummy = createVehicle(484,0,0,0) -- create Boat
	setElementAlpha(vDummy,150)
	setVehicleDamageProof(vDummy,true)

	-- --setElementData(vDummy,'race.collideothers',1) -- enable colisions
	attachElements(vDummy,source,0,0,10) --attach dummy to entered vehicle

	setTimer(function()
		setElementAttachedOffsets(vDummy,0,-5,-1) --workaround (for testing)
	end,100,1)
end

function attachPirateShip(v)
	-- Attach pirate ship
	local vDummy = createObject(8493,0,0,0) -- pirate ship model
	local vDummy2 = createObject(9159,0,0,0) -- ship flags model
	
	-- Make it spooky
	setElementAlpha(vDummy,200)
	setElementCollisionsEnabled(vDummy,false)
	
	-- Scale it down
	setObjectScale(vDummy,0.2)
	setObjectScale(vDummy2,0.2)

	-- Attach to vehicle
	attachElements(vDummy,v,0,0,1.5) --attach dummy to entered vehicle
	attachElements(vDummy2,v,0,0,1.5) --attach dummy to entered vehicle
end


function onCheckpoint(cp, time)
	--outputChatBox(cp)

	local v = getPedOccupiedVehicle(source)
	if v then
		setElementAlpha(v,0)
		setVehicleOverrideLights(v,1) -- turn lights off
	end
	
	if cp == 1 then
		if v then
			attachMarquis(v)
		end
	end

	if cp == 22 then

		if v then
			--local vx,vy,vz = getElementVelocity(v)
			--outputChatBox(vx .. " " .. vy .. " " .. vz)
			setElementPosition(v,-1905,-1270,55.3)
			setElementRotation(v,0,0,0)
			setElementAngularVelocity(v,0,0,0)
			setElementVelocity(v,0.05,25,1.65)
			--setTimer(setElementVelocity,100,100,v,0,20,0)
		end
	end

	if cp == 23 then
		local v = getPedOccupiedVehicle(source)
		if v then
			-- local vx,vy,vz = getElementVelocity(v)
			-- outputChatBox(vx .. " " .. vy .. " " .. vz)
			setElementRotation(v,0,0,0)
			setElementAngularVelocity(v,0,0,0)
			setElementVelocity(v,0.010132104158401/4, 3.999124288559/4, -0.81113237142563/4)
		end
	end

	if cp == 38 then
		local x,y,z = getElementPosition(v)
		blowVehicle(v)
		createObject(7916, x, y, z, 0, 0, -9.75)
	end

end
addEventHandler("onPlayerReachCheckpoint", getRootElement(), onCheckpoint)


addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	local v = getPedOccupiedVehicle(source)
	if not v then 
		return 
	end
	setTimer(function()
		local x,y,z = getElementPosition(v)
		createObject(7916, x, y, z, 0, 0, -9.75)	
		blowVehicle(v)
	end,1000,1)
end)
