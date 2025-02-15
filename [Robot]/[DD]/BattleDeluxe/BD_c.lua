--setDevelopmentMode(false)
------------------------------------
-- GUI
------------------------------------
guiSetInputMode("no_binds_when_editing")
setCameraClip(true, false)

g_PlayerData = {}

do
	--Terrible workaround to get the label sizes
	loreText1 = 'The year is 2099. The world is consumed by thermonuclear war. A final cluster of survivors breaks up and fights for survival. San Andreas has been able to keep out the storm, but how long can the force field generators last?'
	loreText2 = 'Choose a location to drop. Stay inside the protected zone for your own safety. Have a look around to see what you can find... Alliances can be formed, but remember: trust NOBODY!'

	local test1 = guiCreateLabel ( 0, 0, 10000, 20, loreText1, false)
	local sizeY1 = guiLabelGetTextExtent (test1)
	local test2 = guiCreateLabel ( 0, 0, 10000, 20, loreText2, false)
	local sizeY2 = guiLabelGetTextExtent (test2)

	destroyElement(test1)
	destroyElement(test2)


	--get map size
	local screenWidth, screenHeight = guiGetScreenSize()
	g_MapSide = (screenHeight * 0.85)

	-- set the line height
	h1 = math.ceil(sizeY1/g_MapSide)*16 
	h2 = math.ceil(sizeY2/g_MapSide)*16

	-- adjust the map side with the lore label height
	g_MapSide = g_MapSide - h1 - h2

	local l1 = guiCreateLabel(20,screenHeight/2,   500,20,'Controls:',false)
	local l2 = guiCreateLabel(20,screenHeight/2+20,500,20,'Secondary Fire: toggle driveby',false)
	local l3 = guiCreateLabel(20,screenHeight/2+40,500,20,'Horn: heal when parked (makes noise)',false)

end




-- Create the GUI window
area1 = nil;
function showMap(g_Area)

	--create gui window
	createWindow(wndSetPos)
	showCursor(true)

	-- Draw orange rectangle on map, only the first time with limits passed from serverside
	if not area1 then
		local xr,yr = getElementPosition(radarArea)
		local wr,hr = getRadarAreaSize(radarArea)
		w = math.floor(wr * g_MapSide / 6000)
		h = math.floor(hr * g_MapSide / 6000)
		x = math.floor((xr + wr/2 + 3000) * g_MapSide / 6000) - (w/2)
		y = math.floor((3000 - (yr + hr/2)) * g_MapSide / 6000) - (h/2)

		local mapControl = getControl(wndSetPos, 'map') --get the parent gui window
		guiSetProperty(mapControl, 'AlwaysOnTop', 'true')
		-- area = guiCreateStaticImage(x, y, w, h, 'img/red.png', false, mapControl)
		-- guiSetAlpha(area,0.5)
		-- guiSetEnabled(area,false) --must be disabled otherwise clicks will register on it

		--top
		area1 = guiCreateStaticImage(0, 0, g_MapSide, y, 'img/gameArea.png', false, mapControl)
		guiSetAlpha(area1,0.4)
		guiSetEnabled(area1,false) --must be disabled otherwise clicks will register on it

		--bottom
		area2 = guiCreateStaticImage(0, y+h, g_MapSide, g_MapSide - (y + h), 'img/gameArea.png', false, mapControl)
		guiSetAlpha(area2,0.4)
		guiSetEnabled(area2,false) --must be disabled otherwise clicks will register on it
		
		--right
		area3 = guiCreateStaticImage(x+w, y, g_MapSide - ( x + w ), h, 'img/gameArea.png', false, mapControl)
		guiSetAlpha(area3,0.4)
		guiSetEnabled(area3,false) --must be disabled otherwise clicks will register on it
		
		--left
		area4 = guiCreateStaticImage(0, y, x, h, 'img/gameArea.png', false, mapControl)
		guiSetAlpha(area4,0.4)
		guiSetEnabled(area4,false) --must be disabled otherwise clicks will register on it
		
	end
end
--bindKey('f3', 'down', showMap) -- for testing

addEvent('showClientMap',true)
addEventHandler('showClientMap',  getRootElement(), showMap) --trigger from server

-- set data to nil to reset data if map was played before
setElementData ( localPlayer, "BD.mapPos", { x = nil, y = nil}, true)

-- trigged on window creation
function setPosInit()

	-- set position data to zero
	-- setElementData ( localPlayer, "BD.mapPos", { x = nil, y = nil}, true)

	-- add blips updater
	addEventHandler('onClientRender', root, updatePlayerBlips)

	-- Get the gui window and make sure its always on top (to be in front of the race countdown)
	local map = getControl(wndSetPos, 'map')
	local wnd = getElementParent(map)
	guiSetProperty(wnd,'AlwaysOnTop','True')

	-- Set lore labels to wrap to next line
	local lbl = getControl(wndSetPos, 'lore')
	--outputChatBox(guiLabelGetTextExtent(lbl))
	guiLabelSetHorizontalAlign (lbl, "left", true)
	local lbl2 = getControl(wndSetPos, 'lore2')
	guiLabelSetHorizontalAlign (lbl2, "left", true)

