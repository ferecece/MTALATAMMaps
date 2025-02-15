addEventHandler('onClientResourceStart', resourceRoot,
	function()
		txd = engineLoadTXD ( "sweeper.txd" )
		engineImportTXD ( txd, 574 )
		dff = engineLoadDFF ( "sweeper.dff", 574 )
		engineReplaceModel ( dff, 574 )
end
)
