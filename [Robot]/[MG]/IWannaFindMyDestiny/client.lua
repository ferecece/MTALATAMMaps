-----------------
--instant death--
-----------------
addEventHandler("onClientVehicleDamage", root, function()
	if source == getPedOccupiedVehicle(localPlayer) then
        	setElementHealth(localPlayer, 0)
	end
end)


objects= {}
addEventHandler("onClientVehicleCollision", root,
    function(collider,force, bodyPart, x, y, z, nx, ny, nz)
         if  source == getPedOccupiedVehicle(localPlayer) and getElementData(collider, "killontouch") then
             setElementHealth(localPlayer, 0)
         end
    end
)

------------------
--custom objects--
------------------
addEventHandler('onClientResourceStart', resourceRoot, 
function() 

	local txd = engineLoadTXD('files/1.txd')
        engineImportTXD(txd, 2052)
	engineImportTXD(txd, 2053)
	engineImportTXD(txd, 2054)
	engineImportTXD(txd, 2060)
	engineImportTXD(txd, 2061)
	engineImportTXD(txd, 2062)
	engineImportTXD(txd, 2063)
	engineImportTXD(txd, 2064)
	engineImportTXD(txd, 2381)
	engineImportTXD(txd, 2382)
	engineImportTXD(txd, 2383)
	engineImportTXD(txd, 2384)
	engineImportTXD(txd, 2385)
	engineImportTXD(txd, 2386)
	engineImportTXD(txd, 2387)
	engineImportTXD(txd, 2388)
	engineImportTXD(txd, 2389)
	engineImportTXD(txd, 2390)
	engineImportTXD(txd, 2391)
	engineImportTXD(txd, 2392)
	engineImportTXD(txd, 2393)


	local col = engineLoadCOL('files/1.col') 
	engineReplaceCOL(col, 2052)
	local col = engineLoadCOL('files/2.col') 
	engineReplaceCOL(col, 2053)
	local col = engineLoadCOL('files/3.col') 
	engineReplaceCOL(col, 2054)
	local col = engineLoadCOL('files/4.col') 
	engineReplaceCOL(col, 2060)
	local col = engineLoadCOL('files/5.col') 
	engineReplaceCOL(col, 2061)
	local col = engineLoadCOL('files/6.col') 
	engineReplaceCOL(col, 2062)
	local col = engineLoadCOL('files/7.col') 
	engineReplaceCOL(col, 2063)
	local col = engineLoadCOL('files/8.col') 
	engineReplaceCOL(col, 2064)
	local col = engineLoadCOL('files/9.col') 
	engineReplaceCOL(col, 2381)
	local col = engineLoadCOL('files/10.col') 
	engineReplaceCOL(col, 2382)
	local col = engineLoadCOL('files/11.col') 
	engineReplaceCOL(col, 2383)
	local col = engineLoadCOL('files/12.col') 
	engineReplaceCOL(col, 2384)
	local col = engineLoadCOL('files/13.col') 
	engineReplaceCOL(col, 2385)
	local col = engineLoadCOL('files/14.col') 
	engineReplaceCOL(col, 2386)
	local col = engineLoadCOL('files/15.col') 
	engineReplaceCOL(col, 2387)
	local col = engineLoadCOL('files/16.col') 
	engineReplaceCOL(col, 2388)
	local col = engineLoadCOL('files/17.col') 
	engineReplaceCOL(col, 2389)
	local col = engineLoadCOL('files/18.col') 
	engineReplaceCOL(col, 2390)
	local col = engineLoadCOL('files/19.col') 
	engineReplaceCOL(col, 2391)
	local col = engineLoadCOL('files/21.col') 
	engineReplaceCOL(col, 2393)


	local dff = engineLoadDFF('files/1.dff', 0) 
	engineReplaceModel(dff, 2052)  
	local dff = engineLoadDFF('files/2.dff', 0) 
	engineReplaceModel(dff, 2053)  
	local dff = engineLoadDFF('files/3.dff', 0) 
	engineReplaceModel(dff, 2054) 
	local dff = engineLoadDFF('files/4.dff', 0) 
	engineReplaceModel(dff, 2060)  
	local dff = engineLoadDFF('files/5.dff', 0) 
	engineReplaceModel(dff, 2061)  
	local dff = engineLoadDFF('files/6.dff', 0) 
	engineReplaceModel(dff, 2062) 
	local dff = engineLoadDFF('files/7.dff', 0) 
	engineReplaceModel(dff, 2063)   
	local dff = engineLoadDFF('files/8.dff', 0) 
	engineReplaceModel(dff, 2064)  
	local dff = engineLoadDFF('files/9.dff', 0) 
	engineReplaceModel(dff, 2381)  
	local dff = engineLoadDFF('files/10.dff', 0) 
	engineReplaceModel(dff, 2382)  
	local dff = engineLoadDFF('files/11.dff', 0) 
	engineReplaceModel(dff, 2383)  
	local dff = engineLoadDFF('files/12.dff', 0) 
	engineReplaceModel(dff, 2384)  
	local dff = engineLoadDFF('files/13.dff', 0) 
	engineReplaceModel(dff, 2385) 
	local dff = engineLoadDFF('files/14.dff', 0) 
	engineReplaceModel(dff, 2386) 
	local dff = engineLoadDFF('files/15.dff', 0) 
	engineReplaceModel(dff, 2387) 
	local dff = engineLoadDFF('files/16.dff', 0) 
	engineReplaceModel(dff, 2388) 
	local dff = engineLoadDFF('files/17.dff', 0) 
	engineReplaceModel(dff, 2389) 
	local dff = engineLoadDFF('files/18.dff', 0) 
	engineReplaceModel(dff, 2390) 
	local dff = engineLoadDFF('files/19.dff', 0) 
	engineReplaceModel(dff, 2391) 
	local dff = engineLoadDFF('files/20.dff', 0) 
	engineReplaceModel(dff, 2392) 
	local dff = engineLoadDFF('files/21.dff', 0) 
	engineReplaceModel(dff, 2393) 

 
	engineSetModelLODDistance(2052, 2500)
	engineSetModelLODDistance(2053, 2500)
	engineSetModelLODDistance(2054, 2500)
	engineSetModelLODDistance(2060, 2500)
	engineSetModelLODDistance(2061, 2500)
	engineSetModelLODDistance(2062, 2500)
	engineSetModelLODDistance(2063, 2500)
	engineSetModelLODDistance(2064, 2500)
	engineSetModelLODDistance(2381, 2500)
	engineSetModelLODDistance(2382, 2500)
	engineSetModelLODDistance(2383, 2500)
	engineSetModelLODDistance(2384, 2500)
	engineSetModelLODDistance(2385, 2500)
	engineSetModelLODDistance(2386, 2500)
	engineSetModelLODDistance(2387, 2500)
	engineSetModelLODDistance(2388, 2500)
	engineSetModelLODDistance(2389, 2500)
	engineSetModelLODDistance(2390, 2500)
	engineSetModelLODDistance(2391, 2500)
	engineSetModelLODDistance(2392, 2500)
	engineSetModelLODDistance(2393, 2500)



end 
)
		

--victory sound--
soundcol = createColSphere (4780, -3536, 74, 10)
	
	function playwin (me1)
	if me1 == getLocalPlayer() then
	
sound = playSound("win.ogg")
setSoundVolume(sound, 1)

destroyElement (soundcol)

end
	
end		

addEventHandler("onClientColShapeHit", soundcol, playwin)
