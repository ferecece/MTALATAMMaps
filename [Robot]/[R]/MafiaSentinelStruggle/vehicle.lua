addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "mafia.txd" )
    engineImportTXD ( txd, 405 )
        
    dff = engineLoadDFF ( "mafia.dff", 405 )
        engineReplaceModel ( dff, 405 )
end 
)