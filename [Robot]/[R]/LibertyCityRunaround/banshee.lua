addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "banshee.txd" )
	engineImportTXD ( txd, 429)
	dff = engineLoadDFF ( "banshee.dff", 429)
	engineReplaceModel ( dff, 429)
end 
)