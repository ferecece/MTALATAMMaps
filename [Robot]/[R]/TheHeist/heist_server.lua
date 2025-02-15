-- Serverside script for The Heist, by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script

-- Things handled by this script:
-- - Give all the peds an SMG
-- - Enable collisions on vehicles placed in the editor
-- - Triggers and synchronisation of clientside events, mainly on checkpoints
-- - Regive weapons to solve a glitch


-- give all peds an SMG on race start
for index,thePed in ipairs (getElementsByType("ped")) do
	local model = getElementModel(thePed)
	if (model == 300) or (model == 270) or (model == 269) then -- give the peds that have these models (sweet, bs and ryder) an ak, give the rest an smg
		giveWeapon(thePed,30,5000,true) 
	else
		giveWeapon(thePed,29,5000,true)
	end
end

function start(newstate,oldstate) --function to update the race states
	setElementData(root,"racestate",newstate,true) -- used to synchronise with the client
	currentstate = newstate
	if (newstate == "GridCountdown") then 
		triggerClientEvent("startthemap",resourceRoot) --trigger starting cutscene (comment this line when testing to skip)

	-- set all vehicles that are placed on the map in the editor collisions enabled
		for index,theVehicle in ipairs (getElementsByType("vehicle")) do
			setVehicleSirensOn(theVehicle, true)
			if not (getVehicleOccupant(theVehicle)) then
				setElementData ( theVehicle, 'race.collideothers', 1 ) -- if the vehicle is empty, make it collide with other vehicles
            end
		end

		for index,theElement in ipairs (getElementsByType("object")) do
			if (getElementModel(theElement) == 10985) then
				setElementDimension(theElement,1) -- shift the dimensions of the piles of rubble, they will only show after the player has hit checkpoint 29
			end
			if (getElementModel(theElement) == 3458) then
				setElementAlpha(theElement,0) -- make the platfrom at the ramp invisible
			end
		end
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		triggerClientEvent("stayinvisible",getRootElement()) -- stay in observermode when the race starts (comment this line when testing to skip)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function startifrunning ( )
	if (currentstate == "Running") then
		setElementData(source,"justjoined",true,true) -- if a player joins when the game is already running, this is synchonised with the client
	end
end
addEventHandler ( "onPlayerJoin", getRootElement(), startifrunning )


function regiveWeaponFunc (officer, weapon) -- regive weapon event, needed due to one bullet glitch
	if (weapon == nil) then				   -- triggered from clientside
		weapon = 29
	end
	giveWeapon(officer,weapon,1000,true)
end
addEvent("regiveweapon", true )
addEventHandler("regiveweapon", root, regiveWeaponFunc )

function checkpointcounter(checkpoint,time_)
	--giveWeapon(source,29,5000,true) -- give the player an smg at each checkpoint (needed because weapons disappear on vehicle death
	--triggerClientEvent(source,"markertriggers",source,checkpoint) -- trigger marker triggers clientside

	-- Joshimuz edit: (hopefully) Reducing server load by only triggering a client event/giving weapon when needed
	if checkpoint == 11 then
		giveWeapon(source,29,5000,true) -- give the player an smg AT THE CHECKPOINT THEY NEED IT
		triggerClientEvent(source,"markertriggers",source,checkpoint) -- trigger marker triggers clientside
	elseif (checkpoint == 3) or (checkpoint == 6) or (checkpoint == 8) or (checkpoint == 13) or (checkpoint == 14)
		 or (checkpoint == 19) or (checkpoint == 24) or (checkpoint == 25) or (checkpoint == 30) or (checkpoint == 31) then
		triggerClientEvent(source,"markertriggers",source,checkpoint)
	end
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)

addEventHandler("onVehicleEnter",root,function(player,seat)
   if (getElementType(player) == "player" ) then
		removeVehicleSirens(source)
		addVehicleSirens(source,1,1)
		setVehicleSirensOn(source,false)
   end
end)