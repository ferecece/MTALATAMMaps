addEventHandler('onClientResourceStart', resourceRoot,
    function()
 
        local txd = engineLoadTXD('Files/3dmodel.txd',true)
        engineImportTXD(txd, 496)
 
        local dff = engineLoadDFF('Files/3dmodel.dff', 0)
        engineReplaceModel(dff, 496)

	end 
)
