addEventHandler('onClientResourceStart', resourceRoot, 
function() 

local txd = engineLoadTXD('files/mc.txd',true)
        engineImportTXD(txd, 2052)

	
	local dff = engineLoadDFF('files/mc1.dff', 0) 
	engineReplaceModel(dff, 2052)


	local col = engineLoadCOL('files/mc1.col') 
	engineReplaceCOL(col, 2052)

		
	engineSetModelLODDistance(2052, 500)
end 
)