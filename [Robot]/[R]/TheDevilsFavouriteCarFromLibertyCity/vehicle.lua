addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "diablos.txd" )
    engineImportTXD ( txd, 535 )
        
    dff = engineLoadDFF ( "diablos.dff", 535 )
        engineReplaceModel ( dff, 535 )
end 
)