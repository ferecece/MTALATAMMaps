-- movements by dcoy, feel free to copy bois
local objects = {}
local objectsStarts = {}

objects[0] = {
	{model = 1607, sX = 7437, sY = 5809, sZ = 6463, eX = 7416.9409179688 , eY = 5817.5 , eZ = 6474.0825195313, rX = 39.736724853516, rY = 7.8124389648438, rZ = 64., scale = 2},
}  

objects[1] = {
	{model = 901, sX = 7372.7490234375, sY = 5752.4375, sZ = 6015.1201171875, eX = 7884.9130859375, eY = 5879.5122070313, eZ = 5820.5498046875, rX = 0, rY = 0, rZ = 0, scale = 1}, -- first meteor
	{model = 901, sX = 7909.013671875, sY = 5540.6899414063, sZ = 6034.0698242188, eX = 7358.9516601563, eY = 5842.4174804688, eZ = 5869.69921875, rX = 0, rY = 0, rZ = 0, scale = 1}, -- second meteor
	{model = 828, sX = 7900.5239257813, sY = 5605.814453125, sZ = 5785.11328125, eX = 7322.3540039063, eY = 5449.68359375 , eZ = 5761.5634765625, rX = 0, rY = 0, rZ = 0, scale = 12}, -- third meteor
	
	{model = 3438, sX = 7593.44140625, sY = 5724.5966796875, sZ = 5923.67578125, rX = 0, rY = 168.21166992188, rZ = 43.9892578125, scale = 1}, -- circle
	{model = 3438, sX = 7900.5239257813, sY = 5605.814453125, sZ = 5785.11328125, eX = 7322.3540039063, eY = 5449.68359375 , eZ = 5761.5634765625, rX = 0, rY = 0, rZ = 0, scale = 1.9}, -- linked circle third meteor
	{model = 905, sX = 7590, sY = 5700, sZ = 5923, eX = 7624, eY = 5636 , eZ = 5895, rX = 0, rY = 0, rZ = 0, scale = 4}, -- meteor3
}
objects[2] = {
	{model = 901, sX = 7775.2026367188, sY = 5128.5854492188, sZ = 6297.6767578125, eX = 7690.984375, eY = 5622.126953125 , eZ = 5749.7465820313, rX = 0, rY = 0, rZ = 0, scale = 0.3}, -- first meteor
	{model = 901, sX = 7775.2026367188, sY = 5128.5854492188, sZ = 6297.6767578125, eX = 7690.984375, eY = 5622.126953125 , eZ = 5749.7465820313, rX = 0, rY = 0, rZ = 0, scale = 0.6}, -- linked first meteor
	{model = 901, sX = 7749.484375, sY = 5192.837890625, sZ = 6212.95703125, eX = 7543.9233398438, eY = 5657.00390625 , eZ = 5768.6469726563, rX = 0, rY = 0, rZ = 0, scale = 0.7}, -- meteor2
	{model = 3438, sX = 7748, sY = 5357, sZ = 5989, rX = 0, rY = 227.98889160156, rZ = 53.996337890625, scale = 1.8}, -- circle1
	{model = 3438, sX = 7748, sY = 5357, sZ = 5989, rX = 0, rY = 169.98388671875, rZ = 169.99230957031, scale = 1.8}, -- circle2
}

objects[3] = {
	{model = 896, sX = 7626.8041992188, sY = 5056.4799804688, sZ = 6313.6166992188, eX = 7718.3432617188, eY = 5543.607421875 , eZ = 5887.287109375, rX = 0, rY = 0, rZ = 0, scale = 1},
	{model = 896, sX = 7715.1899414063, sY = 5195.6323242188, sZ = 6184.8715820313, eX = 7625.7392578125, eY = 5603.6782226563 , eZ = 5888.2416992188, rX = 0, rY = 0, rZ = 0, scale = 0.6},
}

