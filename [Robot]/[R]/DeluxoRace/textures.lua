addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/deluxo.txd" )
    engineImportTXD ( txd, 402 )
        
    dff = engineLoadDFF ( "data/deluxo.dff", 402 )
    engineReplaceModel ( dff, 402 )
end 
)