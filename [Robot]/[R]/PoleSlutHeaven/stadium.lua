addEventHandler("onClientResourceStart", resourceRoot, function()	
	setInteriorSoundsEnabled(false)
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	setInteriorSoundsEnabled(true)
end )