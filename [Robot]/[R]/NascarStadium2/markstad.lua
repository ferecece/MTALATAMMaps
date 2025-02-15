-- Map by Mark01 - Marc ©


modelNames = { "markstad" }

txd1 = engineLoadTXD( "markstad.txd" )

function reloadModels( )
	for i, modelName in ipairs( modelNames ) do
		engineImportTXD( txd1, i + 4000 );
		local temp = engineLoadDFF( modelName .. ".dff", 0 );
		engineReplaceModel( temp, i + 4000 )
		temp = engineLoadCOL( modelName .. ".col" );
		engineReplaceCOL( temp, i + 4000 )
	end
end
addEventHandler( "onClientResourceStart", getResourceRootElement(), reloadModels )
addCommandHandler( "reload", reloadModels )





function hotrings()
	txdhr3 = engineLoadTXD("hotrina.txd")
	engineImportTXD(txdhr3, 502)
	dffhr3 = engineLoadDFF("hotrina.dff")
	engineReplaceModel(dffhr3, 502)
	txdhr = engineLoadTXD("hotring.txd")
	engineImportTXD(txdhr, 494)
	dffhr = engineLoadDFF("hotring.dff")
	engineReplaceModel(dffhr, 494)
	txdhr2 = engineLoadTXD("hotrinb.txd")
	engineImportTXD(txdhr2, 503)
	dffhr2 = engineLoadDFF("hotrinb.dff")
	engineReplaceModel(dffhr2, 503)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), hotrings)




function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,500)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)

