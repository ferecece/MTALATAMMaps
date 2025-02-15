function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,600)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)

addEventHandler("onClientExplosion", root, function(x, y, z, t)
	if t == 4 then
		cancelEvent()
	end
end)

function CC24()
	txdbillboard = engineLoadTXD("billbrd01_lan2.txd")
	engineImportTXD(txdbillboard, 4729)
	dffbillboard = engineLoadDFF("billbrdlan2_01.dff")
	engineReplaceModel(dffbillboard, 4729)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), CC24)
