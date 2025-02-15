addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/supergt.txd" )
    engineImportTXD ( txd, 506 )
        
    dff = engineLoadDFF ( "data/supergt.dff", 506 )
    engineReplaceModel ( dff, 506 )
end 
)