objects[4] = {
	{model = 1247, sX = 7470, sY = 5261, sZ = 6089, eX = 7895, eY = 5312 , eZ = 6081, rX = 0, rY = 0, rZ = 0, scale = 6},
	{model = 901, sX = 7710, sY = 5496, sZ = 6142, eX = 7811, eY = 4913 , eZ = 6034, rX = 0, rY = 0, rZ = 0, scale = 0.3},
	{model = 901, sX = 7776, sY = 5504, sZ = 6142, eX = 7745, eY = 4854 , eZ = 5878, rX = 0, rY = 0, rZ = 0, scale = 1},
	{model = 3438, sX = 7685, sY = 5209, sZ = 6177, rX = 0, rY = 103, rZ = 93, scale = 0.8}, -- circle1
	{model = 3438, sX = 7784.4208984375, sY = 5212.6142578125, sZ = 6103.8891601563, rX = 0, rY = 171.9775390625, rZ = 93.993530273438, scale = 2}, -- circle2
	{model = 3438, sX = 7784.4208984375, sY = 5212.6142578125, sZ = 6103.8891601563, rX = 0, rY = 53.974365234375, rZ = 93.993530273438, scale = 2}, -- circle3
}

objects[5] = {
	{model = 905, sX = 7677, sY = 5140, sZ = 6018, eX = 8009, eY = 5056 , eZ = 5993, rX = 0, rY = 0, rZ = 0, scale = 12},
	{model = 880, sX = 7727, sY = 5195, sZ = 6048, eX = 7690, eY = 5162 , eZ = 6032, rX = 0, rY = 0, rZ = 0, scale = 0.6},
	{model = 801, sX = 7678.3872070313, sY = 5145.6752929688, sZ = 6013.1059570313, rX = 0, rY = 0, rZ = 352, scale = 4}, -- circle2
}

objects[6] = {
	{model = 906, sX = 7426, sY = 6230, sZ = 6019, eX = 7604, eY = 6216 , eZ = 5891, rX = 0, rY = 0, rZ = 0, scale = 1},
}

-- D
objects[7] = {
	{model = 3437, sX = 7495.6318359375, sY = 4511.4609375, sZ = 5604.9931640625, eX = 7495.6318359375, eY = 4211.4609375 , eZ = 5604.9931640625, rX = 0, rY = 0, rZ = 293.994140625, scale = 1.5},
	{model = 3437, sX = 7495.6333007813, sY = 4511.4438476563, sZ = 5587.3950195313, eX = 7495.6333007813, eY = 4211.4438476563, eZ = 5587.3950195313, rX = 0, rY = 180, rZ = 293.98864746094, scale = 1.5},
	{model = 3437, sX = 7487.8720703125, sY = 4507.9921875, sZ = 5579.3110351563, eX = 7487.8720703125 , eY = 4207.9921875 , eZ = 5579.3110351563, rX = 90, rY = 0, rZ = 293.98864746094, scale = 1.5},
	{model = 3437, sX = 7480.4516601563, sY = 4504.6616210938, sZ = 5587.7309570313, eX = 7480.5786132813 , eY = 4204.4750976563 , eZ = 5587.3950195313, rX = 0, rY = 180, rZ = 293.98864746094, scale = 1.5},
	{model = 3437, sX = 7487.8720703125, sY = 4507.9921875, sZ = 5596.1450195313, eX = 7487.8720703125 , eY = 4207.9921875 , eZ = 5596.1450195313, rX = 90, rY = 0, rZ = 293.98864746094, scale = 1.5},
}  

-- C
objects[8] = {
	{model = 3437, sX = 7426.525390625, sY = 4599.0253906255, sZ = 5599.8520507813, eX = 7426.525390625, eY = 4199.025390625 , eZ = 5599.8520507813, rX = 90, rY = 90, rZ = 53.992309570313, scale = 1.5},
	{model = 3437, sX = 7421.662109375, sY = 4592.365234375, sZ = 5591.4809570313, eX = 7421.662109375, eY = 4192.365234375, eZ = 5591.4809570313, rX = 0, rY = 0, rZ = 323.99230957031, scale = 1.5},
	{model = 3437, sX = 7426.48828125, sY = 4599.2109375, sZ = 5583.0551757813, eX = 7426.48828125 , eY = 4199.2109375 , eZ = 5583.0551757813, rX = 90, rY = 90, rZ = 53.991973876953, scale = 1.5},
}

