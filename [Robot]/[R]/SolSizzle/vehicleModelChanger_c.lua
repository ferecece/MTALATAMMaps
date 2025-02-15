addEventHandler('onClientResourceStart', resourceRoot,
	function()
		txd = engineLoadTXD ( "manana.txd" )
		engineImportTXD ( txd, 410 )
		dff = engineLoadDFF ( "manana.dff", 410 )
		engineReplaceModel ( dff, 410 )
end
)
