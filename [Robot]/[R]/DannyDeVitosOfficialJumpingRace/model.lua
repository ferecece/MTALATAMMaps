addEventHandler('onClientResourceStart', resourceRoot, 
function() 

txd = engineLoadTXD ( "skin.txd" )
engineImportTXD ( txd, 4238 )

end 
)