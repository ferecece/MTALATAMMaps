--
-- c_objects.lua
--

local objs = {
        { pos={429.402, -2046.22, 2140.785}, rot={0, 0, 0}, model=16289, isAlpha = false, isRot = false },
        { pos={429.402, -2046.22, 2140.785}, rot={0, 0, 0}, model=16290, isAlpha = true, isRot = false },
        { pos={689.394, -1996.45, 2167.206}, rot={0, 0, 0}, model=16291, isAlpha = false, isRot = false },
        { pos={689.394, -1996.45, 2167.206}, rot={0, 0, 0}, model=16292, isAlpha = true, isRot = false },
        { pos={909.920, -1972.15, 2212.776}, rot={0, 0, 0}, model=16293, isAlpha = false, isRot = false },
        { pos={909.920, -1972.15, 2212.776}, rot={0, 0, 0}, model=16294, isAlpha = true, isRot = false },
        { pos={1007.56, -2078.44, 2181.622}, rot={0, 0, 0}, model=16295, isAlpha = false, isRot = false },
        { pos={1007.56, -2078.44, 2181.622}, rot={0, 0, 0}, model=16296, isAlpha = true, isRot = false },
        { pos={910.588, -2304.85, 2129.259}, rot={0, 0, 0}, model=16297, isAlpha = false, isRot = false },
        { pos={910.588, -2304.85, 2129.259}, rot={0, 0, 0}, model=16298, isAlpha = true, isRot = false },
        { pos={752.381, -2389.90, 2137.100}, rot={0, 0, 0}, model=16299, isAlpha = false, isRot = false },
        { pos={752.381, -2389.90, 2137.100}, rot={0, 0, 0}, model=16300, isAlpha = true, isRot = false },
        { pos={640.111, -2501.65, 2063.5107}, rot={0, 0, 0}, model=16301, isAlpha = false, isRot = false }, 
        { pos={640.111, -2501.65, 2063.5110}, rot={0, 0, 0}, model=16302, isAlpha = true, isRot = false },
        { pos={434.470, -2566.17, 2066.0900}, rot={0, 0, 0}, model=16304, isAlpha = false, isRot = false },
        { pos={434.470, -2566.17, 2066.0900}, rot={0, 0, 0}, model=16305, isAlpha = true, isRot = false },
        { pos={142.670, -2545.61, 2093.2100}, rot={0, 0, 0}, model=16306, isAlpha = false, isRot = false },
        { pos={142.670, -2545.61, 2093.2100}, rot={0, 0, 0}, model=16307, isAlpha = true, isRot = false },
        { pos={110.920, -2308.59, 2097.4214}, rot={0, 0, 0}, model=16309, isAlpha = false, isRot = false },
        { pos={110.920, -2308.59, 2097.4210}, rot={0, 0, 0}, model=16310, isAlpha = true, isRot = false },
        { pos={144.339, -2076.64, 2147.295}, rot={0, 0, 0}, model=16311, isAlpha = false, isRot = false },
        { pos={144.339, -2076.64, 2147.295}, rot={0, 0, 0}, model=16312, isAlpha = true, isRot = false },
        { pos={873.375, -2039.43, 2280.880}, rot={0, 0, 0}, model=16313, isAlpha = false, isRot = true  },
        { pos={599.999, -2042.53, 2143.358}, rot={0, 0, 0}, model=16314, isAlpha = false, isRot = true  },
        { pos={246.394, -1996.17, 2133.342}, rot={0, 0, 0}, model=16315, isAlpha = false, isRot = true  },
        { pos={429.402, -2046.22, 2140.785}, rot={0, 0, 0}, model=16316, isAlpha = true, isRot = false },
        { pos={429.402, -2046.22, 2140.785}, rot={0, 0, 0}, model=16317, isAlpha = true, isRot = false },
        { pos={804.719, -1902.968, 2164.669}, rot={0, 0, 0}, model=16318, isAlpha = false, isRot = false }
	}

