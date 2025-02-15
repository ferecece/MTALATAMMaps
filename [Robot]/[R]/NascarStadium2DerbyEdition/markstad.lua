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


function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,500)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)

