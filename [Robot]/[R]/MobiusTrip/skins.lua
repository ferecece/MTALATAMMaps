function loadSkin()
	txd = engineLoadTXD ( "sandking.txd" )
	engineImportTXD ( txd, 411 )
	dff = engineLoadDFF ( "sandking.dff" )
	engineReplaceModel ( dff, 411 )
	
	
	txd = engineLoadTXD ( "dyn_drugs.txd" )
	engineImportTXD ( txd, 1577 )
	engineImportTXD ( txd, 1580 )
	dff = engineLoadDFF ( "drug_yellow.dff", 0 )
	engineReplaceModel ( dff, 1577 )
	dff = engineLoadDFF ( "drug_red.dff", 0 )
	engineReplaceModel ( dff, 1580 )
	
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadSkin)