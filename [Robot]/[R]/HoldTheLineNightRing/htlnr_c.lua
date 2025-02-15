
local recording1 = {}
local lx = 0
local ly = 0
local lz = 0


function updateRecording()
	local pVeh = getPedOccupiedVehicle(localPlayer)
	if pVeh then
		local x,y,z = getPositionFromElementOffset(pVeh)
		--if z < 1000 then
			--getElementPosition(pVeh)
			local dist = getDistanceBetweenPoints3D ( x,y,z, lx,ly,lz )
			if(dist > 1)then
				local o = createObject(1337,x,y,z)
				 setElementCollisionsEnabled(o,false)
				setElementAlpha(o,0)
				
				local range = math.floor(#recording1 / (640-380)) % 2 -- alternates 0/1
				local ind = #recording1 % (640-380) -- current wl index
				local wl = (1 - range)*(380 + ind) + range * (640 - ind) -- get wl from up or down direction
				local r,g,b = wavelengthToRGBA (wl) -- color will alternate up/down the rainbow

				setVehicleColor(pVeh,0,0,0,r,g,b)
				table.insert(recording1, {x,y,z,r,g,b})
				lx = x ly = y lz = z
			end
		--end
	end
end
updTimer = setTimer(updateRecording, 100, 0)

radius = 15
livePath = false
-- * Drawing The Recorded Data Function * --
addEventHandler("onClientRender", getRootElement(), function ()
	local veh = getPedOccupiedVehicle(localPlayer)
	if recording1 and veh then
		local r,g,b = 0,255,0

		local xp,yp,zp = getElementPosition(localPlayer)
		local vehx,vehy,vehz = getElementPosition(veh)
		if livePath then	
			local distance = radius
			if sphere then
				local objects = getElementsWithinColShape(sphere,"object")
				for index,theObject in ipairs (objects) do
					if (getElementModel(theObject) == 1337) then
						local x1,y1,z1 = getElementPosition(theObject)
						local tempdist = getDistanceBetweenPoints3D(x1,y1,z1,vehx,vehy,vehz)
						if tempdist < distance then
							distance = tempdist
						end
					end
				end
			else
				local x,y,z = getElementPosition(veh)
				sphere = createColSphere(x,y,z,radius)
				attachElements(sphere,veh)
			end

			--distance is now between 0-20
			local ratio
			if distance < 5 then
				ratio = 0 
			else
				ratio = (distance-5)/(radius-5)
			end
			
			local p = -510*(ratio^2)
			g,r = math.max(math.min(p + 255*ratio + 255, 255), 0), math.max(math.min(p + 765*ratio, 255), 0)
			b = 0
			
			setVehicleColor(veh,r,g,b,0,0,0)
			local multiplier = (1-ratio)*0.4+0.6
			--outputChatBox(multiplier)
			if zp < 1000 then
				setGameSpeed(multiplier)
			else
				setGameSpeed(1)
			end

			for i=2,#recording1 do
				local x,y,z= unpack(recording1[i])
				local x2,y2,z2 = unpack(recording1[i-1])
				if (getDistanceBetweenPoints2D(x,y,xp,yp) < 200) then
					dxDrawLine3D ( x2,y2,z2, x,y,z, tocolor ( r,g,b,255), 10 )
				end
			end
			
		else

			if recording1[#recording1] then
				local x1,y1,z1,r,g,b = unpack(recording1[#recording1])
				if zp < 1000 and isPedInVehicle(localPlayer) then
					local x2,y2,z2 = getPositionFromElementOffset(veh)
					dxDrawLine3D (x1,y1,z1,x2,y2,z2, tocolor ( r,g,b, 255), 10 )
				end
			end

			for i=2,#recording1 do
				local x,y,z,r,g,b = unpack(recording1[i])
				local x2,y2,z2 = unpack(recording1[i-1])
				if (getDistanceBetweenPoints2D(x,y,xp,yp) < 200) then
					dxDrawLine3D ( x2,y2,z2, x,y,z, tocolor ( r,g,b,255), 10 )
				end
			end

		end
		
	end
end)

function activate()
	if isTimer(updTimer) then
		killTimer(updTimer)
	end
	livePath = true
end
addEvent( "activateLivePath", true )
addEventHandler( "activateLivePath", localPlayer, activate)

function getPositionFromElementOffset(element,offX,offY,offZ)
	local vx,vy,vz = getElementVelocity(element)
	local speed = (vx^2+vy^2+vz^2)^0.5
	local offX,offY,offZ = 0,-2.1 + speed*1.1,0
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

function wavelengthToRGBA (length)
	local r, g, b, factor
	if (length >= 380 and length < 440) then
		r, g, b = -(length - 440)/(440 - 380), 0, 1
	elseif (length < 490) then
		r, g, b = 0, (length - 440)/(490 - 440), 1
	elseif (length < 510) then
		r, g, b = 0, 1, -(length - 510)/(510 - 490)
	elseif (length < 580) then
		r, g, b = (length - 510)/(580 - 510), 1, 0
	elseif (length < 645) then
		r, g, b = 1, -(length - 645)/(645 - 580), 0
	elseif (length < 780) then
		r, g, b = 1, 0, 0
	else
		r, g, b = 0, 0, 0
	end
	if (length >= 380 and length < 420) then
		factor = 0.3 + 0.7*(length - 380)/(420 - 380)
	elseif (length < 701) then
		factor = 1
	elseif (length < 780) then
		factor = 0.3 + 0.7*(780 - length)/(780 - 700)
	else
		factor = 0
	end
	return r*255, g*255, b*255, factor*255
end