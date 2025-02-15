addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "sparrow.txd" ) -- Load the UFO Texture
	engineImportTXD ( txd, 425 ) -- Apply the UFO texture to the Sparrow Heli
	engineImportTXD ( txd, 8341 ) -- Apply the UFO texture to the shipping crates object
	dff = engineLoadDFF ( "sparrow.dff", 469 ) -- Load the UFO model
	engineReplaceModel ( dff, 425 ) -- Apply the UFO model to the Sparrow Heli
	engineReplaceModel ( dff, 8341 ) -- Apply the UFO model to the shipping crates object
end 
)