-- O
objects[9] = {
	{model = 3437, sX = 7376.755859375, sY = 4568.59765625, sZ = 5599.8520507813, eX = 7376.755859375, eY = 4168.59765625, eZ = 5599.8520507813, rX = 90, rY = 90, rZ = 75.986938476563, scale = 1.5},
	{model = 3437, sX = 7378.4921875, sY = 4576.330078125, sZ = 5591.7836914063, eX = 7378.515625, eY = 4176.330078125, eZ = 5591.7836914063, rX = 0, rY = 0, rZ = 343.98742675781, scale = 1.5},
	{model = 3437, sX = 7376.755859375, sY = 4568.59765625, sZ = 5583.3706054688, eX = 7376.755859375, eY = 4168.59765625, eZ = 5583.3706054688, rX = 90, rY = 90, rZ = 75.986938476563, scale = 1.5},
	{model = 3437, sX =7374.17578125, sY = 4560.1552734375, sZ = 5591.52734375, eX = 7374.17578125, eY = 4160.1552734375, eZ = 5591.52734375, rX = 0, rY = 0, rZ = 353.98498535156, scale = 1.5},
}

-- Y
objects[10] = {
	{model = 3437, sX = 7340.666015625, sY = 4520.8642578125, sZ = 5587.9858398438, eX = 7340.666015625, eY = 4120.8642578125, eZ = 5587.9858398438, rX = 0, rY = 0, rZ = 29.981689453125, scale = 1.5},
	{model = 3437, sX = 7340.666015625, sY = 4520.8642578125, sZ = 5570.5278320313, eX = 7340.666015625, eY = 4120.8642578125, eZ = 5570.5278320313, rX = 0, rY = 0, rZ = 29.981689453125, scale = 1.5},
	{model = 3437, sX = 7344.177734375, sY = 4513.455078125, sZ = 5561.9794921875, eX = 7344.177734375, eY = 4113.455078125 , eZ = 5561.9794921875, rX = 90, rY = 90, rZ = 116.74621582031, scale = 1.5},
	{model = 3437, sX = 7344.177734375, sY = 4513.455078125, sZ = 5579.3110351563, eX = 7344.177734375, eY = 4113.455078125 , eZ = 5579.3110351563, rX = 90, rY = 90, rZ = 116.74621582031, scale = 1.5},
	{model = 3437, sX = 7347.91796875, sY = 4506.1435546875, sZ = 5587.6372070313, eX = 7347.91796875, eY = 4106.1435546875, eZ = 5587.6372070313, rX = 0, rY = 0, rZ = 29.989990234375, scale = 1.5},
}

objects[11] = {
	{model = 880, sX = 7386.7700195313, sY = 4109.4448242188, sZ = 5594.2338867188, eX = 7505.5053710938, eY = 4175.1137695313, eZ = 5628.7739257813, rX = 0, rY = 0, rZ = 29.981689453125, scale = 1},
}

objects[12] = {
	{model = 1607, sX = 7329.609375, sY = 3539.0712890625, sZ = 5278.1328125, eX = 7330.5166015625, eY = 3554.5947265625, eZ = 5304.04296875, rX = 48.526611328125, rY = 341.69677734375, rZ = 13.914184570313, scale = 2},
}

objects[13] = {
	{model = 1607, sX = 7325.7158203125, sY = 3616.1958007813, sZ = 5269.3828125, eX = 7293.0830078125, eY = 3596.552734375, eZ = 5291.29296875, rX = 48.526611328125, rY = 341.69677734375, rZ = 123.90933227539, scale = 2},
}

objects[14] = {
	{model = 3437, sX = 7089.580078125, sY = 3919.2392578125, sZ = 5189.88671875, eX = 7189.580078125, eY = 3919.2392578125, eZ = 5189.88671875, rX = 0, rY = 0, rZ = 126.17797851563, scale = 1},
	{model = 3437, sX = 7188.1005859375, sY = 3920.7568359375, sZ = 5294.5302734375, eX = 7188.1005859375, eY = 3920.7568359375, eZ = 5194.5302734375, rX = 0, rY = 90, rZ = 129.92431640625, scale = 1},
	{model = 3437, sX = 7283.220703125, sY = 3925.966796875, sZ = 5193.4907226563, eX = 7183.220703125, eY = 3925.966796875, eZ = 5193.4907226563, rX = 0, rY = 0, rZ = 126.17797851563, scale = 1},
	{model = 3437, sX = 7184.697265625, sY = 3924.34765625, sZ = 5088.2172851563, eX = 7184.697265625, eY = 3924.34765625, eZ = 5188.2172851563, rX = 0, rY = 90, rZ = 129.91879272461, scale = 1},
}

