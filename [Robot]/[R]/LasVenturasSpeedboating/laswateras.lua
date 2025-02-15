addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	createWater ( 700, 500, 13, 2990, 500, 13, 700, 2990, 13, 2990, 2990, 13 )

	txd = engineLoadTXD ( "files/vortex.txd" )
	engineImportTXD ( txd, 539 )

	dff = engineLoadDFF ( "files/vortex.dff", 539 )
	engineReplaceModel ( dff, 539 )

	setGravity (0.02)
end 
)