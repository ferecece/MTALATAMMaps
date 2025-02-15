addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "cheetah.txd" )
    engineImportTXD ( txd, 415 )
        
    dff = engineLoadDFF ( "cheetah.dff", 415 )
        engineReplaceModel ( dff, 415 )
end 
)