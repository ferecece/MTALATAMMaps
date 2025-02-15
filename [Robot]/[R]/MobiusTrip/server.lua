
-- Matrix functions for finding offsets
function getElementMatrix(element)
    local rx, ry, rz = getElementRotation(element, "ZXY")
    rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
    local matrix = {}
    matrix[1] = {}
    matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][3] = -math.cos(rx)*math.sin(ry)
    matrix[1][4] = 1
 
    matrix[2] = {}
    matrix[2][1] = -math.cos(rx)*math.sin(rz)
    matrix[2][2] = math.cos(rz)*math.cos(rx)
    matrix[2][3] = math.sin(rx)
    matrix[2][4] = 1
 
    matrix[3] = {}
    matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)
    matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)
    matrix[3][3] = math.cos(rx)*math.cos(ry)
    matrix[3][4] = 1
 
    matrix[4] = {}
    matrix[4][1], matrix[4][2], matrix[4][3] = getElementPosition(element)
    matrix[4][4] = 1
 
    return matrix
end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end


-- speed boost function triggered when hitting a speed boost colshape
function speedColHit(hitEl)
	if (getElementType(hitEl)=="vehicle") then
		local velx,vely,velz = getElementVelocity(hitEl)
		setElementVelocity(hitEl,velx*2,vely*2,velz*2)
	end
end


-- Main Function to handle race states
function start(newstate,oldstate)
	setElementData(root,"racestate",newstate,true)
	if (newstate == "LoadingMap") then
		--generating the track
		local x,y,z = getElementPosition(getElementByID("start"))
		local a,b = 3.5,1000
		local x = x - b

		drawSpeedTable = {}
		for i=1,2*a*360 do
			--mobius strip is just a circle but with twisting the platforms
			local o = createObject(3458,x+b*math.cos(i*math.pi/(a*180)),y+b*math.sin(i*math.pi/(a*180)),z,0,-i/(2*a),i/a)
			setElementAlpha(o,141)
			
			--creating the neon edges
			local x2,y2,z2 = getPositionFromElementOffset(o,20,0,1.6)
			local n2 = createObject(1577,x2,y2,z2,0,-i/(2*a),i/a)
			setElementCollisionsEnabled(n2,false)
			setObjectScale(n2,5)
			
			local x3,y3,z3 = getPositionFromElementOffset(o,-20,0,1.6)
			local n3 = createObject(1577,x3,y3,z3,0,-i/(2*a),i/a)
			setElementCollisionsEnabled(n3,false)
			setObjectScale(n3,5)
			
			--creating the speed boosts
			if (i%80 == 0) then
				--colshapes to trigger the boost
				local ranX = math.random(-15,15)
				local x4,y4,z4 = getPositionFromElementOffset(o,ranX,0,3.1)
				local col = createColSphere(x4,y4,z4,3)
				addEventHandler("onColShapeHit",col,speedColHit)
				
				--creating red neon bars
				local x5,y5,z5 = getPositionFromElementOffset(o,ranX,-3,1.55)
				local neon1 = createObject(1580,x5,y5,z5,i/(2*a),-i/(2*a),i/a-90)
				setElementCollisionsEnabled(neon1,false)
				setObjectScale(neon1,3)
				
				local x6,y6,z6 = getPositionFromElementOffset(o,ranX,3,1.55)
				local neon2 = createObject(1580,x6,y6,z6,i/(2*a),-i/(2*a),i/a-90)
				setElementCollisionsEnabled(neon2,false)
				setObjectScale(neon2,3)
				
				-- getting point towards coordinates for drawing image
				local x7,y7,z7= getPositionFromElementOffset(o,ranX,0,0)
				--inserting coordinates into table for drawing clientside
				table.insert(drawSpeedTable,{x5,y5,z5,x6,y6,z6,x7,y7,z7})
			end		
		end
	end
	
	if (newstate == "GridCountdown") then --when the countdown ends, initialize
		setTimer(function()
			triggerClientEvent("sendDrawTable",root,drawSpeedTable)
			addEventHandler("onPlayerJoin",root,sendData)
			triggerClientEvent("retargetcamera",getRootElement())
		end,200,1)
	end
	
	if (newstate == "Running" and oldstate == "GridCountdown") then --when the countdown ends, initialize
		
	end
	
	
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function sendData()
	triggerClientEvent(source,"sendDrawTable",root,drawSpeedTable)
