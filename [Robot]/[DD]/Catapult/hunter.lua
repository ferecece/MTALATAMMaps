 hunterWeaponsOff = textCreateDisplay()
 hunterWeaponsOffText = textCreateTextItem("Hunter weapons disabled",0.5,0.1,"medium",255,0,0,255,2,"center")
 textDisplayAddText ( hunterWeaponsOff, hunterWeaponsOffText ) 
 
 hunterWeaponsOn = textCreateDisplay()
 hunterWeaponsOnText = textCreateTextItem("Hunter weapons enabled",0.5,0.1,"medium",0,255,0,255,2,"center")
 textDisplayAddText ( hunterWeaponsOn, hunterWeaponsOnText ) 
 
 containmentMessage = textCreateDisplay()
 containmentText = textCreateTextItem("Return to the arena!",0.5,0.5,"medium",255,0,0,255,2,"center")
 textDisplayAddText ( containmentMessage, containmentText ) 
 
 dangerousblips = {}
Dangerouscars = {}
Dangerouscars[425] = true
Dangerouscars[520] = true
Dangerouscars[476] = true
Dangerouscars[447] = true
Dangerouscars[432] = true
Dangerouscars[464] = true

function hunterDisable(oldModel,newModel)
   if oldModel == 425 then
   playerincar = getVehicleOccupant( source )
   textDisplayRemoveObserver ( hunterWeaponsOff, playerincar )
   textDisplayRemoveObserver ( hunterWeaponsOn, playerincar)
   toggleControl(playerincar,"vehicle_fire",true)
   toggleControl(playerincar,"vehicle_secondary_fire",true)
   end
     
   if newModel == 425 then
   playerincar = getVehicleOccupant( source )
   toggleControl(playerincar,"vehicle_fire",false)
   toggleControl(playerincar,"vehicle_secondary_fire",false)
   outputChatBox ("You have picked up the Hunter. Your weapons will be enabled in the center of the map.",playerincar,255,0,0) --Display this message in the chat box
   textDisplayAddObserver ( hunterWeaponsOff, playerincar )
   end
   
   if Dangerouscars[oldModel] then
   playerincar = getVehicleOccupant( source )
   destroyElement(dangerousblips[playerincar])
   end
   
   if Dangerouscars[newModel] then
   playerincar = getVehicleOccupant( source )
   dangerousblips[playerincar] = createBlipAttachedTo(source,0,2,255,0,0)
   end
end
addEventHandler ( "onElementModelChange", getRootElement(), hunterDisable )

hunterZone = createColRectangle ( -2317.5, 1897, 65, 65)
function enableHunter ( hitElement, matchingDimension )
        if getElementType ( hitElement ) == "vehicle" and getElementModel(hitElement) == 425 then
		playerincar = getVehicleOccupant( hitElement )
		toggleControl(playerincar,"vehicle_fire",true)
		toggleControl(playerincar,"vehicle_secondary_fire",true)
		textDisplayRemoveObserver ( hunterWeaponsOff, playerincar )
		textDisplayAddObserver ( hunterWeaponsOn,playerincar)
        end
end
addEventHandler ( "onColShapeHit", hunterZone, enableHunter )

function disableHunterLeaving ( hitElement, matchingDimension )
        if getElementType ( hitElement ) == "vehicle" and getElementModel(hitElement) == 425 then
		playerincar = getVehicleOccupant( hitElement )
		toggleControl(playerincar,"vehicle_fire",false)
		toggleControl(playerincar,"vehicle_secondary_fire",false)
		textDisplayRemoveObserver ( hunterWeaponsOn,playerincar)
		textDisplayAddObserver ( hunterWeaponsOff,playerincar)
        end
end
addEventHandler ( "onColShapeLeave", hunterZone, disableHunterLeaving )

function stopText()
--if getElementModel(getPedOccupiedVehicle(source))== 425 then
	textDisplayRemoveObserver ( hunterWeaponsOff, source )
    textDisplayRemoveObserver ( hunterWeaponsOn, source)
	textDisplayRemoveObserver ( containmentMessage, source)
	if dangerousblips[source] then
	destroyElement(dangerousblips[source])
	end
--end
end
addEventHandler ( "onPlayerWasted", getRootElement(), stopText )



containmentZone = createColCircle ( -2285, 1929.5, 500 )

function leftZone ( hitElement, matchingDimension )
        if getElementType ( hitElement ) == "vehicle" then
		playerincar = getVehicleOccupant( hitElement )
		textDisplayAddObserver ( containmentMessage,playerincar)	
        end
end
addEventHandler ( "onColShapeLeave", containmentZone, leftZone )

function enteredZone ( hitElement, matchingDimension )
	  if getElementType ( hitElement ) == "vehicle" then
	  playerincar = getVehicleOccupant( hitElement )
	  textDisplayRemoveObserver ( containmentMessage,playerincar)
	  end
end
addEventHandler ( "onColShapeHit", containmentZone, enteredZone )