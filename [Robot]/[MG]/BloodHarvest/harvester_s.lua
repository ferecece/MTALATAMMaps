function dropBarrelHandler (x,y,z)
	createObject(1225, x, y, z)
end
addEvent( "dropBarrel", true )
addEventHandler( "dropBarrel", root, dropBarrelHandler )

function cancelZombieSpawn()
	if not ((currentstate == "GridCountdown") or (currentstate == "Running")) then
		cancelEvent()
	end
end
addEvent("onZombieSpawn",true)
addEventHandler("onZombieSpawn",root,cancelZombieSpawn)

function start(newstate,oldstate) --function to update the race states
	currentstate = newstate
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

-- function killazombie(hitElement)
	-- outputChatBox("kill ped")
	-- setElementAlpha(hitElement, 0)
	-- setElementHealth(hitElement,0)
-- end
-- addEvent("killPed",true)
-- addEventHandler("killPed",root,killazombie)

-- function died()
    -- outputConsole("Your Ped is dead now!")
-- end
-- addEventHandler("onPedWasted", root, died) --Add the Event when ped1 dies

-- addEventHandler ( "onElementDataChange", getRootElement(),
-- function ( dataName )
	-- if getElementType ( source ) == "ped" and dataName == "status" then
		-- if (getElementData (source, "zombie") == true) then
			-- if ( isPedDead ( source ) == false ) then
			-- elseif (getElementData ( source, "status" ) ==  "dead" ) then	
				-- outputChatBox("harvester zomb killed")
			-- end
		-- end
	-- end
-- end)