end

-- Draw player position selection in the gui
function updatePlayerBlips()

	if not g_PlayerData then
		return
	end

	-- Get the parent gui map window into which the blips are drawn
	local mapControl = getControl(wndSetPos, 'map')
	
	-- Loop through players
	local players = getElementsByType("player");
	for index, p in ipairs(players) do
		
		--Make blip if there is no blip for the player
		if not g_PlayerData[p] then
			local img = 'img/red.png'
			if (p == localPlayer) then
				img = 'img/green.png'
			end
			g_PlayerData[p] = guiCreateStaticImage(0, 0, 9, 9, img, false, mapControl)
			guiSetEnabled(g_PlayerData[p],false) --do not register clicks
			
			-- Make sure your own blip is on top of enemy blips
			-- Other players can choose to spawn on the same spot because clicks on the blip are not registered
			if (p == localPlayer) then
				guiSetProperty(g_PlayerData[p],"AlwaysOnTop","True")
			end

		end

		--position should be stored absolute, clients can have different size
		local pos = getElementData ( p, "BD.mapPos")
		if pos then 

			if (pos.x == nil) then -- don't show blip if player hasn't selected yet
				guiSetVisible(g_PlayerData[p], false)
			else
				local x = math.floor((pos.x + 3000) * g_MapSide / 6000) - 4 --convert to gui map coords
				local y = math.floor((3000 - pos.y) * g_MapSide / 6000) - 4
				guiSetPosition(g_PlayerData[p], x, y, false) -- update blip position
				guiSetVisible(g_PlayerData[p], true)
			end

		end

	end
end

-- Remove player blip if disconnect after selecting
function onQuitGame( reason )
    if g_PlayerData[source] then
    	guiSetVisible(g_PlayerData[source], false) -- hide blip
    	--g_PlayerData[p] = nil --remove from table
    end
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )


-- Update selection after clicking on the map
function fillInPosition(relX, relY, btn)
	local x = relX*6000 - 3000
	local y = 3000 - relY*6000
	setElementData ( localPlayer, "BD.mapPos", { x = x, y = y}, true)
end

-- Close window called from serverside
function setPosClick()
	closeWindow(wndSetPos)

	smoothDrop()
end
addEvent('closeClientMap',true)
addEventHandler('closeClientMap',  getRootElement(), setPosClick)

-- function calmVehicle(veh)
-- 	if not isElement(veh) then return end
-- 	local z = veh.rotation.z
-- 	veh.velocity = Vector3(0,0,0)
-- 	veh.turnVelocity = Vector3(0,0,0)
-- 	veh.rotation = Vector3(0,0,z)
-- end

function closePositionWindow()
	removeEventHandler('onClientRender', root, updatePlayerBlips)
end

wndSetPos = {
	'wnd',
	text = 'Battle Deluxe',
	width = g_MapSide + 20,
	controls = {
		{'lbl', id ='lore', text=loreText1, width=g_MapSide,  height = h1},
		{'lbl', id ='lore2', text=loreText2, width=g_MapSide, height = h2},
		--{'txt', id='y', width=150},
		{'img', id='map', src='img/map.png', width=g_MapSide, height=g_MapSide, onclick=fillInPosition}, --ondoubleclick=setPosClick},
		--{'lbl', id='z', text='', width=150},
		--{'btn', id='ok', onclick=setPosClick, ClickSpamProtected=true},
		--{'btn', id='cancel', closeswindow=true},
		--{'lbl', text='Right click on map to close'}
	},
	oncreate = setPosInit,
	onclose = closePositionWindow
}

------------------------------------------------------------------------
-- Gameplay
------------------------------------------------------------------------

white = dxCreateTexture("img/white.png")
clientDrawArea = nil
color = tocolor(255,164,0, 150)

-- Received from server, updates where to draw the orange barrier
function updateZoneLimits(g_Area)
	clientDrawArea = g_Area --update new limits on where to draw the orange field
end
addEvent('updateZoneLimits',true)
addEventHandler('updateZoneLimits',  getRootElement(), updateZoneLimits)

function drawBoundary()
	if radarArea then
		--outputChatBox(clientDrawArea.y)
		local w,h = getRadarAreaSize(radarArea)

		local x,y = getElementPosition(radarArea)
		x = x+w/2
		y = y+h/2

		--local w = clientDrawArea.w
		--local h = clientDrawArea.h

		--Top of the box
		dxDrawMaterialLine3D(x-w/2, y+h/2, 0, x+w/2, y+h/2, 0, white, 5000, color, x, y+1, 0) 
		--Bottom of the box
		dxDrawMaterialLine3D(x-w/2, y-h/2, 0, x+w/2, y-h/2, 0, white, 5000, color, x, y-1, 0)
		--Left 
		dxDrawMaterialLine3D(x-w/2, y-h/2, 0, x-w/2, y+h/2, 0, white, 5000, color, x-1, y, 0) 
		--Right
		dxDrawMaterialLine3D(x+w/2, y-h/2, 0, x+w/2, y+h/2, 0, white, 5000, color, x+1, y, 0) 

	end
