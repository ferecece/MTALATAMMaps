outputChatBox("Use the arrow keys to control your pitch to try and float for as long as you can!", getRootElement(), 231, 50, 50)
outputChatBox("Hitting a checkpoint will give you extra height!", getRootElement(), 231, 50, 50)
outputChatBox("Use your map to find the next checkpoint if you can't see it!", getRootElement(), 231, 50, 50)
outputChatBox("The higher you are at the end the better vehicle you will get for the finish!", getRootElement(), 231, 50, 50)

colTube1 = createColTube (2200 , -1683, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 300 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube1, enterCol )

colTube2 = createColTube (1900 , -1683, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 300 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube2, enterCol )

colTube3 = createColTube (1467 , -1231, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 300 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube3, enterCol )

colTube4 = createColTube (1650.80005 , -1163.80005, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 300 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube4, enterCol )

colTube5 = createColTube (1600 , -1542.30005, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 300 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube5, enterCol )

colTube6 = createColTube (1626.19995 , -1857, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 250 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube6, enterCol )

colTube7 = createColTube (1631 , -2074.8999, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 200 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube7, enterCol )

colTube8 = createColTube (1346.5 , -2194.19995, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				local playerSpeedX, playerSpeedY, playerSpeedZ = getElementVelocity(getPedOccupiedVehicle(thePlayer))
				setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 25)
				setElementVelocity(getPedOccupiedVehicle(thePlayer), playerSpeedX, playerSpeedY, playerSpeedZ)
				
				if playerZ < 150 then
					setElementPosition(getPedOccupiedVehicle(thePlayer), playerX, playerY, playerZ + 50)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube8, enterCol )

colTube9 = createColTube (1419.09998 , -2452.3999, 0, 50, 1000)
function enterCol ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
				local playerX, playerY, playerZ = getElementPosition(getPedOccupiedVehicle(thePlayer))
				
				if playerZ < 60 then
					setElementModel(getPedOccupiedVehicle(thePlayer), 457)
				elseif playerZ < 120 then
					setElementModel(getPedOccupiedVehicle(thePlayer), 448)
				elseif playerZ < 180 then
					setElementModel(getPedOccupiedVehicle(thePlayer), 496)
				elseif playerZ < 500 then
					setElementModel(getPedOccupiedVehicle(thePlayer), 415)
				end
        end
end
addEventHandler ( "onColShapeHit", colTube9, enterCol )

--[[
    <checkpoint id="checkpoint () (1)" type="checkpoint" color="#00F9" size="50" nextid="checkpoint () (2)" posX="2200" posY="-1683" posZ="269.79999" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (2)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (3)" posX="1900" posY="-1683" posZ="269.79999" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (3)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (4)" posX="1467" posY="-1231" posZ="193.5" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (4)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (5)" posX="1650.80005" posY="-1163.80005" posZ="226" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (5)" type="checkpoint" color="#00F9" size="50" nextid="checkpoint () (6)" posX="1600" posY="-1542.30005" posZ="132.89999" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (6)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (7)" posX="1626.19995" posY="-1857" posZ="114.6" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (7)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (8)" posX="1631" posY="-2074.8999" posZ="83.2" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (8)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" nextid="checkpoint () (9)" posX="1346.5" posY="-2194.19995" posZ="65.9" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (9)" type="checkpoint" color="#FF000099" size="50" alpha="255" interior="0" nextid="checkpoint () (10)" posX="1419.09998" posY="-2452.3999" posZ="65.9" rotX="0" rotY="0" rotZ="0"></checkpoint>
    <checkpoint id="checkpoint () (10)" type="checkpoint" color="#00F9" size="50" alpha="255" interior="0" posX="1943" posY="-2449.3999" posZ="65.9" rotX="0" rotY="0" rotZ="0"></checkpoint>
--]]


