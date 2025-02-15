function start(newstate,oldstate) --function to update the race states
	setElementData(root,"racestate",newstate,true) -- used to synchronise with the client
	
	if (newstate == "GridCountdown") then
		setWeaponProperty(31,"std","damage",15) --reduce the damage of the minigun
		
		--text display for countdown
		countdownDisplay = textCreateDisplay()
		countdownText = textCreateTextItem("Controls:\nQ: Fire Missile\nE: Drop Bomb\nSpace: Turn Around",0.4,0.25,"medium",255,0,0,255,3,"left","center",255)
		textDisplayAddText (countdownDisplay,countdownText)
		for index,thePlayer in ipairs (getElementsByType("player")) do
			textDisplayAddObserver(countdownDisplay,thePlayer)
			toggleControl(thePlayer,"vehicle_secondary_fire",false) --and also remove the minigun
			toggleControl(thePlayer,"vehicle_fire",false) --and also remove the minigun
		end
		createRandomMarker() --create a marker
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		local timeLeft = 11
		setTimer(function()
			timeLeft = timeLeft - 1
			if (timeLeft <= 0) then
				textDestroyDisplay(countdownDisplay)
			else
				textItemSetText(countdownText,tostring(timeLeft))
			end
		end,1000,11)
		for index,thePlayer in ipairs (getElementsByType("player")) do
			toggleControl(thePlayer,"vehicle_secondary_fire",false) --and also remove the minigun
			toggleControl(thePlayer,"vehicle_fire",false) --and also remove the minigun
		end
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function markerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
	if getMarkerType(source)=="ring" and (getElementType(hitElement)=="vehicle") then
		local player = getVehicleOccupant(hitElement)
		if not player then return end
		
		fixVehicle(hitElement)
		toggleControl(player,"vehicle_secondary_fire",true)
		toggleControl(player,"vehicle_fire",true)
		
		setTimer(function()
			toggleControl(player,"vehicle_secondary_fire",false)
			toggleControl(player,"vehicle_fire",false) 
		end,20000,1)
		for index,theMarker in pairs (getAttachedElements(source)) do
			destroyElement(theMarker)
		end
		destroyElement(source)
		createRandomMarker()
	end
end
addEventHandler( "onMarkerHit", root, markerHit )

function createRandomMarker()
	local n = math.random(1,10)
	local marker = getElementByID("marker"..n)
	local x,y,z = getElementPosition(marker)
	local a = createMarker(x,y,z,"ring",4,255,0,0,255)
	createBlipAttachedTo(a,0,2,255,0,0,255)
end


function died(totalAmmo,killer,killerWeapon,bodypart)
    if (getElementType(source)=="ped") then
		if killer then
			outputChatBox(getPlayerName(killer).."#FF0000 killed an innocent bystander!",root,255,0,0,true)
		end
	end
end
addEventHandler("onPedWasted",root, died) --Add the Event when ped1 dies