addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "blista.txd" )
    engineImportTXD ( txd, 579 )
        
    dff = engineLoadDFF ( "blista.dff", 579 )
        engineReplaceModel ( dff, 579 )
end 
)