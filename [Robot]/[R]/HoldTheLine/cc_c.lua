function loadHandler ( data )
	recording1 = nil
    recording1 = data
end
addEvent( "loadPath", true )
addEventHandler( "loadPath", localPlayer, loadHandler )


radius = 15
-- * Drawing The Recorded Data Function * --
addEventHandler("onClientRender", getRootElement(), function ()
	local veh = getPedOccupiedVehicle(localPlayer)
	if recording1 then
		local xp,yp,zp = getElementPosition(localPlayer)
		
		local distance = radius
		if sphere and veh then
			local objects = getElementsWithinColShape(sphere,"object")
			for index,theObject in ipairs (objects) do
				if (getElementModel(theObject) == 1337) then
					local x1,y1,z1 = getElementPosition(theObject)
					local x2,y2,z2 = getElementPosition(veh)
					
					local tempdist = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
					if tempdist < distance then
						distance = tempdist
					end
				end
			end
		end
		--distance is now between 0-20
		local ratio
		if distance < 5 then
			ratio = 0 
		else
			ratio = (distance-5)/(radius-5)
		end
		
		local p = -510*(ratio^2)
		local g,r = math.max(math.min(p + 255*ratio + 255, 255), 0), math.max(math.min(p + 765*ratio, 255), 0)
		local b = 0
			
		if veh then
			setVehicleColor(veh,r,g,b)
			local multiplier = (1-ratio)*0.4+0.6
			--outputChatBox(multiplier)
			if zp < 1000 then
				setGameSpeed(multiplier)
			else
				setGameSpeed(1)
			end
		end
		
		for i=2,#recording1 do
			local x,y,z = recording1[i]["x"..tostring(1)], recording1[i]["x"..tostring(2)], recording1[i]["x"..tostring(3)]
			
			if (x and y and z) then
				
				if (getDistanceBetweenPoints2D(x,y,xp,yp) < 200) then
					if recording1[i-1]["x"..tostring(2)] and recording1[i]["x"..tostring(2)] then
						dxDrawLine3D ( recording1[i-1]["x"..tostring(1)], recording1[i-1]["x"..tostring(2)], recording1[i-1]["x"..tostring(3)], x,y,z, tocolor ( r,g,b,255), 10 )
					end
				end
			end
		end	
	end
end)


function spawn(theVehicle,seat)
	if (source == localPlayer) and not (sphere) then
		--setDevelopmentMode(true)
		local x,y,z = getElementPosition(localPlayer)
		sphere = createColSphere(x,y,z,radius)
		attachElements(sphere,theVehicle)
	end
end
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),spawn)