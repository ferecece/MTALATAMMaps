local models = {727, 883, 884, 885, 1308}

addEventHandler('onResourceStart', resourceRoot, function()
        for _, model in ipairs(models) do
                removeWorldModel(model, 50000, 0, 0, 0)
        end
end)

addEventHandler('onResourceStop', resourceRoot, function()
        for _, model in ipairs(models) do
                restoreWorldModel(model, 50000, 0, 0, 0)
        end
end)