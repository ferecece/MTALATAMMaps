local isMarkerid = 1
local countMarkersHit = 0
local countPlayers = 0
local isSuddenDeath = 0
Dangerouscars = {[425] = true,
                 [520] = true,
                 [476] = true,
                 [447] = true,
                 [432] = true,
                 [464] = true,
                 [413] = true}

disallowedVehicle = {[511] = true,
                     [594] = true,
                     [441] = true,
                     [501] = true,
                     [465] = true,
                     [564] = true,
                     [449] = true,
                     [537] = true,
                     [460] = true,
                     [538] = true,
                     [570] = true,
                     [569] = true,
                     [590] = true,
                     [472] = true,
                     [473] = true,
                     [493] = true,
                     [595] = true,
                     [484] = true,
                     [430] = true,
                     [453] = true,
                     [452] = true,
                     [446] = true,
                     [454] = true,
                     [592] = true,
                     [577] = true,
                     [606] = true,
                     [607] = true,
                     [610] = true,
                     [611] = true,
                     [584] = true,
                     [608] = true,
                     [435] = true,
                     [450] = true,
                     [591] = true,
                     [539] = true,
                     [553] = true}

function generateZufallCarID ()
	vehicleID = math.random(399, 609)
	if disallowedVehicle[vehicleID] then
		return generateZufallCarID()
	else
		return vehicleID
  end
end

function mapISStarting ()
	createMarkerToMap()
	countPlayers = getPlayerCount()
end
addEventHandler("onResourceStart",getResourceRootElement(),mapISStarting)

function createMarkerToMap ()
	if     isMarkerid ==  1 then createMarker(3867,-1837.5,140,"checkpoint",4)
	elseif isMarkerid ==  2 then createMarker(3880,-1850,140,"checkpoint",3)
	elseif isMarkerid ==  3 then createMarker(3867,-1918,134,"checkpoint",3)
	elseif isMarkerid ==  4 then createMarker(3867,-1910,130,"checkpoint",3)
	elseif isMarkerid ==  5 then createMarker(3940,-1957.75,134,"checkpoint",3)
	elseif isMarkerid ==  6 then createMarker(3794,-1957.75,134,"checkpoint",3)
	elseif isMarkerid ==  7 then createMarker(3979.75,-1950.75,134,"checkpoint",3)
	elseif isMarkerid ==  8 then createMarker(3879,-1825,140,"checkpoint",3)
	elseif isMarkerid ==  9 then createMarker(3947,-1838,134,"checkpoint",3)
	elseif isMarkerid == 10 then createMarker(3939,-1838,130,"checkpoint",3)
	elseif isMarkerid == 11 then createMarker(3986.75,-1765,134,"checkpoint",3)
	elseif isMarkerid == 12 then createMarker(3986.75,-1911,134,"checkpoint",3)
	elseif isMarkerid == 13 then createMarker(3979.75,-1725.25,134,"checkpoint",3)
	elseif isMarkerid == 14 then createMarker(3854,-1826,140,"checkpoint",3)
	elseif isMarkerid == 15 then createMarker(3867,-1758,134,"checkpoint",3)
	elseif isMarkerid == 16 then createMarker(3867,-1766,130,"checkpoint",3)
	elseif isMarkerid == 17 then createMarker(3794,-1718.25,134,"checkpoint",3)
	elseif isMarkerid == 18 then createMarker(3940,-1718.25,134,"checkpoint",3)
	elseif isMarkerid == 19 then createMarker(3754.25,-1725.25,134,"checkpoint",3)
	elseif isMarkerid == 20 then createMarker(3855,-1851,140,"checkpoint",3)
	elseif isMarkerid == 21 then createMarker(3787,-1838,134,"checkpoint",3)
	elseif isMarkerid == 22 then createMarker(3795,-1838,130,"checkpoint",3)
	elseif isMarkerid == 23 then createMarker(3747.25,-1911,134,"checkpoint",3)
	elseif isMarkerid == 24 then createMarker(3747.25,-1765,134,"checkpoint",3)
	elseif isMarkerid == 25 then createMarker(3754.25,-1950.75,134,"checkpoint",3)
	else
		isMarkerid = 1
		createMarkerToMap()
	end
end

