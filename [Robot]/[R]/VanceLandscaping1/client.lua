local function start()
	local txd = engineLoadTXD("vance.txd")
	engineImportTXD(txd, 17)
	local dff = engineLoadDFF("vance.dff", 17)
	engineReplaceModel(dff, 17)
end
addEventHandler("onClientResourceStart", resourceRoot, start)
