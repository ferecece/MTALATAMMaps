addEventHandler('onClientResourceStart', resourceRoot, 
function() 

txd = engineLoadTXD ( "joshsign.txd" )
engineImportTXD ( txd, 7073 )

end 
)