end
addEventHandler('onClientRender', root, drawBoundary)

weatherID = 0
radarArea = nil
function updateWeather ()
	
	-- Check if the radar Area has been sent
	if not radarArea then
		return
	end

	-- Check if the camera is outside the arena
	local x, y, z, lx, ly, lz = getCameraMatrix ()

	if (isInsideRadarArea ( radarArea, x, y )) then
		
		if (weatherID ~= 0) then --Change weather to nice if not already
			weatherID = 0
			setWeather(weatherID)
			color = tocolor(255,164,0, 150)
			--outputChatBox('normal weather')
		end

	elseif (weatherID ~= 19) then --Camera is outside, set weather to storm if not already
		
		weatherID = 19
		setWeather(weatherID) -- sandstorm
		color = tocolor(255,164,0, 230)
		--outputChatBox('sandstorm weather')

	end

	-- local v = getPedOccupiedVehicle(localPlayer)
	-- local x,y,z = getElementPosition(v)
	-- local hit, _,_,_,_,_,_,_,material = processLineOfSight(x,y,z+1000, x, y, -1000, true, false, false, true)
	-- if hit then
	-- 	--outputChatBox('The floor is at ' .. hitZ)
	-- 	outputChatBox(material)
	-- 	if waterMaterial[material] or isElementInWater(v) then
	-- 		outputChatBox('you are above water!')
	-- 	end
	-- end

end
addEventHandler('onClientRender', root, updateWeather)

function weather(state)
	radarArea = state
end
addEvent('updateWeather',true)
addEventHandler('updateWeather',  getRootElement(), weather)

-- rhino damage
local weaponsToDamageRhino = {
	[38] = true, -- minigun
	[33] = true, -- country rifle
	[34] = true, -- sniper rifle
	[30] = true, -- AK-47
	[31] = true, -- M4
}

function handleRhinoDamage(attacker, weapon, loss, x, y, z, tire)
	if (weapon and getElementModel(source) == 432 and loss > 0) then
		--if (weaponsToDamageRhino[weapon]) then
			setElementHealth(source, getElementHealth(source) - loss)
		--end
	end
end
addEventHandler("onClientVehicleDamage", root, handleRhinoDamage)


--------------------
-- Smooth drop
--------------------
waterMaterial = {[96] = redtrue, [97]=true, [98]=true, [99]=true}

function smoothDrop()

	local v = getPedOccupiedVehicle(localPlayer)
	
	if not v then
		return
	end
	local x,y,z = getElementPosition(v)

	--make sure we dont hit players or vehicles in the line of sight
	hit, hitX,hitY,hitZ,_,_,_,_,material = processLineOfSight(x,y,z+1000, x, y, -1000, true, false, false, true)
	if hit then
		--outputChatBox('The floor is at ' .. hitZ)
		--outputChatBox(material)
		-- if waterMaterial[material] then
		-- 	--outputChatBox('you are above water!')
		-- end
	else
		--outputChatBox('floor not found!, trying again')
		setTimer(smoothDrop,500,1)
		return
	end

	local col = createColCuboid(x-100,y-100,-1000,200,200,1000+hitZ+10)
	addEventHandler("onClientColShapeHit", col, onClientColShapeHit)
end

function onClientColShapeHit( theElement, matchingDimension )
    if getElementType(theElement) == "vehicle" then
    	if getVehicleOccupant(theElement) == localPlayer then

    		destroyElement(source) -- remove the collshape

    		setElementVelocity(theElement,0,0,0)
    		setElementAngularVelocity(theElement,0,0,0)

    -- 		setTimer(function()
    -- 			local matrix = getElementMatrix( theElement )
				-- z = matrix[3][3]
				-- if z < 0.2 then
				-- 	outputChatBox('You are respawned because your vehicle is updside down.',255,0,0)
				-- end
    -- 		end,3000,1)
    	end
	end
end


--Max Height
function setHeliHeight()
	local v = getPedOccupiedVehicle(localPlayer)
	
	if not v then
		return
	end

	local x,y,z = getElementPosition(v)

	hit, hitX,hitY,hitZ = processLineOfSight(x,y,z+1000, x, y, -1000, true, false, false, true)
	
	if hit then
	--make sure we dont hit players or vehicles in the line of sight
		setAircraftMaxHeight(hitZ+30)
	end

end
setTimer(setHeliHeight,1000,0)