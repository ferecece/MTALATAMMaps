addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "lc_ghost.txd" )
    engineImportTXD ( txd, 480 )
        
    dff = engineLoadDFF ( "lc_ghost.dff", 480 )
        engineReplaceModel ( dff, 480 )
end 
)