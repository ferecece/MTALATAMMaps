
function start(newstate,oldstate) --function to update the race states
	
	if (newstate == "GridCountdown") then
		height = 21
		SizeVal = 3000
		-- Defining variables.
		southWest_X = -SizeVal
		southWest_Y = -SizeVal
		southEast_X = SizeVal
		southEast_Y = -SizeVal
		northWest_X = -SizeVal
		northWest_Y = SizeVal
		northEast_X = SizeVal
		northEast_Y = SizeVal
			
		water = createWater ( southWest_X, southWest_Y, height, southEast_X, southEast_Y, height, northWest_X, northWest_Y, height, northEast_X, northEast_Y, height )
		setWaterLevel ( height )
		setWaterColor(255,0,0)

		local x,y,z = getElementPosition(getElementByID("startTile"))
		
		for i=0,630 do
			local gap1 = math.random(0,4+math.floor(7-7*math.min((i/500),1))) --any number above 4 will result in a tile not being placed
			--so I add a number that decreases with increasing path, and thereby ramping up the difficulty
			
			local y1 = y-i*9
			createObject(3534,x-4.5,y1,z+1.9)
			createObject(3534,x+40.5,y1,z+1.9)
				
			for j=0,4 do
				local x1 = x+j*9
				
				if (j ~= gap1)  then
					createObject(3095,x1,y1,z)
				else
					if math.random(0,20) ==0 then
						createObject(1655,x1,y1-0.3,z+1.6,0,0,180)
						createMarker(x1,y1-90,z+11,"arrow",5,0,255,0,255)
						
						for h=3,10 do
							createObject(3095,x1,y1-h*9,z+5)
							createObject(3534,x1-4.5,y1-h*9,z+6.9)
							createObject(3534,x1+4.5,y1-h*9,z+6.9)
						end
						
					elseif math.random(0,4) == 0 then
						local o =  createObject(3528,x1,y1,z+3.3,0,0,90)
						setElementCollisionsEnabled(o,false)
					end
				end
			end
		end
		
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function markerHit(hitEl)
	if (getElementType(hitEl) == "vehicle") and (getMarkerType(source) == "arrow") then
		setElementHealth(hitEl,1000)
		
		local ped = getVehicleOccupant(hitEl)
		if ped then
			if getElementType(ped) == "player" then
				playSoundFrontEnd(ped,46)
			end
		end
	end
end
addEventHandler("onMarkerHit",root,markerHit)

 
function enterVehicle ( thePlayer, seat, jacked ) -- when a player enters a vehicle
    local o = createObject(3528,0,0,0)
	setElementCollisionsEnabled(o,false)
	
	--setObjectScale(o,0.9)
	attachElements(o,source,0.3,0.2,-0.1,0,-50,90)
	setVehicleColor(source,255,100,0,255,100,0)
	local veh = source
	setTimer(function()
		setElementAlpha(veh,50)
	end,500,1)
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle ) -- add an event hand


function player_Spawn ( posX, posY, posZ, spawnRotation, theTeam, theSkin, theInterior, theDimension )
	local p = source
	setTimer(function()
		local veh = getPedOccupiedVehicle(p)
		if veh then
			setElementAlpha(veh,50)
			setVehicleColor(veh,255,100,0,255,100,0)
		end
	end,2000,1)
end
-- add the player_Spawn function as a handler for onPlayerSpawn
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )


