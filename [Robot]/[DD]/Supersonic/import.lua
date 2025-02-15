function import ()
-- Lumiverse Logo
txd = engineLoadTXD("logomark.txd") 
engineImportTXD(txd, 1526)
end
addEventHandler( "onClientResourceStart", resourceRoot, import)
