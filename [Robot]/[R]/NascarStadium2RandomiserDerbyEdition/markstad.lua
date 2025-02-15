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


function memes()
	txdmule = engineLoadTXD("mule.txd")
	engineImportTXD(txdmule, 414)
	dffmule = engineLoadDFF("mule.dff")
	engineReplaceModel(dffmule, 414)

	txdyankee = engineLoadTXD("yankee.txd")
	engineImportTXD(txdyankee, 456)
	dffyankee = engineLoadDFF("yankee.dff")
	engineReplaceModel(dffyankee, 456)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), memes)

function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,500)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)

addEventHandler("onClientExplosion", root, function(x, y, z, t)
	if t == 4 then
		cancelEvent()
	end
end)

