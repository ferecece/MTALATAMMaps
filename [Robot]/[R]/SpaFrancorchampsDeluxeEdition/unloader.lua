
local replacedAnything = false
local replacedCollisions = {}
local replacedModels = {}

local __mta_engineImportTXD = engineImportTXD
local __mta_engineReplaceCOL = engineReplaceCOL
local __mta_engineReplaceModel = engineReplaceModel

function engineImportTXD(texturePointer, modelID)
    replacedAnything = true
    replacedModels[modelID] = true
    return __mta_engineImportTXD(texturePointer, modelID)
end

function engineReplaceModel(modelPointer, modelID)
    replacedAnything = true
    replacedModels[modelID] = true
    return __mta_engineReplaceModel(modelPointer, modelID)
end

function engineReplaceCOL(collisionPointer, modelID)
    replacedAnything = true
    replacedCollisions[modelID] = true
    return __mta_engineReplaceCOL(collisionPointer, modelID)
end

addEventHandler("onClientResourceStop", resourceRoot,
    function (res)
        if not replacedAnything then
            return
        end

        for model in pairs(replacedModels) do
            engineRestoreModel(model)
        end
        for model in pairs(replacedCollisions) do
            engineRestoreCOL(model)
        end

        outputDebugString("[".. getResourceName(res) .."] Restored models and collisions")
    end
)