function onMarkerHit_S ( hit )
	if getElementType(hit ) == "vehicle" and getMarkerType(source) == "checkpoint" then
	  countMarkersHit = countMarkersHit + 1
	  if countMarkersHit >= 8 then
      countMarkersHit = 0
      local rotHunterIcon = math.random(1,4)
      if     rotHunterIcon == 1 then
        createMarker(4017,-1837.5,160,"corona",15,255,0,0)
	    elseif rotHunterIcon == 2 then
	      createMarker(3867,-1987.5,160,"corona",15,255,0,0)
	    elseif rotHunterIcon == 3 then
	      createMarker(3727,-1837.5,160,"corona",15,255,0,0)
	    else
	      createMarker(3867,-1687.5,160,"corona",15,255,0,0)
	    end
	    
	    local rotRepairIcon = math.random(1,8)
	    if     rotRepairIcon == 1 then
	      createMarker(3942,-1981.2,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 2 then
	      createMarker(3792,-1981.2,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 3 then
	      createMarker(4010.2,-1763,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 4 then
	      createMarker(4010.2,-1913,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 5 then
	      createMarker(3792,-1694.8,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 6 then
	      createMarker(3942,-1694.8,128,"cylinder",3,0,255,0)
	    elseif rotRepairIcon == 7 then
	      createMarker(3723.8,-1913,128,"cylinder",3,0,255,0)
	    else
	      createMarker(3723.8,-1763,128,"cylinder",3,0,255,0)
	    end
	    
	    outputChatBox("#ddbb00Information - Bonus icons have spawned...somewhere!", getRootElement(), 255, 0, 0, true)
	  end
		local carid = generateZufallCarID()
		local x, y, z = getElementPosition(hit)
		if countPlayers > 5 then
		  fixVehicle(hit)
		else
		  setElementHealth(hit, getElementHealth(hit) + (countPlayers * 200))
		end
	  local healthPercent = (getElementHealth(hit) - 250) / 750
		if healthPercent > 1 then
		  setElementHealth(hit, 1000)
		end
	  if healthPercent > (countPlayers * 0.25) then
		  setElementHealth(hit, countPlayers * 187.5 + 250)
		end	
		setElementModel(hit, carid)
		setElementPosition(hit, x, y, z + 1)
		if Dangerouscars[carid] then
			outputChatBox("#ff0000Warning - Someone got a " .. getVehicleNameFromModel(carid), getRootElement(), 255, 0, 0, true)
		end
		destroyElement(source)
		isMarkerid = isMarkerid + math.random(1, 24)
		createMarkerToMap()
  elseif getElementType(hit ) == "vehicle" and getMarkerType(source) == "corona" then
    local prizeHunterIcon = math.random(1,10)
    if prizeHunterIcon >= 4 then
      setElementModel(hit, 425)
      outputChatBox("#ff0000Warning - Someone upgraded to a " .. getVehicleNameFromModel(425), getRootElement(), 255, 0, 0, true)
    elseif prizeHunterIcon == 2 or prizeHunterIcon == 3 then
      setElementModel(hit, 464)
      outputChatBox("#ff0000Warning - Someone upgraded to a " .. getVehicleNameFromModel(464), getRootElement(), 255, 0, 0, true)
    else
      setElementModel(hit, 520)
      outputChatBox("#ff0000Warning - Someone upgraded to a " .. getVehicleNameFromModel(520), getRootElement(), 255, 0, 0, true)
    end
    destroyElement(source)
	elseif getElementType(hit ) == "vehicle" and getMarkerType(source) == "cylinder" then
	  local prizeRepairIcon = math.random(1,10)
    if prizeRepairIcon >= 3 then
	    fixVehicle(hit)
	  elseif prizeRepairIcon == 2 then
	    fixVehicle(hit)
	    setElementModel(hit, 462)
	    outputChatBox("#ddbb00Information - Someone downgraded to a faggio!", getRootElement(), 255, 0, 0, true)
	  else
	    fixVehicle(hit)
	    setElementModel(hit, 608)
	    outputChatBox("#ddbb00Information - Someone downgraded to a set of stairs?!", getRootElement(), 255, 0, 0, true)
	  end
	  destroyElement(source)
	end
end

function onPlayerDeath_S()
  countPlayers = countPlayers - 1
  if countPlayers > 1 and countPlayers <= 5 and isSuddenDeath == 0 then
    outputChatBox("#ff0000Warning - The End Beckons!", getRootElement(), 255, 0, 0, true)
    isSuddenDeath = 1
    setWeather(16)
  end
end

addEventHandler("onMarkerHit",getRootElement(),onMarkerHit_S)
addEventHandler("onPlayerWasted",getRootElement(),onPlayerDeath_S)