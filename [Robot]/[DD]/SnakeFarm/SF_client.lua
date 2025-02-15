
white = dxCreateTexture("white.png")
idToVeh = {}
local hasPlayerMoved = false

function updateID(data)
    idToVeh = data
end
addEvent("idAssigned",true)
addEventHandler("idAssigned", root, updateID)

addEventHandler('onClientResourceStart', resourceRoot, function()	
	setTimer(checkForMovement, 500, 1)
end 
)

function checkForMovement()
	if not isElementMoving(getPedOccupiedVehicle (localPlayer)) then
		setTimer(checkForMovement, 500, 1)
	else
		hasPlayerMoved = true
	end
end

function isElementMoving(theElement)
    if isElement(theElement)then --First check if the given argument is an element
        local x, y, z = getElementVelocity(theElement) --Get the velocity of the element given in our argument
            return x ~= 0 or y ~= 0 or z ~= 0 --When there is a movement on X, Y or Z return true because our element is moving
    end
    return false
end

addEventHandler("onClientRender", getRootElement(), function ()

    -- data table has been sent from the server
    if not idToVeh then 
        return
    end
    --iprint(idToVeh)

    -- Make sure the local player is in the vehicle
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
        return
    end
	
	local moving = true
	local velx,vely,velz = getElementVelocity(veh)
	if (hasPlayerMoved) then
		if (velx^2+vely^2+velz^2) < 0.1^2 then
			moving = false
		end
	end

    -- Getting positions for player, veh, and front/back of veh
	local xp,yp,zp = getElementPosition(localPlayer)
	local vehx,vehy,vehz = getElementPosition(veh)
    local xBack,yBack,zBack,xFront,yFront,zFront = getPositionFromElementOffset(veh)

    -- Reset the memory table
    local prevPos = {}

    -- Loop through all objects
	for i,o in ipairs(getElementsByType("object")) do
            
        local model = getElementModel(o)
        
        if idToVeh[model] then -- this model belongs to a vehicle
           
            local x,y,z = getElementPosition(o)
            
            if prevPos[model] then -- if we have seen it before
                xPrev,yPrev,zPrev = unpack(prevPos[model])

                if (getDistanceBetweenPoints2D(x,y,xp,yp) < 200) then --if the object is close
                
                    -- check intersect between line and vehicle
                    -- we check intersection in x and y, then a seperate check for z-clearance
                    if doIntersect(xPrev,yPrev,x,y,  xBack,yBack,xFront,yFront) and math.abs((zBack+zFront)/2 - (z+zPrev)/2) < 1  then
                        
                        -- Draw red, and explode vehicle
                        color = tocolor(255,0,0, 150)
                        if not isVehicleBlown(veh) then
                            blowVehicle(veh)
                        end

                    else
                        color = tocolor(255,164,0, 150) --draw orange
                    end

                    dxDrawMaterialLine3D ( xPrev,yPrev,zPrev, --start
                                           x, y, z,  --end
                                           white, 0.8, color, --material, width, color
                                           x, y, z+20) --face towards up

                end
            end

            prevPos[model] = {x,y,z} -- set prevPos to the model position for next iterations

        end

	end

    for ID,Veh in pairs(idToVeh) do

        -- see if we have a position for this ID and the vehicle exists
        if prevPos[ID] and not isVehicleBlown(Veh) then 

            --Draw line connecting last object to back of vehicle
            local xLast,yLast,zLast = unpack(prevPos[ID])
            local xBack,yBack,zBack,_,_,_ = getPositionFromElementOffset(Veh)

            dxDrawMaterialLine3D (  xLast,yLast,zLast, --start
                                    xBack,yBack,zBack,  --end
                                    white, 0.8, tocolor(255,164,0, 150), --material, width, color
                                    xLast,yLast,zLast+20) --face towards up

        end

    end
	
		-- Get the player's car's position and draw the text above isTimer
	local screenWidth,screenHeight = guiGetScreenSize() 

	clientPositionX, clientPositionY, clientPositionZ = 
		getElementPosition(getPedOccupiedVehicle(getLocalPlayer()))

	cameraPosX, cameraPosY, cameraPosZ = getElementPosition(getCamera())

	local textSize = (screenHeight / 1080) * math.max(10/getDistanceBetweenPoints3D(clientPositionX, clientPositionY,
				clientPositionZ, cameraPosX, cameraPosY, cameraPosZ), 0.75)

	posX, posY = getScreenFromWorldPosition(clientPositionX, clientPositionY, clientPositionZ + 1)

	if posX == false or posY == false then
		return
	end

	local text = ""

	if not (moving) then
		text = "Keep moving or you will lose health!"
	end

	width = dxGetTextWidth(text, textSize, "pricedown")
	dxDrawBorderedText (1, text, posX - (width / 2), posY, 1000, 1000, tocolor ( 255, 255, 255, 255 ), textSize, "pricedown")
	
end)

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top - outline, right - outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top - outline, right + outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top + outline, right - outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top + outline, right + outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top, right - outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top, right + outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outline, right, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outline, right, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function getPositionFromElementOffset(element)
    local vx,vy,vz = getElementVelocity(element)
    local speed = (vx^2+vy^2+vz^2)^0.5
    local offX,offY,offZ = 0,-2.3 + speed*1.1,0.1
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    
    local offX2,offY2,offZ2 = 0, 2.8 + speed*1.1, 0.1
    local x2 = offX2 * m[1][1] + offY2 * m[2][1] + offZ2 * m[3][1] + m[4][1]  -- Apply transform
    local y2 = offX2 * m[1][2] + offY2 * m[2][2] + offZ2 * m[3][2] + m[4][2]
    local z2 = offX2 * m[1][3] + offY2 * m[2][3] + offZ2 * m[3][3] + m[4][3]

    return x, y, z, x2,y2,z2                               -- Return the transformed point

