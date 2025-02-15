--------------
-- vehicles --
--------------


addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		for i,vehicle in ipairs (getElementsByType ("vehicle")) do
			if not getVehicleController (vehicle) then
				setVehicleOverrideLights (vehicle, 2)
				setVehicleEngineState (vehicle, true)
				setVehicleSirensOn (vehicle, true) 
				setElementData (vehicle, "race.collideothers", 1)
			end
		end
	end
)


-----------
--Workers--
-----------

--1
wobj01 = createObject (1337, 1640, 985, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (wobj01, false)
	setObjectScale (wobj01, 0)
worker01 = createPed (260, 1640, 985, 10.82)
	setElementCollisionsEnabled (worker01, false)
	attachElements (worker01, wobj01, 0, 0, 0, 0, 0, 0)
box01 = createObject (2912, 1640, 985, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (box01, false)
	attachElements(box01, worker01, 0, 0.5, 0.1, 0, 0, 0)
	setPedAnimation (worker01, "ped", "WALK_csaw", nil, true, true, true)

function startPedMove01 ()
	moveObject (wobj01, 8000, 1640, 1005, 10.82, 0, 0, 0)
	setTimer (setElementRotation, 8000, 1, wobj01, 0, 0, 270)
	setTimer (pedMove01_1, 8000, 1)
end
addEventHandler ("onClientResourceStart", resourceRoot, startPedMove01)

	function pedMove01_1 ()
		moveObject (wobj01, 18000, 1690, 1005, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 18000, 1, worker01, 0, 0, 180)
		setTimer (pedMove01_2, 18000, 1)
	end

	function pedMove01_2 ()
		moveObject (wobj01, 8000, 1690, 985, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker01, 0, 0, 90)
		setTimer (pedMove01_3, 8000, 1)
	end

	function pedMove01_3 ()
		moveObject (wobj01, 18000, 1640, 985, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 18000, 1, worker01, 0, 0, 0)
		setTimer (pedMove01_4, 18000, 1)
	end

	function pedMove01_4 ()
		moveObject (wobj01, 8000, 1640, 1005, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker01, 0, 0, 270)
		setTimer (pedMove01_1, 8000, 1)
	end

--2
wobj02 = createObject (1337, 1690, 1005, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (wobj02, false)
	setObjectScale (wobj02, 0)
worker02 = createPed (27, 1690, 1005, 10.82)
	setElementCollisionsEnabled (worker02, false)
	attachElements (worker02, wobj02, 0, 0, 0, 0, 0, 0)
	setElementRotation (worker02, 0, 0, 180)
box02 = createObject (2912, 1690, 1005, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (box02, false)
	attachElements(box02, worker02, 0, 0.5, 0.1, 0, 0, 0)
	setPedAnimation (worker02, "ped", "WALK_csaw", nil, true, true, true)

function startPedMove02 ()
	moveObject (wobj02, 8000, 1690, 985, 10.82, 0, 0, 0)
	setTimer (setElementRotation, 8000, 1, wobj02, 0, 0, 90)
	setTimer (pedMove02_1, 8000, 1)
end
addEventHandler ("onClientResourceStart", resourceRoot, startPedMove02)

	function pedMove02_1 ()
		moveObject (wobj02, 18000, 1640, 985, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 18000, 1, worker02, 0, 0, 0)
		setTimer (pedMove02_2, 18000, 1)
	end

	function pedMove02_2 ()
		moveObject (wobj02, 8000, 1640, 1005, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker02, 0, 0, 270)
		setTimer (pedMove02_3, 8000, 1)
	end

	function pedMove02_3 ()
		moveObject (wobj02, 18000, 1690, 1005, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 18000, 1, worker02, 0, 0, 180)
		setTimer (pedMove02_4, 18000, 1)
	end

	function pedMove02_4 ()
		moveObject (wobj02, 8000, 1690, 985, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker02, 0, 0, 90)
		setTimer (pedMove02_1, 8000, 1)
	end

--3
wobj03 = createObject (1337, 1051, 1727, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (wobj03, false)
	setObjectScale (wobj03, 0)
worker03 = createPed (27, 1051, 1727, 10.82)
	setElementCollisionsEnabled (worker03, false)
	attachElements (worker03, wobj03, 0, 0, 0, 0, 0, 0)
	setElementRotation (worker03, 0, 0, 0)
box03 = createObject (2912, 1051, 1727, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (box03, false)
	attachElements(box03, worker03, 0, 0.5, 0.1, 0, 0, 0)
	setPedAnimation (worker03, "ped", "WALK_csaw", nil, true, true, true)

function startPedMove03 ()
	moveObject (wobj03, 8000, 1051, 1745, 10.82, 0, 0, 0)
	setTimer (setElementRotation, 8000, 1, wobj03, 0, 0, 90)
	setTimer (pedMove03_1, 8000, 1)
end
addEventHandler ("onClientResourceStart", resourceRoot, startPedMove03)

	function pedMove03_1 ()
		moveObject (wobj03, 8000, 1030, 1745, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker03, 0, 0, 270)
		setTimer (pedMove03_2, 8000, 1)
	end

	function pedMove03_2 ()
		moveObject (wobj03, 8000, 1051, 1745, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker03, 0, 0, 180)
		setTimer (pedMove03_3, 8000, 1)
	end

	function pedMove03_3 ()
		moveObject (wobj03, 8000, 1051, 1727, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker03, 0, 0, 0)
		setTimer (pedMove03_4, 8000, 1)
	end

	function pedMove03_4 ()
		moveObject (wobj03, 8000, 1051, 1745, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 8000, 1, worker03, 0, 0, 90)
		setTimer (pedMove03_1, 8000, 1)
	end

--4
wobj04 = createObject (1337, 1054, 2087, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (wobj04, false)
	setObjectScale (wobj04, 0)
worker04 = createPed (260, 1054, 2087, 10.82)
	setElementCollisionsEnabled (worker04, false)
	attachElements (worker04, wobj04, 0, 0, 0, 0, 0, 0)
	setElementRotation (worker04, 0, 0, 270)
box04 = createObject (2912, 1054, 2087, 10.82, 0, 0, 0)
	setElementCollisionsEnabled (box04, false)
	attachElements(box04, worker04, 0, 0.5, 0.1, 0, 0, 0)

doorobj04 = createObject (10184, 1055.77, 2087.55, 12.346, 0, 0, 0)

startPedMove04col = createColPolygon (0, 0, 997, 2280, 997, 2275, 1018, 2275, 1018, 2280)
function startPedMove04 (theElement, matchingDimensions)
	if theElement == getLocalPlayer() then

		doorMove04_1 ()
	end
end
addEventHandler("onClientColShapeHit", startPedMove04col, startPedMove04)

	function doorMove04_1 ()
		moveObject (doorobj04, 5000, 1055.77, 2087.55, 15.98, 0, 0, 0)
		setTimer (pedMove04_2, 3000, 1)
	end

	function pedMove04_2 ()
		setPedAnimation (worker04, "ped", "WALK_csaw", nil, true, true, true)
		moveObject (wobj04, 6000, 1065, 2087, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 6000, 1, worker04, 0, 0, 90)
		setTimer (pedMove04_3, 6000, 1)
	end

	function pedMove04_3 ()
		moveObject (wobj04, 6000, 1054, 2087, 10.82, 0, 0, 0)
		setTimer (setElementRotation, 6000, 1, worker04, 0, 0, 270)
		setTimer (setPedAnimation, 6000, 1, worker04, "ped", "IDLE_csaw", nil, true, true, true)
		setTimer (doorMove04_4, 6000, 1)
	end

	function doorMove04_4 ()
		moveObject (doorobj04, 5000, 1055.77, 2087.55, 12.346, 0, 0, 0)
		setTimer (doorMove04_1, 7000, 1)
	end

--------------
--LOD script--
--------------

    local models = {
			[3286] = true,
			[3498] = true,
			[3863] = true,
			[3785] = true
    }
     
    addEventHandler("onClientResourceStart",resourceRoot,
            function()
                    for i,object in ipairs (getElementsByType("object")) do
                            local model = getElementModel(object)
                            if models[model] then
                                    local x,y,z = getElementPosition(object)
                                    local a,b,c = getElementRotation(object)
                                    local lodobject = createObject(model,x,y,z,a,b,c,true)
                                    setElementDimension(lodobject,getElementDimension(object))
                                    setObjectScale(lodobject,getObjectScale(object))
                                    setLowLODElement(object,lodobject)
                                    engineSetModelLODDistance(model,45)
                            end
                    end
            end
    )
