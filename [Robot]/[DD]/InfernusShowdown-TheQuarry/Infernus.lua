addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "infernus.txd" ) -- Load the UFO Texture
	engineImportTXD ( txd, 411) -- Apply the UFO texture to the Sparrow Helit
	dff = engineLoadDFF ( "infernus.dff", 411) -- Load the UFO model
	engineReplaceModel ( dff, 411) -- Apply the UFO model to the Sparrow Heli
end 
)

