addEventHandler("onClientResourceStart", root,
function()
    local txd = engineLoadTXD("fx/bandito.txd", 434)
    engineImportTXD(txd, 434)
 
    local dff = engineLoadDFF("fx/bandito.dff", 434)
    engineReplaceModel(dff, 434)
end)