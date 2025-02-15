addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "kuruma.txd" )
    engineImportTXD ( txd, 445 )
        
    dff = engineLoadDFF ( "kuruma.dff", 445 )
        engineReplaceModel ( dff, 445 )
end 
)