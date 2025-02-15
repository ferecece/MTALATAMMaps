--Kappa Catapults

-- function that creates all the objects at the start and adds the handlers
function createobjects()
-- Handler for the vehicle damage function
addEventHandler("onVehicleDamage", getResourceRootElement(getThisResource()), vehicleDamage)
createRandomMarker()
--CATAPULT AND MARKER CREATION
-- eastern catapults
catapult1 = createObject(3458,-2220,1962,71) -- makes catapult
catapult1marker = createMarker(-2207,1962,73,"corona") -- makes marker
addEventHandler( "onMarkerHit", catapult1marker, markerTriggers ) --adds event handler for when this marker is hit

catapult2 = createObject(3458,-2220,1929.5,71)
catapult2marker = createMarker(-2207,1929.5,73,"corona")
addEventHandler( "onMarkerHit", catapult2marker, markerTriggers )

catapult3 = createObject(3458,-2220,1897,71)
catapult3marker = createMarker(-2207,1897,73,"corona")
addEventHandler( "onMarkerHit", catapult3marker, markerTriggers )

--western catapults
catapult4 = createObject(3458,-2350,1962,71,0,0,180)
catapult4marker = createMarker(-2363,1962,73,"corona")
addEventHandler( "onMarkerHit", catapult4marker, markerTriggers )

catapult5 = createObject(3458,-2350,1929.5,71,0,0,180)
catapult5marker = createMarker(-2363,1929.5,73,"corona")
addEventHandler( "onMarkerHit", catapult5marker, markerTriggers )

catapult6 = createObject(3458,-2350,1897,71,0,0,180)
catapult6marker = createMarker(-2363,1897,73,"corona")
addEventHandler( "onMarkerHit", catapult6marker, markerTriggers )

--southern catapults
catapult7 = createObject(3458,-2252.5,1864.5,71,0,0,270)
catapult7marker = createMarker(-2252.5,1851.5,73,"corona")
addEventHandler( "onMarkerHit", catapult7marker, markerTriggers )

catapult8 = createObject(3458,-2285,1864.5,71,0,0,270)
catapult8marker = createMarker(-2285,1851.5,73,"corona")
addEventHandler( "onMarkerHit", catapult8marker, markerTriggers )

catapult9 = createObject(3458,-2317.5,1864.5,71,0,0,270)
catapult9marker = createMarker(-2317.5,1851.5,73,"corona")
addEventHandler( "onMarkerHit", catapult9marker, markerTriggers )

-- northern catapults
catapult10 = createObject(3458,-2252.5,1994.5,71,0,0,90)
catapult10marker = createMarker(-2252.5,2007.5,73,"corona")
addEventHandler( "onMarkerHit", catapult10marker, markerTriggers )

catapult11 = createObject(3458,-2285,1994.5,71,0,0,90)
catapult11marker = createMarker(-2285,2007.5,73,"corona")
addEventHandler( "onMarkerHit", catapult11marker, markerTriggers )

catapult12 = createObject(3458,-2317.5,1994.5,71,0,0,90)
catapult12marker = createMarker(-2317.5,2007.5,73,"corona")
addEventHandler( "onMarkerHit", catapult12marker, markerTriggers )

packerbridge = createObject(7191,-2429.5,2069.1000976563,72.400001525879,0,270,226.74975585938)
bridgemarker = createMarker(-2431.6000976563,2055.6999511719,80.699996948242,"arrow",3)
addEventHandler( "onMarkerHit", bridgemarker, moveBridge )

for index,marker in ipairs (getElementsByType("marker")) do 
	if getMarkerType(marker) == "corona" then
	setMarkerColor(marker,0,255,0,255)
	end
end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createobjects)

function moveBridge(playerCar,matchingDimension)
	if getElementType(playerCar) == "vehicle" and matchingDimension then
	
	setElementDimension ( bridgemarker, 1 )
	moveObject(packerbridge,5000,-2429.5,2069.1000976563,76.400001525879)

		setTimer ( function()
					moveObject(packerbridge,5000,-2429.5,2069.1000976563,72.400001525879)
		end, 10000, 1 )

		setTimer ( function()
					setElementDimension ( bridgemarker, 0 )
		end, 15000, 1 )
	end
end


vehicles = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585,
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 488, 511, 497, 563, 512, 476, 593, 447, 425, 519, 520, 
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458 
}

function createRandomMarker()

if randomMarkerID == 1 then
		randommarker = createMarker(-2317.5,1962,73,"checkpoint",5)
	elseif randomMarkerID == 2 then
		randommarker = createMarker(-2285,1929.5,73,"checkpoint",5)
	elseif randomMarkerID == 3 then
		randommarker = createMarker(-2252.5,1897,73,"checkpoint",5)
	elseif randomMarkerID == 4 then
		randommarker = createMarker(-2317.5,1929.5,73,"checkpoint",5)
	elseif randomMarkerID == 5 then
		randommarker = createMarker(-2285,1962,73,"checkpoint",5)
	elseif randomMarkerID == 6 then
		randommarker = createMarker(-2252.5,1929.5,73,"checkpoint",5)
	elseif randomMarkerID == 7 then
		randommarker = createMarker(-2317.5,1897,73,"checkpoint",5)
	elseif randomMarkerID == 8 then
		randommarker = createMarker(-2252.5,1962,73,"checkpoint",5)
	elseif randomMarkerID == 9 then
		randommarker = createMarker(-2285,1897,73,"checkpoint",5)		
	else
		randomMarkerID = 1
		createRandomMarker()
