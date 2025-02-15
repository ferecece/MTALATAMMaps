addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "marquis.txd" ) -- Load the UFO Texture
	engineImportTXD ( txd, 484) -- Apply the UFO texture to the Sparrow Helit
	dff = engineLoadDFF ( "marquis.dff", 484) -- Load the UFO model
	engineReplaceModel ( dff, 484) -- Apply the UFO model to the Sparrow Heli
end 
)

