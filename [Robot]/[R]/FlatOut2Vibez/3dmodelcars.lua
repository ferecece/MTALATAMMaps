addEventHandler('onClientResourceStart', resourceRoot,
    function()
 
        local txd = engineLoadTXD('Files/bullet.txd',true)
        engineImportTXD(txd, 541)
 
        local dff = engineLoadDFF('Files/bullet.dff', 0)
        engineReplaceModel(dff, 541)

	end 
)
