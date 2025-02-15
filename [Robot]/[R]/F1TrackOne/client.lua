addEventHandler('onClientResourceStart', resourceRoot, function() 	
	txd = engineLoadTXD ( "ferrari.txd" )
	dff = engineLoadDFF ( "ferrari.dff", 494 )
	engineImportTXD ( txd, 494 )
	engineReplaceModel ( dff, 494 )
	
	txd = engineLoadTXD ( "mclaren.txd" )
	dff = engineLoadDFF ( "mclaren.dff", 502 )
	engineImportTXD ( txd, 502 )
	engineReplaceModel ( dff, 502 )
	
	txd = engineLoadTXD ( "redbull.txd" )
	dff = engineLoadDFF ( "redbull.dff", 503 )
	engineImportTXD ( txd, 503 )
	engineReplaceModel ( dff, 503 )
end 
)


