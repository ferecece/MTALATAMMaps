screenX, screenY = guiGetScreenSize()

addEventHandler("onClientPreRender", getRootElement(), function()
	local x, y, z = getElementPosition(localPlayer)
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" then return end

	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
end )