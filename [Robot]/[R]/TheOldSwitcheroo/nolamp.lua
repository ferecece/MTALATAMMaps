local models = {3881, 11383, 3882, 1290, 10788, 1278, 9693, 9691, 768}

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