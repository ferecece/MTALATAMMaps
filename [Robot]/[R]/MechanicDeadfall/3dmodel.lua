addEventHandler('onClientResourceStart', resourceRoot,
    function()
 
        local txd = engineLoadTXD('Files/3dmodel.txd',true)
        engineImportTXD(txd, 16209)
 
        local dff = engineLoadDFF('Files/3dmodel.dff', 0)
        engineReplaceModel(dff, 16209)
 
        local col = engineLoadCOL('Files/3dmodel.col')
        engineReplaceCOL(col, 16209)
        engineSetModelLODDistance(16209, 0)

txd = engineLoadTXD ( "Files/blista.txd" )	engineImportTXD ( txd, 496 )

dff = engineLoadDFF ( "Files/blista.dff", 0 )   engineReplaceModel ( dff, 496 )
	end 
)