end
destroyElement(randommarkerblip)
randommarkerblip = createBlipAttachedTo(randommarker,0,2,0,0,255)

end

function randomMarkerHit( playerCar )
	if getElementType(playerCar) == "vehicle" and getMarkerType(source) == "checkpoint" then
		local newCarID = (vehicles[math.random(#vehicles)])
		fixVehicle(playerCar)
		setElementModel(playerCar, newCarID)
		destroyElement(source)
		randomMarkerID = randomMarkerID + 1
		createRandomMarker()
	end
end
addEventHandler("onMarkerHit",getRootElement(),randomMarkerHit)

-- function that shoots the corresponding catapult when a marker is hit
function markerTriggers(playerCar,matchingDimension)
if getElementType(playerCar ) == "vehicle" and matchingDimension then --if the element that hit the marker is a vehicle and their dimensions match,
	if this == catapult1marker then -- checks to see what marker was hit
	shootCatapult(playerCar,catapult1marker,catapult1) -- if marker one was hit, catapult one shot with the function shootCatapult
	elseif this == catapult2marker then
	shootCatapult(playerCar,catapult2marker,catapult2)
	elseif this == catapult3marker then
	shootCatapult(playerCar,catapult3marker,catapult3)
	elseif this == catapult4marker then
	shootCatapult(playerCar,catapult4marker,catapult4)
	elseif this == catapult5marker then
	shootCatapult(playerCar,catapult5marker,catapult5)
	elseif this == catapult6marker then
	shootCatapult(playerCar,catapult6marker,catapult6)
	elseif this == catapult7marker then
	shootCatapult(playerCar,catapult7marker,catapult7)
	elseif this == catapult8marker then
	shootCatapult(playerCar,catapult8marker,catapult8)
	elseif this == catapult9marker then
	shootCatapult(playerCar,catapult9marker,catapult9)
	elseif this == catapult10marker then
	shootCatapult(playerCar,catapult10marker,catapult10)
	elseif this == catapult11marker then
	shootCatapult(playerCar,catapult11marker,catapult11)
	elseif this == catapult12marker then
	shootCatapult(playerCar,catapult12marker,catapult12)
	end
end
end

-- function that shoots the catapult
function shootCatapult(playerCar,markerID,catapultID)

	setElementDimension ( markerID, 1 ) -- the marker changes dimension and dissapears
	
	-- offset calculation for the attachment of the car and catapult
	local x, y, z = getElementPosition(playerCar) 
	local rotx,roty,rotz = getElementRotation(playerCar)
	local a, b, c = getElementPosition(catapultID)
	local rota,rotb,rotc = getElementRotation(catapultID)
	local offsetx = x - a
	local offsety = y - b
	local offsetz = z - c
	local offsetRotZ = rotz - rotc
	offsetx, offsety, offsetz = applyInverseRotation ( offsetx, offsety, offsetz, rota, rotb, rotc ) -- executes inverse rotation function
	attachElements(playerCar,catapultID,offsetx,offsety,offsetz,0,0,offsetRotZ) -- attaches car to the catapult
	
	moveObject(catapultID, 600,a,b,c,0,-60,0,"InBack",0,0,2) -- rotate the catapult to make it appear to fire
	--setElementVelocity(playerCar,-0.7,0,1.1)
	
	-- timer to detach the car from the catapult after is has rotated
	setTimer ( function()
		local x, y, z = getElementPosition(playerCar) -- get player location
		detachElements(playerCar) -- detach car and catapult
		setElementPosition(playerCar,x,y,2*c-z) -- set car location back to before detachment
		
		-- velocity calculation after detachment --
		local DEG2RAD = (math.pi * 2) / 360 -- degrees to radians
		rotv = rotc * DEG2RAD -- get the rotation of the catapult (z rotation, to distinguish between north, east, south, west catapults
		velx = math.cos (rotv) * -0.7 -- sets the x and y velocity according to the catapult rotation so that the player gets shot in the right direction
		vely = math.sin (rotv) * -0.7
		setElementVelocity(playerCar,velx,vely,1.2)
		setElementData ( playerCar, "justFiredByCatapult", true ) -- sets the data of the player to just being shot. This is needed in the vehicle damage function.
		setVehicleDamageProof(playerCar,true)
		local h = getElementHealth(playerCar)
		if h < 800 then
			setElementHealth(playerCar, h+200)
		elseif h < 1000 then
			setElementHealth(playerCar, 1000)
		end
		setTimer ( function()
			setVehicleDamageProof(playerCar,false)
		end, 5000, 1 )
		
	end, 600, 1 )
			
	setTimer ( function()
		moveObject(catapultID, 5000,a,b,c,0,60)	-- moves the catapult back after being fired					
	end, 3000, 1 )
	
	setTimer ( function()
		setElementDimension ( markerID, 0 ) -- sets the dimension of the marker back to 0, so that it can be hit again.
	end, 8050, 1 )
end


-- function to compensate for offets on attaching, see: https://wiki.multitheftauto.com/wiki/AttachElementsOffsets
function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD
 
    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z
 
    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z
 
    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y
 
    return x, y, z
end


-- function to prevent damage to the vehicle if it was just fired by a catapult
function vehicleDamage(loss)

	if getElementData(source, "justFiredByCatapult" ) then
	setElementHealth(source, getElementHealth(source))
	--outputChatBox("health restored")
	setElementData ( source, "justFiredByCatapult", false )					
	end
end
addEventHandler("onVehicleDamage",  getRootElement(), vehicleDamage)

