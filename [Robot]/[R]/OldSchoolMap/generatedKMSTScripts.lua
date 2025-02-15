local created3DTextElements = {}

pedAnimationBlockToAnimationArrayIndex = {"bar","camera","car","casino","dealer","dildo","gangs","lapdan1","on_lookers","playidles","rapping","smoking","strip"}
pedAnimations = {
	[1] = {"barman_idle"},
	[2] = {"camcrch_idleloop"},
	[3] = {"fixn_car_loop"},
	[4] = {"roulette_loop"},
	[5] = {"dealer_idle"},
	[6] = {"dildo_idle"},
	[7] = {"dealer_idle", "leanidle"},
	[8] = {"lapdan_d", "lapdan_p"},
	[9] = {"lkaround_loop", "lkup_loop", "panic_loop", "wave_loop"},
	[10] = {"shift", "shldr", "stretch", "strleg", "time"},
	[11] = {"laugh_01", "rap_a_loop"},
	[12] = {"f_smklean_loop", "m_smklean_loop", "m_smkstnd_loop", "m_smk_loop"},
	[13] = {"strip_a", "strip_b", "strip_c", "str_loop_a", "str_loop_b", "str_loop_c"}
}

function init()
	
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), init)


------------------------------------	
--------general event handlers------
------------------------------------

function draw3DTextElements()
	for k,element in ipairs(created3DTextElements) do
		if isElement(element) then
			local x = getElementData(element, "posX")
			local y = getElementData(element, "posY")
			local z = getElementData(element, "posZ")
			local drawDistance = tonumber(getElementData(element,"drawdistance"))
			local scale = getElementData(element,"scale")
			local font = getElementData(element,"font")
			local text = getElementData(element,"text")
			local duration = getElementData(element,"duration")*1000
			local r,g,b,a = getColorFromString(getElementData(element, "color"))
			dxDraw3DText(text, x,y,z, scale, font, tocolor(r,g,b,a), drawDistance, true)
		end
	end
end
addEventHandler("onClientRender", getRootElement(), draw3DTextElements)

--------------------------------------------	
---------------utility functions------------
--------------------------------------------

function isMarker(element)
	if type(element) == "userdata" then
		if getElementType(element) == "marker" then
			return true
		end
	end
	return false
end

function removeFromTable(table1, value)
	for k,v in ipairs(table1)do
		if v == value then
			table.remove(table1, k)
			break
		end
	end
end

function dxDraw3DText(text, x, y, z, scale, font, color, maxDistance, colorCoded)
	if not (x and y and z) then
		outputDebugString("dxDraw3DText: One of the world coordinates is missing", 1);
		return false;
	end
	if not (scale) then
		scale = 2;
	end	
	if not (font) then
		font = "default";
	end	
	if not (color) then
		color = tocolor(255, 255, 255, 255);
	end	
	if not (maxDistance) then
		maxDistance = 12;
	end	
	if not (colorCoded) then
		colorCoded = false;
	end
	local pX, pY, pZ = getElementPosition( localPlayer );	
	local distance = getDistanceBetweenPoints3D(pX, pY, pZ, x, y, z);	
	if (distance <= maxDistance) then
		local x, y = getScreenFromWorldPosition(x, y, z);		
		if (x and y) then
			dxDrawText( text, x, y, _, _, color, scale, font, "center", "center", false, false, false, colorCoded);
			return true;
		end
	end
end

function getRepresentation(element,type)
	for i,elem in ipairs(getElementsByType(type,element)) do
		if elem ~= getElementsByType(type, elem) then
			return elem
		end
	end
	return false
end

--is element in table
function table_contains(tableOfElements, element)
	for k, value in ipairs(tableOfElements) do
		if value==element then
			return true
		end
	end
	return false
end

--get animation block name
function getPedAnimationBlockName(animation)
	for k, blockName in ipairs(pedAnimationBlockToAnimationArrayIndex) do
		if table_contains(pedAnimations[k], animation) then
			return blockName
		end
	end
	return nil
end

--------------------------------------------	
---------------element functions------------
--------------------------------------------

function createJump0(player)
	if player ~= localPlayer then
		return
	end
	
	local x = 5557.9375
	local y = -3383.7014160156
	local z = 3.9707999229431
	local markerType = "corona"
	local markerSize = 6
	local r,g,b,a = getColorFromString("#07F79A31")
	local velX = 1.2
	local velY = 0
	local velZ = 0
	
	local marker = createMarker(x,y,z, markerType, markerSize, r,g,b,a)
	
	addEventHandler("onClientMarkerHit", marker, 
		function(hitPlayer)
			if hitPlayer == localPlayer then
				local vehicle = getPedOccupiedVehicle(localPlayer)
				if vehicle then
					setElementVelocity(getPedOccupiedVehicle(localPlayer), velX,velY,velZ)
				else
					setElementVelocity(localPlayer, velX,velY,velZ)
				end
			end
		end)
	
	if isMarker(nil) then
		addEventHandler("onClientMarkerHit", nil, 
			function(hitPlayer)
				if hitPlayer ~= localPlayer then
					return
				end
				destroyElement(marker)
			end, true, "low")
	end
end

if isMarker(nil) then
	addEventHandler("onClientMarkerHit", nil, createJump0, true, "high")
else
	createJump0(localPlayer)
end

function createJump1(player)
	if player ~= localPlayer then
		return
	end
	
	local x = 5850.3798828125
	local y = -3385.2028808594
	local z = 0
	local markerType = "corona"
	local markerSize = 2.25
	local r,g,b,a = getColorFromString("#00F9")
	local velX = 1
	local velY = 0
	local velZ = 1
	
	local marker = createMarker(x,y,z, markerType, markerSize, r,g,b,a)
	
	addEventHandler("onClientMarkerHit", marker, 
		function(hitPlayer)
			if hitPlayer == localPlayer then
				local vehicle = getPedOccupiedVehicle(localPlayer)
				if vehicle then
					setElementVelocity(getPedOccupiedVehicle(localPlayer), velX,velY,velZ)
				else
					setElementVelocity(localPlayer, velX,velY,velZ)
				end
			end
		end)
	
	if isMarker(nil) then
		addEventHandler("onClientMarkerHit", nil, 
			function(hitPlayer)
				if hitPlayer ~= localPlayer then
					return
				end
				destroyElement(marker)
			end, true, "low")
	end
end

if isMarker(nil) then
	addEventHandler("onClientMarkerHit", nil, createJump1, true, "high")
else
	createJump1(localPlayer)
end

