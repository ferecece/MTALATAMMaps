function memes()
	txdsign = engineLoadTXD("sw_farm1.txd")
	engineImportTXD(txdsign, 12921)
	dffsign = engineLoadDFF("sw_farment01.dff")
	engineReplaceModel(dffsign, 12921)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), memes)

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