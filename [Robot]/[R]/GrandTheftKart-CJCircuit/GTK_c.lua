local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the clients screenWidth and Height

local hasWeapon = false

local currentWeapon = 0

local ammo = 1

local starPower = false

local cyclingweapons = false

local displayMessage = false

local currentMessage = "Kappa"

local displayTimer

 -- Logic
function shootPrimary()
    --outputChatBox(getElementData(getLocalPlayer(), "race.checkpoint"))
	if hasWeapon then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		
		if currentWeapon == 1 then -- Rocket
			local posX, posY, posZ = getElementPosition(vehicle)
			createProjectile(vehicle, 19, posX, posY, posZ + 0.25, 0.5)
			
			if ammo > 1 then -- More than one rocket remaining
				ammo = ammo - 1
			else
				hasWeapon = false
				currentWeapon = 0
			end
		elseif currentWeapon == 2 then -- Homing Rocket
			triggerServerEvent( "getHomingTarget", getLocalPlayer(), getLocalPlayer())
		elseif currentWeapon == 3 then -- Grenade
			local posX, posY, posZ = getElementPosition(vehicle)
			createProjectile(vehicle, 16, posX, posY, posZ, 0.25)
			
			if ammo > 1 then -- More than one rocket remaining
				ammo = ammo - 1
			else
				hasWeapon = false
				currentWeapon = 0
			end
		elseif currentWeapon == 4 then -- Chainsaw		
			triggerServerEvent( "starColours", getLocalPlayer(), vehicle, 20)
			addVehicleUpgrade (vehicle, 1010)
			
			--setVehicleNitroActivated(vehicle, true)
			hasWeapon = false
			currentWeapon = 0
			starPower = true
			setVehicleDamageProof(vehicle, true)
			fixVehicle(vehicle)
			displayTimer = setTimer(RemoveMessage, 5000, 1)
			displayMessage = true
			currentMessage = "Hit people to make them explode while your flashing!"
			setTimer(function()
				starPower = false
				setVehicleDamageProof(vehicle, false)
				triggerServerEvent( "resetColour", getLocalPlayer(), vehicle)
			end, 20200, 1)
		elseif currentWeapon == 5 then -- Molotov
			local posX, posY, posZ = getElementPosition(vehicle)
			local rotX, rotY, rotZ = getElementRotation(vehicle)
			
			setElementRotation(vehicle,rotX,rotY,rotZ+180) -- Rotate player 180
			
			createProjectile(vehicle, 18, posX, posY, posZ, 0.75)
			
			setElementRotation(vehicle,rotX,rotY,rotZ) -- Put player back to their original rotation
			
			if ammo > 1 then -- More than one rocket remaining
				ammo = ammo - 1
			else
				hasWeapon = false
				currentWeapon = 0
			end
		elseif currentWeapon == 6 then -- Katana
			triggerServerEvent( "popAllTires", getLocalPlayer(), getLocalPlayer())
			hasWeapon = false
			currentWeapon = 0
			
			displayTimer = setTimer(RemoveMessage, 5000, 1)
			displayMessage = true
			currentMessage = "You popped everyone in front of you's tires!"
		elseif currentWeapon == 7 then -- Knife
			triggerServerEvent( "popTargetTires", getLocalPlayer(), getLocalPlayer())
			hasWeapon = false
			currentWeapon = 0
		elseif currentWeapon == 8 then -- Dildo
			triggerServerEvent( "changePlaces", getLocalPlayer(), getLocalPlayer())
			hasWeapon = false
			currentWeapon = 0
		elseif currentWeapon == 98 then -- UltraChainsaw
			addVehicleUpgrade (vehicle, 1010)
			starPower = true
			setVehicleDamageProof(vehicle, true)
			fixVehicle(vehicle)
		elseif currentWeapon == 99 then -- Cellphone
			hasWeapon = false
			currentWeapon = 0
			triggerServerEvent( "setStormWeather", getLocalPlayer(), getLocalPlayer())
		end	
    end
