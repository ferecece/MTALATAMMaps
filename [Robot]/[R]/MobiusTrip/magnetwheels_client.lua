function clientRender()
	for index,item in ipairs (g_drawTable) do
		dxDrawMaterialLine3D(item[1],item[2],item[3],item[4],item[5],item[6],image,7,tocolor(255,255,255,255),item[7],item[8],item[9])
	end
end

function drawHandler(drawTable)
	g_drawTable = drawTable
	image = dxCreateTexture("arrow1.png")
	addEventHandler("onClientRender",root,clientRender)
end
addEvent("sendDrawTable",true)
addEventHandler("sendDrawTable",root,drawHandler)


function cutscene()
	local a,b,c = getElementPosition(getElementByID("CAMERA1"))
	local x,y,z = getElementPosition(getElementByID("checkpoint70"))
	setCameraMatrix(a,b,c,x,y,z)
end

addEventHandler('onClientResourceStart', resourceRoot, function()	-- load the custom UFO texture on the sparrow
	if not (getElementData(root,"racestate") == "Running") then -- if not running already, set the camera to the ufo landing site (cutscene)
		addEventHandler ( "onClientRender", root, cutscene )
	end

end 
)

function retargetcamera() -- make the camera follow the player again when the map starts
	removeEventHandler ( "onClientRender", root, cutscene )
	setCameraTarget(localPlayer)
	local a,b,c = getElementPosition(getElementByID("CAMERA1"))
	local x,y,z = getElementPosition(getElementByID("checkpoint70"))
	local a2,b2,c2 = getElementPosition(localPlayer)
	smoothMoveCamera ( a,b,c,x,y,z, a2,b2-30,c2+5, a2,b2,c2, 2000 )
end
addEvent ( "retargetcamera", true )
addEventHandler ("retargetcamera", getRootElement(),retargetcamera )

local sm = {}
sm.moov = 0
sm.object1, sm.object2 = nil, nil
 
function removeCamHandler ()
	if(sm.moov == 1) then
		sm.moov = 0
		removeEventHandler ( "onClientPreRender", getRootElement(), camRender )
		setCameraTarget(localPlayer)
	end
end
 
function camRender ()
	local x1, y1, z1 = getElementPosition ( sm.object1 )
	local x2, y2, z2 = getElementPosition ( sm.object2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
end
 
function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	if(sm.moov == 1) then return false end
	sm.object1 = createObject ( 1337, x1, y1, z1 )
	sm.object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( sm.object1, 0 )
	setElementAlpha ( sm.object2, 0 )
	setObjectScale(sm.object1, 0.01)
	setObjectScale(sm.object2, 0.01)
	moveObject ( sm.object1, time, x2, y2, z2, 0, 0, 0, "InOutQuad" )
	moveObject ( sm.object2, time, x2t, y2t, z2t, 0, 0, 0, "InOutQuad" )
 
	addEventHandler ( "onClientPreRender", getRootElement(), camRender )
	sm.moov = 1
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, sm.object1 )
	setTimer ( destroyElement, time, 1, sm.object2 )
	return true
end







--setDevelopmentMode(true)
allClientPlayers = {}
turnoff = {}

-- function start()
    -- addEventHandler("onClientPlayerVehicleEnter",getLocalPlayer(),addGravityFinder)
    -- addEventHandler("onClientPlayerVehicleExit",getLocalPlayer(),removeGravityFinder)
-- end

function addGravityFinder()
    addEventHandler("onClientRender",getRootElement(),magnetWheels)
	addEventHandler("onClientPlayerVehicleEnter",getLocalPlayer(),givehealth)
end

function givehealth(veh)
	setElementHealth(veh,1000000)
end


function removeGravityFinder(veh)
    removeEventHandler("onClientRender",getRootElement(),magnetWheels)
end

function magnetWheels()
    local veh = getPedOccupiedVehicle(getLocalPlayer())
	
	if veh then
		--outputChatBox(tostring(isVehicleOnGround(veh)))
		local x,y,z = getElementPosition(veh)
		local underx,undery,underz = getPositionUnderTheElement(veh)
		setVehicleGravity(veh,underx - x,undery - y,underz - z)	
	end
end

function getPositionUnderTheElement(element)
    local matrix = getElementMatrix (element)
    local offX = 0 * matrix[1][1] + 0 * matrix[2][1] - 1 * matrix[3][1] + matrix[4][1]
    local offY = 0 * matrix[1][2] + 0 * matrix[2][2] - 1 * matrix[3][2] + matrix[4][2]
    local offZ = 0 * matrix[1][3] + 0 * matrix[2][3] - 1 * matrix[3][3] + matrix[4][3]
    return offX,offY,offZ
end

-- function stopMagnets(player)
    -- if not turnoff[player] then
	    -- removeEventHandler("onClientPlayerVehicleEnter",getLocalPlayer(),addGravityFinder)
	    -- removeEventHandler("onClientPlayerVehicleExit",getLocalPlayer(),removeGravityFinder)
		-- removeEventHandler("onClientRender",getRootElement(),magnetWheels)    
		-- veh = getPedOccupiedVehicle(getLocalPlayer())
	    -- if veh then
	        -- setVehicleGravity(veh,0,0,-1)
	    -- end
	    -- turnoff[player] = true
	-- else
	    -- addEventHandler("onClientPlayerVehicleEnter",getLocalPlayer(),addGravityFinder)
        -- addEventHandler("onClientPlayerVehicleExit",getLocalPlayer(),removeGravityFinder)
		-- addEventHandler("onClientRender",getRootElement(),magnetWheels)
		-- turnoff[player] = nil
	-- end
-- end

-- addCommandHandler("magnet",stopMagnets)
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),addGravityFinder)

