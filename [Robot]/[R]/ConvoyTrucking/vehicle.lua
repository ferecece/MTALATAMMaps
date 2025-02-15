addEventHandler('onClientResourceStart', resourceRoot,
function()
	txd = engineLoadTXD ( "trailerskin.txd" )
	engineImportTXD ( txd, 435 )
end
)