local dataTable = {txd = nil, dff = {}, col = {}, obj = {}, lowLod = {}} 
local textureArchive = nil 		
		
		
function loadModels()
	dataTable.txd = engineLoadTXD('img/stillwater.txd')
	for i,obj in ipairs(objs) do
		-- TXD
		engineImportTXD(dataTable.txd, obj.model)
		-- COL
		dataTable.col[i] = engineLoadCOL(('img/stillwater_%02d.col'):format(i))
		engineReplaceCOL(dataTable.col[i], obj.model )
		-- DFF
		dataTable.dff[i] = engineLoadDFF(('img/stillwater_%02d.dff'):format(i), obj.model)
		engineReplaceModel(dataTable.dff[i], obj.model, obj.isAlpha )
		engineSetModelLODDistance(obj.model, 475)					
	end
end

function unloadModels()
	for n,obj in ipairs(objs) do 
		if dataTable.dff[n] then
			engineRestoreModel ( obj.model )
			destroyElement( dataTable.dff[n])
			dataTable.dff[n] = nil
		end
		if dataTable.col[n] then
			engineRestoreCOL ( obj.model )
			destroyElement( dataTable.col[n])
			dataTable.col[n] = nil
		end
	end
	
	if dataTable.txd then
		destroyElement( dataTable.txd)
		dataTable.txd = nil
	end
end

function loadMap()
	local farClip = math.min(getFarClipDistance() + 250, 500)
	local nearClip = 200
	for i,obj in ipairs(objs) do
		dataTable.obj[i] = createObject(obj.model, obj.pos[1], obj.pos[2], obj.pos[3], obj.rot[1], obj.rot[2], obj.rot[3])
		if not obj.isAlpha then
			dataTable.lowLod[i] = createObject(obj.model, obj.pos[1], obj.pos[2], obj.pos[3], obj.rot[1], obj.rot[2], obj.rot[3], true)
			setElementInterior(dataTable.lowLod[i], 1)
			obj.lodTimer = setTimer ( function()
				switchLodObjects(dataTable.obj[i], dataTable.lowLod[i], nearClip, farClip)
			end, 500, 0 )
		end
		if obj.isRot then
			obj.rotEvent = function()
				setElementRotation(dataTable.obj[i], 0, 0, -(getTickCount()/10) % 360)
				if dataTable.lowLod[i] then
					setElementRotation(dataTable.lowLod[i], 0, 0, -(getTickCount()/10) % 360)
				end
			end
			addEventHandler('onClientPreRender', root, obj.rotEvent)
		end
	end
end
	
lodSwitch = false
function switchLodObjects(objElement, lodElement, minDist, maxDist)
	if not lodSwitch then return end
	local camX, camY, camZ = getCameraMatrix()
	local posX, posY, posZ = getElementPosition(objElement)
	local curDist = getDistanceBetweenPoints3D ( camX, camY, camZ, posX, posY, posZ )

	if curDist >= minDist and curDist < maxDist then
		setElementInterior(lodElement , 0)
		setElementInterior(objElement , 1)		
	else
		setElementInterior(lodElement , 1)
		setElementInterior(objElement , 0)	
	end
end

function removeLod()
	lodSwitch = false
	for i,obj in ipairs(objs) do
		if not obj.isAlpha then
			setElementInterior(dataTable.lowLod[i], 1)
			setElementInterior(dataTable.obj[i], 0)
		end
	end
end

function applyLod()
	lodSwitch = true
end
		
function unloadMap()
	for i,obj in ipairs(objs) do
		if obj.isRot then
			removeEventHandler('onClientPreRender', root, obj.rotEvent)
		end		
		if not obj.isAlpha then
			if isTimer(obj.lodTimer) then
				killTimer(obj.lodTimer)
			end
			destroyElement(dataTable.lowLod[i])
			dataTable.lowLod[i] = nil
		end
		destroyElement(dataTable.obj[i])
		dataTable.obj[i] = nil	
	end
end