end
bindKey("vehicle_fire", "down", shootPrimary)

addEvent( "setHomingTarget", true )

function setHomingTarget(target) 
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
	local posX, posY, posZ = getElementPosition(vehicle)
	createProjectile(vehicle, 20, posX, posY, posZ + 2.5, 1, getPedOccupiedVehicle(target))
	if ammo > 1 then -- More than one rocket remaining
		ammo = ammo - 1
	else
		hasWeapon = false
		currentWeapon = 0
	end
	
	
	if target ~= nil then
		displayTimer = setTimer(RemoveMessage, 5000, 1)
		displayMessage = true
		currentMessage = "Rocket targeted"..getPlayerName(target)
	end
end
addEventHandler("setHomingTarget", root, setHomingTarget)

addEvent( "popTires", true )
function popTires() 
	setVehicleWheelStates(getPedOccupiedVehicle(getLocalPlayer()), 1, 1, 1, 1)
	setTimer(function()
		setVehicleWheelStates(getPedOccupiedVehicle(getLocalPlayer()), 0, 0, 0, 0)
	end, 5000, 1)
end
addEventHandler("popTires", root, popTires)

addEvent( "setFlower", true )
function setFlower(playerThatTriggered) 
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
	if getLocalPlayer() == playerThatTriggered then
		currentWeapon = 98
		hasWeapon = true
		addVehicleUpgrade (vehicle, 1010)
		starPower = true
		setVehicleDamageProof(vehicle, true)
		fixVehicle(vehicle)
		triggerServerEvent( "starColours", getLocalPlayer(), vehicle, 45)
		
		setTimer(function()
			vehicle = getPedOccupiedVehicle(getLocalPlayer())
			hasWeapon = false
			starPower = false
			setVehicleDamageProof(vehicle, false)
			triggerServerEvent( "resetColour", getLocalPlayer(), vehicle)
			currentWeapon = 0
			ammo = 1
			setTimer(function()
				triggerServerEvent( "resetColour", getLocalPlayer(), vehicle)
			end, 200, 1)
		end, 45000, 1)
	else
		starPower = false
		triggerServerEvent( "resetColour", getLocalPlayer(), vehicle)
		currentWeapon = 100
		hasWeapon = true
		popTires()
		setTimer(function()
			vehicle = getPedOccupiedVehicle(getLocalPlayer())
			hasWeapon = false
			currentWeapon = 0
			ammo = 1
		end, 45000, 1)
	end
end
addEventHandler("setFlower", root, setFlower)

addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), function()
	hasWeapon = false
	currentWeapon = 0
	ammo = 1
end
)

addEventHandler("onClientVehicleCollision", getRootElement(),function(theHitElement)
	if starPower then
		if theHitElement == getPedOccupiedVehicle(getLocalPlayer()) then
			-- We blow the vehicle server side, because doing it client side is apparently broken 
			triggerServerEvent( "triggerVehicleBlow", getLocalPlayer(), source, getLocalPlayer())
			blowVehicle(source)
		end
	end
end
)

addEventHandler("onClientColShapeHit", getRootElement(), function(theElement, matchingDimension) 
	x, y, z = getElementPosition(source)
	if x == -2205 or x == -2180 then
		if theElement == getPedOccupiedVehicle(getLocalPlayer()) then
			if not cyclingweapons and not hasWeapon then
				cycleWeapons(15)
			end
		end
	end
end 
)

addEventHandler ( "onClientResourceStart", resourceRoot,  function()
	createColCircle(-2205, 1921, 10)
	createColCircle(-2180, 1747, 10)
	--setDevelopmentMode(true)
end
)