local markers = {}
local createdObjects = {}

function createMoveableObjects(ID)
	createdObjects[tonumber(ID)] = {}
	for i, k in ipairs(objects[tonumber(ID)]) do
		local newObject = createObject(k.model, k.sX, k.sY, k.sZ, k.rX, k.rY, k.rZ)
		createdObjects[tonumber(ID)][i] = newObject
		setElementDoubleSided ( newObject, true )
		if k.scale ~= 1 then
			setObjectScale(newObject, k.scale) -- specific exception for the end move, I could do something cleaner but got lazy
		end
		if ID == 14 then
			 setElementCollisionsEnabled(newObject, false)
		end
	end
end

function restartMovementsByID (ID)
	for i, k in ipairs(createdObjects[tonumber(ID)]) do
		destroyElement(createdObjects[tonumber(ID)][i])
	end
	createMoveableObjects(ID)
end



function restartMovementsByID (ID)
	for i, k in ipairs(createdObjects[tonumber(ID)]) do
		destroyElement(createdObjects[tonumber(ID)][i])
	end
	createMoveableObjects(ID)
end

function restartMovements ()
	for i, k in ipairs(createdObjects) do
		for key, value in ipairs(k) do
			destroyElement(value)
		end
		createMoveableObjects(i)
	end
end


-- Initialize markers, create movable objects, add event handler on those markers
function movementsInit()
	--First marker generation
	markers[0] = createMarker(7482.2680664063, 5760.6586914063, 6502.8720703125, "corona", 5, 255, 255, 255, 0)
	markers[1] = createMarker(7583.9565429688, 5954.3715820313, 5888.0483398438, "corona", 5, 255, 255, 255, 0)
	markers[2] = createMarker(7633.3276367188, 5622.9370117188, 5850.2182617188, "corona", 5, 255, 255, 255, 0)
	markers[3] = createMarker(7659.1474609375, 5493.6416015625, 5904.6083984375, "corona", 5, 255, 255, 255, 0)
	markers[4] = createMarker(7670.263671875, 5438.5317382813, 5950.1381835938, "corona", 5, 255, 255, 255, 0)
	markers[5] = createMarker(7686.9130859375, 5347.2661132813, 6025.1611328125, "corona", 5, 255, 255, 255, 0)
	markers[6] = createMarker(7380.0786132813, 6063.3408203125,  6070.638671875, "corona", 5, 255, 255, 255, 0)
	markers[7] = createMarker(7554.2709960938, 4060.3972167969, 5664.2846679688, "corona", 5, 255, 255, 255, 0)
	markers[8] = createMarker(7435.8266601563, 3559.2180175781, 5324.4794921875, "corona", 5, 255, 255, 255, 0)
	markers[9] = createMarker(7387.6220703125, 3558.4489746094, 5313.2294921875, "corona", 5, 255, 255, 255, 0)
	markers[10] = createMarker(7218.4697265625, 3947.552734375, 5156.0395507813, "corona", 5, 255, 255, 255, 0)
	
	-- create objects
	createMoveableObjects(0)
	createMoveableObjects(1)
	createMoveableObjects(2)
	createMoveableObjects(3)
	createMoveableObjects(4)
	createMoveableObjects(5)
	createMoveableObjects(6)
	createMoveableObjects(7)
	createMoveableObjects(8)
	createMoveableObjects(9)
	createMoveableObjects(10)
	createMoveableObjects(11)
	createMoveableObjects(12)
	createMoveableObjects(13)
	createMoveableObjects(14)
	
	-- event handler on created markers
	addEventHandler("onClientMarkerHit", markers[0], dolphinMove)
	addEventHandler("onClientMarkerHit", markers[1], startMovements1)
	addEventHandler("onClientMarkerHit", markers[2], restartMovements)
	addEventHandler("onClientMarkerHit", markers[2], startMovements2)
	addEventHandler("onClientMarkerHit", markers[3], startMovements3)
	addEventHandler("onClientMarkerHit", markers[4], startMovements4)
	addEventHandler("onClientMarkerHit", markers[5], startMovements5)
	addEventHandler("onClientMarkerHit", markers[6], startMovements6)
	addEventHandler("onClientMarkerHit", markers[7], moveDLetter)
	addEventHandler("onClientMarkerHit", markers[8], dolphinMove2)
	addEventHandler("onClientMarkerHit", markers[9], dolphinMove3)
	addEventHandler("onClientMarkerHit", markers[10], endMove)
