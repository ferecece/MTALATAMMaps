addEventHandler('onClientResourceStart', resourceRoot, 
function() 

txd3 = engineLoadTXD ( "slow.txd" )
engineImportTXD ( txd3, 4731 )

end 
)