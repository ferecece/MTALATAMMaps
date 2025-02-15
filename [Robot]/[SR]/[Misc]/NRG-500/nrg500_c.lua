markerTable = {
	{-1632.058,143.152,3.4111},
	{-1632.021,83.0413,7.5331},
	{-1689.148,53.3936,11.7703}, 
	{-1606.423,133.4396,-10.9911}, 
	{-1680.386,87.0915,8.2325}, 
	{-1666.295,102.0489,-1.5025}, 
	{-1654.692,60.7782,7.6501}, 
	{-1684.867,74.6374,-7.0328}, 
	{-1583.797,126.1577,4.157}, 
	{-1667.705,49.5191,6.5634}, 
	{-1611.585,106.3131,-3.6465}, 
	{-1590.556,148.9676,4.113},
	{-1671.959,98.6,8.9263},
	{-1693.32,65.1187,8.7997}, 
	{-1660.951,107.6739,-2.1545}, 
	{-1654.071,77.2629,-10.2893},
	{-1645.494,107.2477,-10.6617}, 
	{-1673.735,56.9287,-10.674}, 
	--{-1681.464,27.2091,9.6606} 
}

setWorldSpecialPropertyEnabled("aircars",true)
checkpointCounter = 0
function colHit(hitEl,dim)
	if getElementType(hitEl) == "vehicle" then
		if getVehicleOccupant(hitEl) == localPlayer then
			if getElementModel(hitEl)==522 then
				checkpointCounter = checkpointCounter+1
				playSoundFrontEnd(101)
				destroyElement(markers[source])
				destroyElement(blips[source])
				destroyElement(source)
				
				if checkpointCounter == 18 then
					setElementPosition(hitEl,-1709,188.8,33.7)
				end
			end
		end
	end
end

markers = {}
blips = {}
setTimer(function()
	for i,m in ipairs (markerTable) do
		local col = createColSphere(m[1],m[2],m[3],3)
		blips[col] = createBlipAttachedTo(col,0,1,255,0,0,255)
		markers[col]= createMarker(m[1],m[2],m[3],"ring",1,255,0,0,100)
		addEventHandler("onClientColShapeHit",col,colHit)
	end

	outputChatBox("The yellow checkpoint is commented out in the original source code. I wonder why...",255,255,0)

	local col = createColSphere(-1681.464,27.2091,9.6606,3)
		blips[col] = createBlipAttachedTo(col,0,1,255,255,0,255)
		markers[col]= createMarker(-1681.464,27.2091,9.6606,"ring",1,255,255,0,100)
		addEventHandler("onClientColShapeHit",col,colHit)

		
end,500,1)

--Not in use for now: rotating markers is very ugly because it redraws the marker making it flash
angle = 0
function render()
	angle = (angle + 1) % 360
	--outputChatBox(angle)
	for k, m in pairs (markers) do
		--outputChatBox(i)
		local x,y,z = getElementPosition(m)
		--iprint(x,y,z, x + math.cos(math.rad(angle)), y + math.sin(math.rad(angle)), z)
		setMarkerTarget(m, x + math.cos(math.rad(angle)), y + math.sin(math.rad(angle)), z)
		--setElementRotation(e,0,0,angle)
	end
end
--setTimer(render,100,0)
--addEventHandler("onClientPreRender",root,render)