end

addEventHandler("onClientResourceStart", resourceRoot, movementsInit)


function dolphinMove(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 0
		if source == markers[IDX] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, -35, 0, 0 )
			setTimer ( moveObject, 1000, 1, createdObjects[IDX][1], 1000, 7387.4653320313, 5821.212890625, 6464.0825195313, -45, 0, 0 )
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 2000, 1, IDX)
		end
	end
end

function dolphinMove2(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 12
		if source == markers[8] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 250, k.eX, k.eY, k.eZ, 0, 0, 45)
			
			setTimer ( moveObject, 250, 1, createdObjects[IDX][1], 500, 7333.599609375, 3575.0151367188, 5313.8627929688, -50, 90,45)
			setTimer ( moveObject, 750, 1, createdObjects[IDX][1], 500, 7340.615234375, 3598.3239746094, 5303.8627929688, -36, 90, 45)
			setTimer ( moveObject, 1250, 1, createdObjects[IDX][1], 500, 7349.2700195313, 3624.58984375, 5275.052734375, -24, 90, 45)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 2000, 1, IDX)
		end
	end
end

function dolphinMove3(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 13
		if source == markers[9] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, -45, 0, 0)
		
			setTimer ( moveObject, 950, 1, createdObjects[IDX][1], 1000, 7242.9404296875, 3579.6257324219, 5268.79296875, -45, 0, 0)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 2000, 1, IDX)
		end
	end
end

function startMovements1(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 1
		if source == markers[IDX] then
			attachElements (createdObjects[IDX][5], createdObjects[IDX][3], 0, 0, 0, 0, 720, 0)
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 3000, k.eX, k.eY, k.eZ, 360, 720, 180) --meteor1
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 6000, k.eX, k.eY, k.eZ, 360, 360, 180) --meteor2
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 8000, k.eX, k.eY, k.eZ, 720, 360, 180) --meteor3
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 8000, k.eX, k.eY, k.eZ, 0, 720, 0) --circle1
			k = objects[IDX][6]
			moveObject ( createdObjects[IDX][6], 10000, k.eX, k.eY, k.eZ, 0, 720, 0) --meteor4
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 10000, 1, IDX)
		end
	end
end

function startMovements2(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 2
		if source == markers[IDX] then
			local k = objects[IDX][1]
			attachElements (createdObjects[IDX][2], createdObjects[IDX][1], 10, 0, 0, 0, 0, 0)
			moveObject ( createdObjects[IDX][1], 4000, k.eX, k.eY, k.eZ, 360, 720, 180) --meteor1
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 6000, k.eX, k.eY, k.eZ, 720, 0, 360) --meteor2
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 10000, k.sX, k.sY, k.sZ, 0, 360, 0) --circle1
			k = objects[IDX][5]
			moveObject ( createdObjects[IDX][5], 10000, k.sX, k.sY, k.sZ, 0, 720, 0) --circle2
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 10000, 1, IDX)
		end
	end
end

function startMovements3(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 3
		if source == markers[IDX] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 4000, k.eX, k.eY, k.eZ, 360, 720, 180) --meteor1
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 5000, k.eX, k.eY, k.eZ, 0, 720, 0) --meteor2
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 5000, 1, IDX)
		end
	end
end

function startMovements4(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 4
		if source == markers[IDX] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, 0, 0, 0) -- star
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 8000, k.eX, k.eY, k.eZ, 360, 720, 0) -- meteor
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 7000, k.eX, k.eY, k.eZ, 360, 720, 0) -- meteor
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 8000, k.sX, k.sY, k.sZ, 0, 360, 0) --circle1
			k = objects[IDX][5]
			moveObject ( createdObjects[IDX][5], 8000, k.sX, k.sY, k.sZ, 0, -720, 0) --circle2
			k = objects[IDX][6]
			moveObject ( createdObjects[IDX][6], 8000, k.sX, k.sY, k.sZ, 0, 360, 0) --circle3
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 8000, 1, IDX)
		end
	end
end

function startMovements5(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 5
		if source == markers[IDX] then
			attachElements (createdObjects[IDX][3], createdObjects[IDX][1], 0, 0, -10, 0, 0, 0)
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 8000, k.eX, k.eY, k.eZ, 360, 1440, 0) -- meteor1
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 8000, k.eX, k.eY, k.eZ, 360, 720, 0) -- meteor2
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 10000, 1)
		end
	end
