addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/hustler.txd" )
    engineImportTXD ( txd, 545 )
        
    dff = engineLoadDFF ( "data/hustler.dff", 545 )
    engineReplaceModel ( dff, 545 )
end 
)

addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/willard.txd" )
    engineImportTXD ( txd, 529 )
        
    dff = engineLoadDFF ( "data/willard.dff", 529 )
    engineReplaceModel ( dff, 529 )
end 
)

addEventHandler('onClientResourceStart', resourceRoot, 
function() 
    txd = engineLoadTXD ( "data/fortune.txd" )
    engineImportTXD ( txd, 526 )
        
    dff = engineLoadDFF ( "data/fortune.dff", 526 )
    engineReplaceModel ( dff, 526 )
end 
)