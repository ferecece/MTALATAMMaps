function replaceModel()
    local txd, dff

    txd = engineLoadTXD('models/bmx.txd', 481)
    engineImportTXD(txd, 481)
    dff = engineLoadDFF('models/bmx.dff', 481)
    engineReplaceModel(dff, 481)

    txd = engineLoadTXD('models/male01.txd', 7)
    engineImportTXD(txd, 7)
    dff = engineLoadDFF('models/male01.dff', 7)
    engineReplaceModel(dff, 7)
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
