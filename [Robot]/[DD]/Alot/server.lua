-- Flying derby made by Ali Digitali
-- anyone reading this has permission to copy/modify this script, as long as credit is given

-------- VEHICLES
vehicles = {400,402,403,404,405,409,410,411,412,413,414,415,416,418,419,420,422,423,424,426,427,428,
			429,431,436,439,440,441,442,443,444,445,451,455,456,457,458,459,461,462,463,466,467,468,
			471,474,475,477,478,479,480,481,482,483,489,490,491,492,495,498,499,500,502,504,505,506,
			507,508,509,510,514,515,516,517,518,521,522,526,527,529,530,531,533,534,535,536,539,540,
			541,542,543,544,545,546,547,549,550,551,552,554,555,558,559,560,561,562,565,566,567,571,
			572,573,574,575,576,578,579,580,581,582,583,585,586,587,588,589,596,597,598,599,600,602,
			603,488,513,592,511,425,520,447,406} -- allowed vehicles you can change to
			
opVehicles = {520,425,592,406,464,447,432}

-- When the player enters the vehicle at the start of the game it is painted green --
function vehicleEnter ( theVehicle, seat, jacked )
		setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(),vehicleEnter)
----------


-------- BOUNDARIES 			
for i=0,1,1/40 do -- creating fancy lights at the edge of the arena
	local x = 255*math.cos(math.rad(i*360)) - 2230
	local y = 255*math.sin(math.rad(i*360)) + 1819
	for j=0,10,1 do 
		local a = math.random(0,255)
		local b = math.random(0,255)
		local c = math.random(0,255)
		createMarker(x,y,j*20,"corona",20,a,b,c)
	end
end

-- actual boundaries and handlers are created when the map is running
function leftZone ( hitElement, matchingDimension ) -- if a player hits the edge, they will be bounced back
	if getElementType ( hitElement ) == "vehicle" then
		local x,y,z = getElementVelocity(hitElement)
		local rotx,roty,rotz = getElementRotation(hitElement)
		setElementVelocity(hitElement,-x,-y,-z)
		setElementRotation(hitElement,-rotx,-roty,rotz-180)
		--outputChatBox("vehicle has left the zone2")
    end
end

function leftZoneDestroy ( hitElement, matchingDimension ) -- if a player somehow gets past the edge, they will be blown up
	if getElementType ( hitElement ) == "vehicle" then
		blowVehicle(hitElement)
    end
end


--------------------------------

-------- MARKERS
function createRandomMarker(colorr,colorg,colorb,scale)
	local z = math.random(5,190)
	if (z<94) then -- prevent marker spawns to be inside the central tower
		rmin = 20
	else
		rmin = 0
	end
	local r = (250-rmin)*math.random() + rmin
	local theta = math.random()*2*math.pi
	local x = r*math.cos(theta) - 2230
	local y = r*math.sin(theta) + 1819

	theMarker = createMarker(x,y,z,"ring",scale,colorr,colorg,colorb)
	theMarkerBlip = createBlipAttachedTo(theMarker,0,2,colorr,colorg,colorb)
end
createRandomMarker(0,0,255,20) -- create blue ring
createRandomMarker(255,0,0,10) -- create red ring
createRandomMarker(0,255,0,5) -- create green ring
createRandomMarker(255,0,255,15) -- create purple ring
createRandomMarker(255,255,0,10) -- create yellow ring
createRandomMarker(0,255,255,2) -- create cyan ring
createRandomMarker(255,255,255,10) -- create white ring
	
redTimer = {}
function changeVehicle ( hitElement, matchingDimension )
	if (getElementType ( hitElement ) == "vehicle") and (getMarkerType(source) == "ring") then -- if the player hits a ring
		local color1,color2,color3,alpha = getMarkerColor(source)
		triggerClientEvent(getVehicleOccupant(hitElement),"markerHit",getVehicleOccupant(hitElement),color1,color2,color3)
		
		playSoundFrontEnd ( getVehicleOccupant(hitElement), 1 ) -- play a checkpoint hit sound
		
		if (color1 == 0) and (color2 == 0) and (color3 == 255) then -- if it's a blue ring, change the car to a different one
			local newcar = (vehicles[math.random(#vehicles)]) -- generates a random car from entered ID's
			setElementModel(hitElement,newcar)
			createRandomMarker(0,0,255,20)
		end
		
		if (color1 == 255) and (color2 == 0) and (color3 == 0) then -- if it's a red ring, make it so that if other players are hit they fall out of the sky
			createRandomMarker(255,0,0,10)
			setVehicleColor(hitElement, 255, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0) -- paint car red
			setElementData(hitElement,"redRing",true,true)
			
			if (isTimer(redTimer[hitElement])) then  -- if a timer is already running for a vehicle, reset it
				resetTimer(redTimer[hitElement])
			else
				redTimer[hitElement] = setTimer(function()  -- if a timer is not running, set a new one
											setVehicleColor(hitElement, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paint car green
											setElementData(hitElement,"redRing",false,true)
									   end,25000,1)
			end
		end
		
		if (color1 == 0) and (color2 == 255) and (color3 == 0) then -- if it's a green ring, the vehicle is fixed
			createRandomMarker(0,255,0,5)
			fixVehicle(hitElement)
			playSoundFrontEnd ( getVehicleOccupant(hitElement), 46 ) -- play the repair sound
		end
		
		if (color1 == 255) and (color2 == 255) and (color3 == 0) then -- yellow ring (clientside)
			createRandomMarker(255,255,0,10)
		end
		
		if (color1 == 0) and (color2 == 255) and (color3 == 255) then -- cyan ring
			local newcar = (opVehicles[math.random(#opVehicles)]) -- generates a random car from entered ID's
			setElementModel(hitElement,newcar)
			createRandomMarker(0,255,255,2)
		end
		
		if (color1 == 255) and (color2 == 255) and (color3 == 255) then -- white ring (clientside)
			createRandomMarker(255,255,255,10)
		end

		if (color1 == 255) and (color2 == 0) and (color3 == 255) then  -- if it's purple, wait ten seconds and then destroy. If the marker is not purple, destroy right away
			if not (isTimer(purpleTimer)) then
				local theMarker = source
				purpleTimer = setTimer(function()
					removeMarker(theMarker)
					createRandomMarker(255,0,255,15)
				end,10000,1)
			end
		else
			removeMarker(source)
		end
	end
end
addEventHandler ( "onMarkerHit", root, changeVehicle )

function removeMarker(marker)
	for key, theElement in ipairs (getAttachedElements(marker)) do -- destroy the blip attached to the marker
		if (getElementType(theElement) == "blip") then
			destroyElement(theElement)
		end
	end
	destroyElement(marker) -- destroy marker
end
--------------------

------ ANTICAMP + border creation
function start(newstate,oldstate)
	if (newstate == "Running" and oldstate == "GridCountdown") then
		triggerClientEvent("antiCamp",getRootElement())
		containmentZone = createColCircle ( -2230, 1819, 250 )
		addEventHandler ( "onColShapeLeave", containmentZone, leftZone )
		containmentZone2 = createColCircle ( -2230, 1819, 270 )
		addEventHandler ( "onColShapeLeave", containmentZone2, leftZoneDestroy )
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )