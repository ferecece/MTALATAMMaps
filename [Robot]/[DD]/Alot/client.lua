-- Flying derby made by Ali Digitali
-- anyone reading this has permission to copy/modify this script, as long as credit is given

setWorldSpecialPropertyEnabled ("aircars",true) -- make cars fly
setAircraftMaxHeight(200)
setAircraftMaxVelocity(0.9)
rockets = 0

function fallout(theHitElement) -- when you hit a player that has redRing, you can no longer fly
	if (getElementType(theHitElement) == "vehicle") and (getVehicleOccupant(source) == localPlayer) then
		if (getElementData(theHitElement,"redRing") == true) then
			setWorldSpecialPropertyEnabled ("aircars",false)
			fuel = 0
		end
	end
end
addEventHandler("onClientVehicleCollision", getRootElement(),fallout)

fuel = 100
fuelTimer = setTimer(function()
		if getPedOccupiedVehicle(localPlayer) then
			local speedx, speedy, speedz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
			local actualspeed = math.floor(((speedx^2 + speedy^2 + speedz^2)^(0.5))*180)
			if (actualspeed>5) and (fuel > 0)then
				fuel = fuel - 1
			end
			if (fuel < 1) then
				fuel = 0
				killTimer(fuelTimer)
				setWorldSpecialPropertyEnabled ("aircars",false)
			end
		end
end,1000,0)

function stopCamp()
	setTimer(function()
		if (getPedOccupiedVehicle(localPlayer)) then
			if isVehicleOnGround(getPedOccupiedVehicle(localPlayer)) then
				setPedOnFire(localPlayer,true)
				fuel = 0
				outputChatBox("Your magic fuel caught on fire because you were not flying!",255,0,0)
			end
		end
	end,15000,0)
end
addEvent("antiCamp",true)
addEventHandler ("antiCamp", getRootElement(), stopCamp )

function MarkerHit (color1,color2,color3)
		if (color1 == 255) and (color2 == 0) and (color3 == 255) then -- and the color of the ring is purple
			if (fuel > 80) then -- make sure fuel can't go over 100
				fuel = 80
			end
			if (fuel > 0) then 
				fuel = fuel + 20 -- add fuel
			end
		end
		if (color1 == 255) and (color2 == 255) and (color3 == 0) then
			rockets = 20
		end
		
		if (color1 == 255) and (color2 == 255) and (color3 == 255) then
			setAircraftMaxVelocity(1.5)
			setTimer(function()
				setAircraftMaxVelocity(0.9)
			end,10000,1)
		end
end
addEvent("markerHit",true)
addEventHandler ( "markerHit", getRootElement(), MarkerHit )


function fireRockets(key,keyState)
	if (rockets > 0) then -- 
		createProjectile (getPedOccupiedVehicle(localPlayer),19)
		rockets = rockets - 1
	end
end
bindKey("vehicle_fire", "down",fireRockets)

screenWidth, screenHeight = guiGetScreenSize ( )
function displayFuel()
	if (fuel > 100) then
		green = 250
	else
		green = math.abs(fuel*2.5)
	end
	dxDrawText ("Magic Fuel: " .. fuel .. " %", screenWidth, 50, 0, 0, tocolor (250-green,green, 0, 255 ),3,"default","center")
	----
	dxDrawText ("Green:", 50, screenHeight/2, 0, 0, tocolor (0,255, 0, 255 ),1.5) -- green
	dxDrawText ("Purple:", 50, screenHeight/2-30, 0, 0, tocolor (255,0,255,255),1.5)-- purple
	dxDrawText ("Red:", 50, screenHeight/2-60, 0, 0, tocolor (255,0,0,255),1.5) -- red
	dxDrawText ("Blue:", 50, screenHeight/2-90, 0, 0, tocolor (0,0,255,255),1.5)-- blue
	dxDrawText ("Yellow:", 50, screenHeight/2+30, 0, 0, tocolor (255,255,0,255),1.5) -- yellow
	dxDrawText ("Cyan:", 50, screenHeight/2+60, 0, 0, tocolor (0,255,255,255),1.5)-- cyan
	dxDrawText ("White:", 50, screenHeight/2-120, 0, 0, tocolor (255,255,255,255),1.5)-- white
	----
	dxDrawText ("Repair", 120, screenHeight/2, 0, 0, tocolor (0,255, 0, 255 ),1.5) -- green
	dxDrawText ("Fuel +20", 120, screenHeight/2-30, 0, 0, tocolor (255,0,255,255),1.5)-- purple
	dxDrawText ("Drop Other Cars", 120, screenHeight/2-60, 0, 0, tocolor (255,0,0,255),1.5) -- red
	dxDrawText ("Random Vehicle", 120, screenHeight/2-90, 0, 0, tocolor (0,0,255,255),1.5)-- blue
	dxDrawText ("Rockets", 120, screenHeight/2+30, 0, 0, tocolor (255,255,0,255),1.5) -- yellow
	dxDrawText ("OP Vehicle", 120, screenHeight/2+60, 0, 0, tocolor (0,255,255,255),1.5)-- cyan
	dxDrawText ("Speed x2", 120, screenHeight/2-120, 0, 0, tocolor (255,255,255,255),1.5)-- white	
	
	if (rockets > 0) then
		dxDrawText ("Rockets: " .. rockets, screenWidth, 100, 0, 0, tocolor ( 0,255, 0, 255 ),3,"default","center")
	end
end
addEventHandler("onClientRender",root,displayFuel)