end


function enterVehicle ( theVehicle, seat, jacked ) --when a player enters a vehicle
	setElementModel(source,70)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onPlayerVehicleEnter




----------------
--Code needed to generate checkpoints in .map file format
----------------


-- function getRandomBrightColor()
	-- local r,g,b
	
	-- r = math.random(0,1)*255
	-- g = math.random(0,1)*255
	
	-- if (r == 255) and (g == 255) then
		-- b = 0
	-- elseif (r==0) and (g == 0) then
		-- b = 255
	-- else
		-- b = math.random(0,1)*255
	-- end
	
	-- local name
	-- if r == 0 then
		-- name = "0"
	-- else
		-- name = "F"
	-- end
	
	-- if g == 0 then
	-- name = name.."0"
		-- else
	-- name = name.."F"
	-- end
	
	-- if b == 0 then
	-- name = name.."0"
		-- else
	-- name = name.."F"
	-- end
	-- return name
-- end


-- local RootNode = xmlCreateFile("new.xml"," newroot")
-- for j=1,80 do
	-- local NewNode = xmlCreateChild(RootNode, "checkpoint")
	-- xmlNodeSetAttribute(NewNode, "id","checkpoint"..j)
	-- xmlNodeSetAttribute(NewNode, "type","ring")
	
	-- local name = getRandomBrightColor()
	-- xmlNodeSetAttribute(NewNode, "color",name)
	-- xmlNodeSetAttribute(NewNode, "size","20")
	-- xmlNodeSetAttribute(NewNode, "nextid","checkpoint"..j+1)
	-- xmlNodeSetAttribute(NewNode, "posX",x+b*math.cos(j*math.pi/(20)))
	-- xmlNodeSetAttribute(NewNode, "posY",y+b*math.sin(j*math.pi/(20)))
	-- xmlNodeSetAttribute(NewNode, "posZ",z)
	-- xmlNodeSetAttribute(NewNode, "rotX",0)
	-- xmlNodeSetAttribute(NewNode, "rotY",0)
	-- xmlNodeSetAttribute(NewNode, "rotZ",0)
-- end
-- xmlSaveFile(RootNode)
-- xmlUnloadFile(RootNode)

--
-- -- Code for generating repairs/nitro
--
-- if (i%160 == 0) then
		-- outputChatBox("i")
		-- for j=-2,2 do
			-- local NewNode = xmlCreateChild(RootNode, "racepickup")
			-- xmlNodeSetAttribute(NewNode, "id","racepickup")
			-- if (j%2==0)then
				-- xmlNodeSetAttribute(NewNode, "type","nitro")
			-- else
				-- xmlNodeSetAttribute(NewNode, "type","repair")
			-- end
			-- xmlNodeSetAttribute(NewNode, "vehicle","522")
			-- xmlNodeSetAttribute(NewNode, "respawn","0")
			-- local x4,y4,z4 = getPositionFromElementOffset(o,j*7.5,0,3.1)
			-- xmlNodeSetAttribute(NewNode, "posX",x4)
			-- xmlNodeSetAttribute(NewNode, "posY",y4)
			-- xmlNodeSetAttribute(NewNode, "posZ",z4)
			-- xmlNodeSetAttribute(NewNode, "rotX",0)
			-- xmlNodeSetAttribute(NewNode, "rotY",0)
			-- xmlNodeSetAttribute(NewNode, "rotZ",0)
		-- end
	-- end