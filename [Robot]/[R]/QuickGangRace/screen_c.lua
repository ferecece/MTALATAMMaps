local webBrowser = false
local screenX, screenY = guiGetScreenSize()

function dxDrawImage3D(x,y,z,w,h,m,...)
	return dxDrawMaterialLine3D(x, y, z+h,x,y,z, m, w,tocolor(255,255,255,255),...)
end

addEventHandler("onClientBrowserCreated", getRootElement(), function()
	loadBrowserURL(webBrowser, 'https://www.youtube.com/embed?listType=playlist&list=PLnFYuYwRteIMn1lvwIiGimb1w4U9meQKJ&autoplay=1&showinfo=0&rel=0&controls=0&disablekb=1&index=' ..getElementData(root, "video"))
	
	addEventHandler("onClientRender", root, function()
		dxDrawImage3D(2455.9, -1675.3, 14.7, 14.5778, 8.2, webBrowser, 2489.4, -1662.5, 14.7)
		
		if getPedOccupiedVehicle(localPlayer) then
			if not muted and isMTAWindowFocused() then
				local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
				setBrowserVolume(math.max((60 - getDistanceBetweenPoints3D(x, y, z, 2455.6, -1675.6, 14.7))*(1/60), 0)*0.8)
			else setBrowserVolume(0) end
		end
	end )
end )

addEventHandler("onClientRender", root, function()
	-- Spec check
	local u, w, v = getElementPosition(localPlayer)
	if v > 20000 or not getPedOccupiedVehicle(localPlayer) then return end 
	
	-- Events
	if tonumber(getElementData(localPlayer, "race.checkpoint")) then
		-- Create screen source
		if tonumber(getElementData(localPlayer, "race.checkpoint")) == 22 and not webBrowser and tonumber(getElementData(root, "video")) then 
			webBrowser = createBrowser(1920, 1080, false, false)
			setBrowserVolume(0)
			outputChatBox("Press M to mute the video")
		end
	end
	
	for _, vehicles in ipairs(getElementsByType("vehicle")) do
		local occ = getVehicleOccupants(vehicles)
		if occ[0] == nil then setVehicleColor(vehicles, 16, 1, 16, 16)
		else setVehicleColor(vehicles, 5, 1, 5, 5) end
	end
end )

bindKey("m", "down", function() muted = not muted end )