end

--https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
-- Given three colinear points p, q, r, the function checks if 
-- point q lies on line segment 'pr' 
function onSegment(px,py,qx,qy,rx,ry) 

    if ( (qx <= math.max(px, rx)) and (qx >= math.min(px, rx)) and (qy <= math.max(py, ry)) and (qy >= math.min(py, ry)) ) then
       	return true
  	else
    	return false
    end
end
  
-- To find orientation of ordered triplet (p, q, r). 
-- The function returns following values 
-- 0 --> p, q and r are colinear 
-- 1 --> Clockwise 
-- 2 --> Counterclockwise 
function orientation(px,py, qx,qy, rx,ry) 

    -- See https://www.geeksforgeeks.org/orientation-3-ordered-points/ 
    -- for details of below formula. 
    local val = (qy - py) * (rx - qx) - (qx - px) * (ry - qy); 
    if (val == 0) then return 0 end  -- colinear 
  
    if (val > 0) then 
    	return 1 --clockwise
    else
    	return 2 --Counterclockwise
    end
end
  
--The main function that returns true if line segment 'p1q1' 
--and 'p2q2' intersect. 
function doIntersect(x1,y1,x2,y2,x3,y3,x4,y4) 
    -- Find the four orientations needed for general and 
    -- special cases 
    local o1 = orientation(x1,y1, x2,y2, x3,y3) 
    local o2 = orientation(x1,y1, x2,y2, x4,y4) 
    local o3 = orientation(x3,y3, x4,y4, x1,y1) 
    local o4 = orientation(x3,y3, x4,y4, x2,y2) 
  
    --General case 
    if (o1 ~= o2) and (o3 ~= o4) then 
        --iprint(o1,o2,o3,o4)      
    	return true
    end 
  
    -- Special Cases 
    -- p1, q1 and p2 are colinear and p2 lies on segment p1q1 
    if (o1 == 0 and onSegment(x1,y1, x2,y2,x3,y3)) then
        --outputChatBox("special1")
    	return true
    end 
  
    --p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if (o2 == 0 and onSegment(x1,y1, x4,y4, x2,y2)) then
    	--outputChatBox("special2")
        return true
    end 	
  
    -- p2, q2 and p1 are colinear and p1 lies on segment p2q2 
    if (o3 == 0 and onSegment(x3,y3, x1, y1, x4,y4)) then
    	--outputChatBox("special3")
        return true
    end 
  
    -- p2, q2 and q1 are colinear and q1 lies on segment p2q2 
    if (o4 == 0 and onSegment(x3,y3, x2,y2, x4,y4)) then
    	--outputChatBox("special4")
        return true
    end 
  
    return false --// Doesn't fall in any of the above cases 
end
