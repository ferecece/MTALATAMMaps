function replace()

kappa = engineLoadTXD ("cj_don_sign.txd")
engineImportTXD( kappa , 2715)

end
addEventHandler("onClientResourceStart",getRootElement(), replace)

containmentZone = createColCircle ( -2285, 1929.5, 500 )
function leftZone ( hitElement, matchingDimension )
        if getElementType ( hitElement ) == "vehicle" then
		
		losinghealthtimer = setTimer ( function()
									currentHealth = getElementHealth(hitElement)
									setElementHealth ( hitElement,currentHealth - currentHealth*0.001 - 1)
							end, 100, 0 )
		
        end
end
addEventHandler ( "onClientColShapeLeave", containmentZone, leftZone )

function enteredZone ( hitElement, matchingDimension )
      if getElementType ( hitElement ) == "vehicle" and (losinghealthtimer) then
	  killTimer(losinghealthtimer)
	  end
end
addEventHandler ( "onClientColShapeHit", containmentZone, enteredZone )