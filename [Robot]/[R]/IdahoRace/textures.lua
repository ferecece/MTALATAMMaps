addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/virgo.txd" )
    engineImportTXD ( txd, 491 )
        
    dff = engineLoadDFF ( "data/virgo.dff", 491 )
    engineReplaceModel ( dff, 491 )
end 
)