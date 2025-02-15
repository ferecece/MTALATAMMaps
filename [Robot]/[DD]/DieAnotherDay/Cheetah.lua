addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "cheetah.txd" ) -- Load the UFO Texture
	engineImportTXD ( txd, 415) -- Apply the UFO texture to the Sparrow Helit
	dff = engineLoadDFF ( "cheetah.dff", 411) -- Load the UFO model
	engineReplaceModel ( dff, 415) -- Apply the UFO model to the Sparrow Heli
end 
)

