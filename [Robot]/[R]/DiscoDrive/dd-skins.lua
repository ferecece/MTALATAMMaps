function loadModels ()
	txd = engineLoadTXD ( "dyn_drugs.txd" )
	engineImportTXD ( txd, 1576 )
	engineImportTXD ( txd, 1577 )
	engineImportTXD ( txd, 1578 )
	engineImportTXD ( txd, 1580 )
	
	
	dff = engineLoadDFF ( "drug_green.dff", 0 )
	engineReplaceModel ( dff, 1578 )
	
	dff = engineLoadDFF ( "drug_orange.dff", 0 )
	engineReplaceModel ( dff, 1576 )
	
	dff = engineLoadDFF ( "drug_yellow.dff", 0 )
	engineReplaceModel ( dff, 1577 )
	
	dff = engineLoadDFF ( "drug_red.dff", 0 )
	engineReplaceModel ( dff, 1580 )
end
addEventHandler("onClientResourceStart",resourceRoot,loadModels)
