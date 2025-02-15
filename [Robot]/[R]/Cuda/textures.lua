addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/sabre.txd" )
    engineImportTXD ( txd, 475 )
        
    dff = engineLoadDFF ( "data/sabre.dff", 475 )
    engineReplaceModel ( dff, 475 )
end 
)