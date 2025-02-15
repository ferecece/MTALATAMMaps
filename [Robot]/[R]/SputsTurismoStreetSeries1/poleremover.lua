local models = {1226}

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		setCameraMatrix(3000,3000,3000)
		for _,model in pairs(models) do
			removeWorldModel(model, 50000, 0, 0, 0)
		end
		setTimer(setCameraTarget,1000,1,getLocalPlayer())
	end
)

addEventHandler("onClientResourceStop",resourceRoot,
	function()
		setCameraMatrix(3000,3000,3000)
		for _,model in pairs(models) do
			restoreWorldModel(model, 50000, 0, 0, 0)
		end
		setTimer(setCameraTarget,1000,1,getLocalPlayer())
	end
)