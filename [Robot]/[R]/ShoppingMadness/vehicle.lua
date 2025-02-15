addEventHandler('onClientResourceStart', resourceRoot, function()
txd = engineLoadTXD ( "faggio.txd" )	engineImportTXD ( txd, 462 )
dff = engineLoadDFF ( "faggio.dff", 462 )
engineReplaceModel ( dff, 462 )end )
