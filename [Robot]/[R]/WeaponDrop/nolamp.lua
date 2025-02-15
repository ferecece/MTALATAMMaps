addEventHandler('onResourceStart', resourceRoot, function()
	removeWorldModel(3335, 50000, 0, 0, 0)
	removeWorldModel(705, 50000, 0, 0, 0)
end)

addEventHandler('onResourceStop', resourceRoot, function()
	restoreWorldModel(3335, 50000, 0, 0, 0)
	restoreWorldModel(705, 50000, 0, 0, 0)
end)