function cycleWeapons(timesToCycle)
	cyclingweapons = true
	currentWeapon = math.random(5)
	
	if timesToCycle < 1 then

		-- If the player is in the top 20%
		if  getElementData(getLocalPlayer(),"race rank") / #getElementsByType("player") < 0.2 then
			rng = math.random(2) -- Get either Grenades or Moltovs
			if rng == 1 then
				currentWeapon = 3
				ammo = math.random(3)
			else
				currentWeapon = 5
				ammo = math.random(3)
			end
		elseif getElementData(getLocalPlayer(),"race rank") / #getElementsByType("player") == 1 then
			rng = math.random(30)
			if rng < 21 and starPower == false then
				currentWeapon = 4
			elseif rng < 30 then
				currentWeapon = 7
			--elseif rng < 37 then
				--currentWeapon = 8
			else
				currentWeapon = 99
			end		
		elseif getElementData(getLocalPlayer(),"race rank") / #getElementsByType("player") > 0.8 then
			rng = math.random(5) -- Get either Knives, Chainsaws or Katanas
			if rng < 3 and starPower == false then
				currentWeapon = 4
			--elseif rng < 5 then
				--currentWeapon = 8
			elseif rng == 3 then
				currentWeapon = 6
			else
				currentWeapon = 7
			end
		else
			currentWeapon = math.random(8)

			if currentWeapon == 1 or currentWeapon == 3 or currentWeapon == 5 then
				-- Give random ammo level
				ammo = math.random(3)
			elseif currentWeapon == 6 then
				-- Switch Katana for Knife
				currentWeapon = 7
			end

		end
		hasWeapon = true
		cyclingweapons = false
	else
		timesToCycle = timesToCycle - 1
		
		setTimer ( function()
		cycleWeapons(timesToCycle)
		end, 100, 1 )
	end
end

addEvent( "setMessage", true )
function setMessage(message) 
	currentMessage = message
	displayMessage = true
	displayTimer = setTimer(RemoveMessage, 5000, 1)
end
addEventHandler("setMessage", root, setMessage)






 -- Drawing
function drawing()	
	if currentWeapon == 1 then -- Rocket
		if ammo == 3 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'rocket3.png')
		elseif ammo == 2 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'rocket2.png')
		else
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'rocket.png')
		end
	elseif currentWeapon == 2 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'homingrocket.png')
	elseif currentWeapon == 3 then
		if ammo == 3 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'grenade3.png')
		elseif ammo == 2 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'grenade2.png')
		else
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'grenade.png')
		end
	elseif currentWeapon == 4 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'chainsaw.png')
	elseif currentWeapon == 5 then
		if ammo == 3 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'molotov3.png')
		elseif ammo == 2 then
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'molotov2.png')
		else
			dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'molotov.png')
		end
	elseif currentWeapon == 6 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'katana.png')
	elseif currentWeapon == 7 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'knife.png')
	elseif currentWeapon == 8 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'dildo.png')
		
		
	elseif currentWeapon == 98 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'ultra-chainsaw.png')
	elseif currentWeapon == 99 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'cellphone.png')
	elseif currentWeapon == 100 then
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'flowers.png')
	else -- Draw empty box
		dxDrawImage(screenWidth / 2 - 64, screenHeight / 25, 128, 128, 'box.png')
	end
	
	if displayMessage then
		dxDrawRectangle(screenWidth / 2 + 70, screenHeight / 25 + 60, screenWidth / 3, screenWidth / 64, tocolor ( 50, 50, 50, 150 ))
		
		dxDrawText(currentMessage, screenWidth / 2 + 74, screenHeight / 25 + 64, screenWidth, screenHeight, 
			tocolor ( 255, 255, 255, 255 ), screenWidth / 1280, "default-bold")
	end	
end

function RemoveMessage()
	displayMessage = false
end

function HandleTheRendering ( )
    addEventHandler ( "onClientRender", root, drawing ) -- keep the text visible with onClientRender.
end
addEventHandler ( "onClientResourceStart", resourceRoot, HandleTheRendering )