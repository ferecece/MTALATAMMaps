addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	txd = engineLoadTXD ( "vehicle-formula/texture.txd" )
	engineImportTXD ( txd, 415 )

	dff = engineLoadDFF ( "vehicle-formula/model.dff", 415 )
	engineReplaceModel ( dff, 415 )
end 
)

-- local screenWidth, screenHeight = guiGetScreenSize()
-- addEventHandler('onClientRender', root,
--    function()
--       local veh = getPedOccupiedVehicle(getLocalPlayer())
--       if veh and getElementModel(veh) == 415 then
--          dxDrawText ( 'Car: Cheetah - SKC Formula', 4, screenHeight-34, 0, 0, tocolor ( 255, 255, 255, 255 ), 0.7, 'bankgothic' )
--       end
--    end
-- )


addEvent('onClientReplaceModel', true)
addEventHandler('onClientReplaceModel', resourceRoot, 
	function()
		triggerEvent('onClientResourceStart', resourceRoot )
	end 
)

addEvent('onClientUnreplaceModel', true)
addEventHandler('onClientUnreplaceModel', resourceRoot, 
	function()
		if txd then destroyElement( txd ) end
		if dff then destroyElement( dff ) end
		txd = nil
		dff = nil
	end 
)
