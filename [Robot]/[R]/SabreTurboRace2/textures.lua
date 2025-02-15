addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "buffalo.txd" )
    engineImportTXD ( txd, 545 )
        
    dff = engineLoadDFF ( "buffalo.dff", 545 )
    engineReplaceModel ( dff, 545 )
end 
)