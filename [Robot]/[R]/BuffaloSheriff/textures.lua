addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/buffalo.txd" )
    engineImportTXD ( txd, 402 )
        
    dff = engineLoadDFF ( "data/buffalo.dff", 402 )
    engineReplaceModel ( dff, 402 )
end 
)