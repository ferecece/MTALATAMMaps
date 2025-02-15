---------------------------------------------
-- Global variables
---------------------------------------------
g_sent = {}
racesate = nil

-- Limit the fog to this area
--g_Limits = {x = 1400, y = -1200, w = 3200, h = 3200}
g_Limits = {xmin = -200, xmax = 3000, ymin = -2800, ymax = 400}

g_Area = {x = 0, y = 0, w = 3000, h = 3000}

gameAreaCol	= nil
radarArea1	= nil

changeTo = {}

lowRiders = {536,575,534,567,535,576,412}

debug = false

--TODO: area size tbd by number of players
--TODO: shrink faster if a lot of players died in a big arena
--Todo: soft landing system

---------------------------------------------
-- Start & Setting up
---------------------------------------------

-- Triggers on changing of race state
function raceState(newstate,oldstate)
	racestate = newstate
	--outputChatBox(newstate)

	-- Choose a final area & build the generator, randomize weapon pickups
	-- Make the game area radar
	-- onVehicleEnter:
		-- gives random skin
		-- send the game area radar to the client, the client checks if the camera is outside to set the sandstorm
		-- Show the client drop map only if the the race has not started

	if (newstate == "LoadingMap") then
		

		-- Build the force field generator:
		-- pick random location from the available ones
		finalAreas = {}
		for i,e in ipairs (getElementsByType("object")) do 
			if getElementModel(e) == 6295 then
				table.insert(finalAreas, e)
				setElementAlpha(e,0)
				setElementCollisionsEnabled(e,false)
			end
		end
		finalArea = finalAreas[math.random(1,#finalAreas)]
		setElementAlpha(finalArea,255)
		setElementCollisionsEnabled(finalArea,true)

		local x,y,z = getElementPosition(finalArea)
		
		-- set area coordinates
		g_Area.x = x-0.0302734375 --math.random(-2000,2000)
		g_Area.y = y-1.669921875  -- math.random(-2000,2000)

		-- GLOW
		createMarker( x-0.0302734375, y-1.669921875, z+22.5, "corona" , 5 , 253, 143, 0 , 100)

		-- goo
		local goo = createObject(2976, x-0.0302734375, y-1.669921875, z+21)
		setObjectScale(goo,3.5)

		-- goo arms
		local a = createObject(16663, x-0.0302734375, y-1.669921875, z+21)
		local b = createObject(16663, x-0.0302734375, y-1.669921875, z+21)
		setObjectScale(a,0.8)
		setObjectScale(b,0.8)
		attachElements(a, goo, 0.7998046875-0.0302734375, -0.5703125 + 1.669921875, 22.8 - 21)
		attachElements(b, goo, -0.8896484375-0.0302734375,-2.83984375 + 1.669921875, 22.8 - 21 , 0 , 0, 180)

		-- repeatedly rotate it 360deg over 3 sec
		setTimer(function()
			moveObject(goo, 3000, x-0.0302734375, y-1.669921875, z+21, 0, 0, 360)
		end, 3000, 0)

		-- Fire extinguisher pickups become random weapons
		randomizePickups()


		-- create game area radar
		updateZone()

		--send trigger to client when entering vehicle
		addEventHandler ( "onVehicleEnter", getRootElement(), function ( thePlayer, seat, jacked )
			
			if getElementType(thePlayer) ~= "player" then
				return
			end

			-- Give player a random skin and low rider when entering the vehicle
			setElementModel(thePlayer,math.random(1,312))
			setElementModel(source, lowRiders[math.random(1,#lowRiders)])

			-- Send the radar area to the client
			triggerClientEvent(thePlayer, 'updateWeather', resourceRoot, gameAreaCol)



			-- Show the drop map if you enter a vehicle at the start of the race (and only send once, because respawn is enabled for testing)
			if not g_sent[thePlayer] and ((racestate == "LoadingMap") or (racestate == "PreGridCountdown") or (racestate == "GridCountdown")) then
				sendStartingGUI(thePlayer)
			end


		end)
	end

	
	if (newstate == "GridCountdown") then
		for i,p in ipairs(getElementsByType("player")) do

			sendStartingGUI(p)

			if debug then
				bindKey (p, "F4", "down", spawnPlayers )  -- for testing ONLY 
			end

			-- make driveby toggleable
			bindKey(p, "vehicle_secondary_fire", "down", toggleDriveBy)
			bindKey(p, "horn", "both", honkHealing)

			-- hide other players blips on the mini map
			local attached = getAttachedElements ( p ) 
		    if ( attached ) then 
		        for k, element in ipairs(attached) do 
		            if getElementType ( element ) == "blip" then 
		                destroyElement ( element ) 
		            end 
		        end 
		    end
		end

	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		-- Close the map and start the game!

		-- fade out camera
		setTimer(function()
			for i,p in ipairs(getAlivePlayers()) do
				fadeCamera(p, false)
				local v = getPedOccupiedVehicle(p)
				if v then
					setElementVelocity(v,0,0,1)
				end
			end
		end, 3000,1)

		setTimer(function() --give players some time to choose a drop spot
			
			if not debug then
				spawnPlayers() --comment out for testing, is instead triggered with f4
			end

			setTimer(function() -- give some time for landing before shrinking
				
				setTimer(function () -- shrink the zone!

					if g_Area.w > 4 then
						g_Area.w = g_Area.w - 0.5
						g_Area.h = g_Area.w - 0.5
						updateZone()
					end

				end, 50, 0)

				setTimer(function () -- damage if outside
					for i,p in ipairs(getAlivePlayers()) do
						v = getPedOccupiedVehicle(p)
						if v then
							local x,y,z = getElementPosition(v)
							if not isInsideRadarArea ( gameAreaCol, x, y ) then
								h = getElementHealth (v)
								if not debug then
									setElementHealth(v, h - 30)
								end
							end
						end
					end	

				end, 1000, 0)

			end,10000,1)

		end,5000,1) 

	end

end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

function sendStartingGUI(thePlayer)
	if g_sent[thePlayer] then
		return
	end
	
	g_sent[thePlayer] = true
				
	-- Choose clustered random position inside radar area
	-- Gives incentive to actually choose
	-- TODO: make sure you spawn on LAND
	-- This buggs if someone reconnects
	local x,y = getElementPosition(gameAreaCol)
	local randomX = x + g_Area.w - 300 + math.random(-50,50)
	local randomY = y + g_Area.h - 300 + math.random(-50,50)
	setElementData(thePlayer, "BD.mapPos", { x = randomX, y = randomY}, true)

	-- Send the client event to open the gui
	if not debug then
		triggerClientEvent(thePlayer, 'showClientMap', resourceRoot)
		--outputChatBox('normal')
	end
	--outputChatBox('Showing map', thePlayer)
end


-- Get the selected position and spawn the player
function spawnPlayers()
	
	for i,p in ipairs (getAlivePlayers()) do 
		fadeCamera(p,true)

		local veh = getPedOccupiedVehicle(p)
		local pos = getElementData( p, "BD.mapPos")
		--outputChatBox(pos.x)

		if pos then
			--outputChatBox('setting pos')
			if pos.x then
				setElementPosition(veh, pos.x, pos.y, 500)
			else
				-- workaround for reconnect during drop map open
				local x,y = getElementPosition(gameAreaCol)
				local randomX = x + g_Area.w - 300 + math.random(-50,50)
				local randomY = y + g_Area.h - 300 + math.random(-50,50)
				setElementPosition(veh, randomX, randomY, 500)
			end
		else
			-- workaround for reconnect during drop map open
			local x,y = getElementPosition(gameAreaCol)
			local randomX = x + g_Area.w - 300 + math.random(-50,50)
			local randomY = y + g_Area.h - 300 + math.random(-50,50)
			setElementPosition(veh, randomX, randomY, 500)
		end

		setElementVelocity(veh,0,0,0)
		setElementAngularVelocity(veh,0,0,0)
	end

	triggerClientEvent('closeClientMap', resourceRoot) --close map for all clients

end

--------------------------------------------------------------------
-- Gameplay
-------------------------------------------------------------------
function updateZone ()

	--		  400
	--   	  __
	-- -200 |    | 3000
	--	      --
	--		- 2800

	-- If the area is out of limits, move the center so that the edges are in limits again
	local x = g_Area.x
	local y = g_Area.y
	local w = g_Area.w
	local h = g_Area.h

	if (x - w/2) < (g_Limits.xmin)  then
		x = g_Limits.xmin+w/2
	elseif (x + w/2) > (g_Limits.xmax) then
		x = g_Limits.xmax-w/2
	end

	if (y - h/2) < (g_Limits.ymin)  then
		y = g_Limits.ymin+h/2
	elseif (y + h/2) > (g_Limits.ymax) then
		y = g_Limits.ymax-h/2
	end

	-- If no colshape has been made then make it (happens on first call)
	if not radarArea1 then
		
		-- Make radar area from g_Area coordinates, this shows up on the minimap
		gameAreaCol = createRadarArea ( x - w/2, y - h/2, w, h, 0, 255, 0, 0)
		radarArea1 = createRadarArea ( -3000, y + h/2, 6000, 3000 - y - h/2, 255, 164, 0, 150)
		radarArea2 = createRadarArea ( -3000, -3000, 6000, 3000 + y - h/2, 255, 164, 0, 150)
		radarArea3 = createRadarArea ( -3000, y - h/2, 3000+x-w/2, h, 255, 164, 0, 150)
		radarArea4 = createRadarArea ( x+w/2, y - h/2, 3000-x-w/2, h, 255, 164, 0, 150)

	else

		-- update positions
		setElementPosition(gameAreaCol, x - w/2, y - h/2, false)
		setElementPosition(radarArea1,  -3000,   y + h/2, false)
		setElementPosition(radarArea2,  -3000,   -3000  , false)
		setElementPosition(radarArea3,  -3000,   y - h/2, false)
		setElementPosition(radarArea4,  x+w/2,   y - h/2, false)

		setRadarAreaSize (gameAreaCol, w,              h)
		setRadarAreaSize (radarArea1,  6000,           3000 - y - h/2)
		setRadarAreaSize (radarArea2,  6000,           3000 + y - h/2)
		setRadarAreaSize (radarArea3,  3000 + x - w/2, h)
		setRadarAreaSize (radarArea4,  3000 - x - w/2, h)

	end

	-- send the new limits to the client to draw the orrange barrier
	--triggerClientEvent('updateZoneLimits', resourceRoot, g_Area)

end

-- Honk Healing
g_Timers1 = {}
g_Timers2 = {}
g_marker = {}
function honkHealing(keyPresser, key, state)

	if state == "down" then
		g_marker[keyPresser] = createBlipAttachedTo(keyPresser,0,4,255,0,0,255,32767,65000)

		g_Timers1[keyPresser] = setTimer(function()

				g_Timers2[keyPresser] = setTimer(function()

					v = getPedOccupiedVehicle(keyPresser)
					if v then
						local h = getElementHealth(v)
						local vx,vy,vz = getElementVelocity(v)
						local x,y,z = getElementPosition(v)
						local speed = (vx^2 + vy^2 + vz^2)^(0.5)

						if (h < 1000) and (speed < 0.01) and (isInsideRadarArea ( gameAreaCol, x, y )) then
							setElementHealth(v, h + 10)
						else
							killTimer(g_Timers2[keyPresser])
							g_Timers2[keyPresser] = nil
							setControlState (keyPresser, "horn", false )
						end
					end
				end,100,0)

		end,2000,1)

	end

	if state == "up" then
		--outputChatBox('HONK up', keyPresser)
		destroyElement(g_marker[keyPresser])

		if isTimer(g_Timers1[keyPresser]) then
			killTimer(g_Timers1[keyPresser])
			g_Timers1[keyPresser] = nil
		end

		if isTimer(g_Timers2[keyPresser]) then
			killTimer(g_Timers2[keyPresser])
			g_Timers2[keyPresser] = nil
		end
	end
	
end

-- stop healing if you fire
addEventHandler ("onPlayerWeaponFire", root, 
   function (weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
       	if isTimer(g_Timers1[source]) then
			killTimer(g_Timers1[source])
			g_Timers1[source] = nil
		end

		if isTimer(g_Timers2[source]) then
			killTimer(g_Timers2[source])
			g_Timers2[source] = nil
		end
   end
)

-- Drop items on death
function player_Wasted ( v )
	-- outputChatBox ( getPlayerName ( source ).." died.")

	if not v then 
		return
	end

	-- Vehicle properties
	local model = getElementModel(v)
	local x,y,z = getElementPosition(v)
	local vx,vy,vz = getElementVelocity(v)
	local rvx,rvy,rvz = getElementAngularVelocity(v)
	local h = getElementHealth


	-- Create dummy vehicle
	local rx,ry,rz = getElementRotation(v)
	local dummyV = createVehicle(model,x,y,z,rx,ry,rz)

	--Disable collision on real vehicle, enable on dummy
	setElementData(v,'race.collideothers',0)
	
	-- hide player and vehicle
	setElementAlpha ( v, 0)
	setElementAlpha ( source, 0)

	setElementData(dummyV,'race.collideothers',1)

	-- Create dummy ped
	local m = getElementModel(source)
	local dummyP = createPed(m,x,y,z+20,0,true)
	warpPedIntoVehicle(dummyP,dummyV)
	-- Set the same velocity on the dummyV
	setElementVelocity(dummyV,vx,vy,vz)
	setElementAngularVelocity(dummyV,rvx,rvy,rvz)

	-- Set the dummy vehicle at low health so it will explode
	-- This takes about 5500 ms
	setElementHealth(dummyV,200)

	-- Get weapon ID of occupant for creating spawn
	local w = getPedWeapon(source)
	
	-- When the dummy vehicle blows up, it should spawn the weapons there.
	setTimer(function()
		
		--Kill the dummy ped in the vehicle
		killPed(dummyP)

		-- Get position
		local x,y,z = getElementPosition(dummyV)
		
		-- create vehicle pickup
		local pickup = createPickup(x+math.random(-5,5),y+math.random(-5,5),z,3, 2223) --2223 is the vehicle change model from the race gamemode
		changeTo[pickup] = model

		-- create weapon pickup
		if w > 0 then --ped has weapon
			local pickup = createPickup(x+math.random(-5,5),y+math.random(-5,5),z,2, w)
		end

    end,5000,1)

end
addEvent("onPlayerRaceWasted")
addEventHandler ( "onPlayerRaceWasted", getRootElement(), player_Wasted )

-- Kill player the moment they have 250 health (at 250 health you are on fire and will explode)
function displayVehicleLoss(loss)
    local thePlayer = getVehicleOccupant(source)
    local h = getElementHealth(source) - loss
    if(thePlayer) then -- Check there is a player in the vehicle
	    if getElementType(thePlayer) == "player" and not isPedDead(thePlayer) then
	    	if h < 250 then
	    		killPed(thePlayer)
	    	end
	    end
    end

    setVehicleWheelStates ( source, 0, 0, 0, 0)
end
addEventHandler("onVehicleDamage", root, displayVehicleLoss)


---------------------------------------------------------------------
-- Weapon pickup events
---------------------------------------------------------------------
-- driveby weapons:
-- add extra entries to make it more common
Weapons = {
22,22,22,22,22,22,22,22,22,22,22, --colt 45
23,23,23,23,23,23, --silenced
24,24,24,24,24,24, --deagle
25,25,25,25, --shotgun
26,26,26,26,26,26, --sawed-off
27,27,27, --combatshotgun
28,28,28,28, --uzi
29,29,29,29, --mp5
30,30,30,30,30,30,30, --ak
31,31,31, --m5
32,32,32,32, --tec9
33,33,33,33,  --rifle
38} --minigun


function randomizePickups()

	--Loop through pickups
	for i,p in ipairs (getElementsByType("pickup")) do
		
		local pickupType = getPickupType ( p ) 
	
		if (pickupType == 2) then --weapon
			local weapon = getPickupWeapon ( p )

			--Change fire extinguisher to random weapon
			if weapon == 42 then
				--TODO: skew RNG to make good weapons rare
				setPickupType(p,2, Weapons[math.random(1,#Weapons)])
			end
		end

	end
end

function onPickupHitGive ( thePlayer )
	
	-- Do not trigger for dead players, as pickups are spawned on death.
	-- We dont want players to be able to collect pickups during the death animation
	if isPedDead(thePlayer) then
		return
	end

	local pickupType = getPickupType ( source ) 
	
	if (pickupType == 2) then 
		
		--Give hit weapon (or random weapon for flowers)
		local weapon = getPickupWeapon ( source )     
		if weapon == 14 then --give random weapon for flowers
			local w = Weapons[math.random(1,#Weapons)]
			giveWeapon (thePlayer, w, 9999, true)
			outputChatBox('You have obtained the ' .. getWeaponNameFromID(w) .. '!', thePlayer, 255,0,0)
		else
			giveWeapon (thePlayer, weapon, 9999, true)
		end

		--usePickup(source, thePlayer) --use pickup to remove it from the map
		destroyElement(source) --destory pickup so it doesn't respawn
		setPedDoingGangDriveby (thePlayer, true)

	end


	if (pickupType == 3) then

		local v = getPedOccupiedVehicle(thePlayer)

		if not v then 
			return 
		end

		alignVehicleWithUp(v)

		setElementModel(v, changeTo[source])
		local x,y,z = getElementPosition(v)
		setElementPosition(v,x,y,z+1)
		changeTo[source] = nil
		destroyElement(source, thePlayer)
	end

end
addEventHandler ( "onPickupHit", getRootElement(), onPickupHitGive ) -- add an event handler for onPickupHit

-- Keep driveby toggled on vehicle change
function keepDrivebyOnModelChange(oldModel, newModel)
    if ( getElementType(source) == "vehicle" ) then -- Make sure the element is a player
        
        local ped = getVehicleOccupant(source)
        if ped then
        	if isPedDoingGangDriveby(ped) then
        		setPedDoingGangDriveby(ped,false)
        		setPedDoingGangDriveby(ped,true)
        	end
        end
 	end
end
addEventHandler("onElementModelChange", root, keepDrivebyOnModelChange)

-- Enables / disables gang driveby with vehicle_secondary_fire key
function toggleDriveBy(keyPresser, key, state)
	onoff = not isPedDoingGangDriveby(keyPresser)
	setPedDoingGangDriveby(keyPresser, onoff)
end



------------------------------
-- Vehicle pickups
------------------------------

function directionToRotation2D( x, y )
	return rem( math.atan2( y, x ) * (360/6.28) - 90, 360 )
end

function rem( a, b )
	local result = a - b * math.floor( a / b )
	if result >= b then
		result = result - b
	end
	return result
end

function alignVehicleWithUp(vehicle)

	if not vehicle then return end

	local matrix = getElementMatrix( vehicle )

	local Fwd	= { x = matrix[2][1], y = matrix[2][2], z = matrix[2][3]  }
	local Up	= { x = matrix[3][1], y = matrix[3][2], z = matrix[3][3]  }

	local vx,vy,vz = getElementVelocity( vehicle ) 
	local rz

	if (vx^2 + vy^2 + vz^2)^(0.5) > 0.05 and Up.z < 0.001 then
		-- If velocity is valid, and we are upside down, use it to determine rotation
		rz = directionToRotation2D( vx, vy )
	else
		-- Otherwise use facing direction to determine rotation
		rz = directionToRotation2D( Fwd.x, Fwd.y )
	end

	setElementRotation( vehicle, 0, 0, rz )
end