end

function startMovements6(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 6
		if source == markers[IDX] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 14000, k.eX, k.eY, k.eZ, 360, 720, 360) -- meteor1
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 14000, 1, IDX)
		end
	end
end

function moveDLetter(hitElement)
	if (hitElement == localPlayer) then
		startMovements7(hitElement)
		local IDX = 7
		if source == markers[IDX] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][1], 2000, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 1100, k.eX, k.eY, k.eZ, 360, 360, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][2], 2100, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 1200, k.eX, k.eY, k.eZ, 720, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][3], 2200, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 1300, k.eX, k.eY, k.sZ, 360, 720, 0)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][4], 2300, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][5]
			moveObject ( createdObjects[IDX][5], 1400, k.eX, k.eY, k.eZ, 0, 720, 0)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][5], 2400, k.sX, k.sY, k.sZ, 360, 0, 180)
			
			setTimer (moveCLetter, 750, 1, hitElement)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 5000, 1, IDX)
		end
	end
end

function moveCLetter(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 8
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][1], 2000, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 1100, k.eX, k.eY, k.eZ, 360, 360, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][2], 2100, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 1200, k.eX, k.eY, k.eZ, 720, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][3], 2200, k.sX, k.sY, k.sZ, 360, 0, 180)
			
			setTimer (moveOLetter, 750, 1, hitElement)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 5000, 1, IDX)
	end
end

function moveOLetter(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 9
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][1], 2000, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 1100, k.eX, k.eY, k.eZ, 360, 360, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][2], 2100, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 1200, k.eX, k.eY, k.eZ, 720, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][3], 2200, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 1300, k.eX, k.eY, k.sZ, 360, 720, 0)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][4], 2300, k.sX, k.sY, k.sZ, 360, 0, 180)
			
			setTimer (moveYLetter, 750, 1, hitElement)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 5000, 1, IDX)
	end
end

function moveYLetter(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 10
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 1000, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][1], 2000, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 1100, k.eX, k.eY, k.eZ, 360, 360, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][2], 2100, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 1200, k.eX, k.eY, k.eZ, 720, 0, 180)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][3], 2200, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 1300, k.eX, k.eY, k.sZ, 360, 720, 0)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][4], 2300, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][5]
			moveObject ( createdObjects[IDX][5], 1400, k.eX, k.eY, k.sZ, 360, 720, 0)
			setTimer (moveObject , 2100, 1, createdObjects[IDX][5], 2300, k.sX, k.sY, k.sZ, 360, 0, 180)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 5000, 1, IDX)
	end
end

function startMovements7(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 11
		local k = objects[IDX][1]
		moveObject ( createdObjects[IDX][1], 10000, k.eX, k.eY, k.eZ, 360, 720, 360) -- meteor1
		-- set a timer so the to make objects disappear
		setTimer ( restartMovementsByID, 10000, 1, IDX)
	end
end

function endMove(hitElement)
	if (hitElement == localPlayer) then
		local IDX = 14
		if source == markers[10] then
			local k = objects[IDX][1]
			moveObject ( createdObjects[IDX][1], 900, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 1200, 1, createdObjects[IDX][1], 900, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][2]
			moveObject ( createdObjects[IDX][2], 950, k.eX, k.eY, k.eZ, 360, 360, 180)
			setTimer (moveObject , 1250, 1, createdObjects[IDX][2], 1000, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][3]
			moveObject ( createdObjects[IDX][3], 1000, k.eX, k.eY, k.eZ, 360, 0, 180)
			setTimer (moveObject , 1300, 1, createdObjects[IDX][3], 1100, k.sX, k.sY, k.sZ, 360, 0, 180)
			k = objects[IDX][4]
			moveObject ( createdObjects[IDX][4], 1050, k.eX, k.eY, k.eZ, 720, 0, 180)
			setTimer (moveObject , 1350, 1, createdObjects[IDX][4], 1200, k.sX, k.sY, k.sZ, 360, 0, 180)
			-- set a timer so the to make objects disappear
			setTimer ( restartMovementsByID, 3000, 1, IDX)
		end
	end
end

addEventHandler ( "onClientPlayerWasted", localPlayer, restartMovements )