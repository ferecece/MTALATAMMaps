addEventHandler('onClientResourceStart', resourceRoot, function()	
	txd = engineLoadTXD ( "dodo.txd" )
	engineImportTXD ( txd, 402 )
	
	dff = engineLoadDFF ( "dodo.dff", 0)
	engineReplaceModel ( dff, 402 )
end 
)