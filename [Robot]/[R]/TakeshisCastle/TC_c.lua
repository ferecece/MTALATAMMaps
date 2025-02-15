function replace()
	kappa = engineLoadTXD ("cj_don_sign.txd")
	engineImportTXD( kappa , 2715)
end
addEventHandler("onClientResourceStart",getRootElement(), replace)

-----------
--Obstacle 1: Knock Knock
-----------
function unbreak(gates,easy,block)
	if easy then --only block one gate
		local obj1,obj2 = gates[block][1],gates[block][2]
		setObjectBreakable(obj1,false)
		setObjectBreakable(obj2,false)
	else --block all gates but one
		for i=1,4 do
			if (i~=block) then
				local obj1,obj2 = gates[i][1],gates[i][2]
				setObjectBreakable(obj1,false)
				setObjectBreakable(obj2,false)
			end
		end
	end
end
addEvent("setUnbreakable",true)
addEventHandler("setUnbreakable",getResourceRootElement(),unbreak)

----------------
-- Obstacle 2: fallout tiles
----------------
function drawTilesHandler(path,tiles)
	---------
	--Displaying Path
	---------
	local display = getElementByID("display") --display tower
	local d_x,d_y,d_z = getElementPosition(display)
	local xoffset = 3.5 --offsets of the tower to the corner of the black display area
	local yoffset = 6
	local zoffset = 7.3
	
	-- position offsets
	ywidth = yoffset*2/5 --globally defined because its needed in the dxdraw functions
	local zwidth = zoffset*2/5
	local ystart = d_y + 2*ywidth
	local zstart = d_z - 2.5*zwidth
	
	----------
	--Active Pathing
	----------
	render = {}
	colRects = {}
	activeCol = {}
	local a = 1
	local x,y = 620.5,-2086.5 -- starting posistion for colshape (1,1)
	for i=1,5 do --loop through all the tiles
		for j=1,5 do

			--put all of the coordinates for the drawn squares of the path display in a table
			render[a]={path[i][j],d_x-xoffset,ystart-(j-1)*ywidth,zstart+0.1+(i-1)*zwidth,d_x-xoffset,ystart-(j-1)*ywidth,zstart-0.1+i*zwidth}
			a=a+1
			
			-- create collision recrangles to keep track of player movement
			local xCol,yCol = x+(i-1)*9,y-(j-1)*9
			local col = createColRectangle(xCol,yCol,9,9)
			
			-- create the start and end coordinates of the squares drawn when hitting a colshpape (squares when driving)
			colRects[col]={path[i][j],xCol+2,yCol+4.5,146.7,xCol+7,yCol+4.5,146.7}
		end
	end
	addEventHandler("onClientRender",root,drawSquares) --draw the squares every frame
end
addEvent("drawTiles",true)
addEventHandler("drawTiles",getResourceRootElement(),drawTilesHandler)


local red = dxCreateTexture("red.png")
local green = dxCreateTexture("green.png")
function drawSquares() --draw the display squares and active path squares
	-- display
	for i=1,25 do
		local color,startX,startY,startZ,endX,endY,endZ = unpack(render[i])
		if color then
			dxDrawMaterialLine3D(startX,startY,startZ,endX,endY,endZ,green,ywidth-0.2,tocolor(0,255,0,255),startX+1,startY,startZ)
		else
			dxDrawMaterialLine3D(startX,startY,startZ,endX,endY,endZ,red,ywidth-0.2,tocolor(255,255,255,255),startX+1,startY,startZ)
		end
	end

	-- active path
	for index,theCol in pairs (activeCol) do
		local color,startX,startY,startZ,endX,endY,endZ = unpack(theCol)
		if color then
			dxDrawMaterialLine3D(startX,startY,startZ,endX,endY,endZ,green,6,tocolor(0,255,0,255),startX,startY,startZ-1)
		else
			dxDrawMaterialLine3D(startX,startY,startZ,endX,endY,endZ,red,6,tocolor(255,255,255,255),startX,startY,startZ-1)
		end
	end
end

-- add a square to the active path display when the coresponding colshape is hit
function onClientColShapeHit(theElement)
    if ( theElement == localPlayer) then  -- Checks whether the entering element is the local player
		if colRects[source] then --if the collshape that is hit coresponds to a tile
			table.insert(activeCol,colRects[source])
		end
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),onClientColShapeHit)

-- remove the active path on respawn
function clearPath ( )
	activeCol={}
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), clearPath )

----------------
--Obstacle 4: Avalanche
----------------
addEventHandler("onClientVehicleCollision", root,
    function(collider,force, bodyPart, x, y, z, nx, ny, nz,hitelementforce,model)
         if ( source == getPedOccupiedVehicle(localPlayer) ) and (model == 1305) then
			blowVehicle(source)  -- blow the vehicle if it gets hit by a rock
         end
    end
)