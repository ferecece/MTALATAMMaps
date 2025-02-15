function memes()
    txdbenson = engineLoadTXD("benson.txd")
	engineImportTXD(txdbenson, 499)
	dffbenson = engineLoadDFF("benson.dff")
	engineReplaceModel(dffbenson, 499)

	txdmule = engineLoadTXD("mule.txd")
	engineImportTXD(txdmule, 414)
	dffmule = engineLoadDFF("mule.dff")
	engineReplaceModel(dffmule, 414)

	txdrumpo = engineLoadTXD("rumpo.txd")
	engineImportTXD(txdrumpo, 440)
	dffrumpo = engineLoadDFF("rumpo.dff")
	engineReplaceModel(dffrumpo, 440)

	txdyankee = engineLoadTXD("yankee.txd")
	engineImportTXD(txdyankee, 456)
	dffyankee = engineLoadDFF("yankee.dff")
	engineReplaceModel(dffyankee, 456)

    txdtopfun = engineLoadTXD("topfun.txd")
	engineImportTXD(txdtopfun, 459)
	dfftopfun = engineLoadDFF("topfun.dff")
	engineReplaceModel(dfftopfun, 459)
    
	txdbillboard = engineLoadTXD("billbrd01_lan2.txd")
	engineImportTXD(txdbillboard, 4729)
	dffbillboard = engineLoadDFF("billbrdlan2_01.dff")
	engineReplaceModel(dffbillboard, 4729)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), memes)

addEventHandler("onClientExplosion", root, function(x, y, z, t)
	if t == 4 then
		cancelEvent()
	end
end)

function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,500)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)
