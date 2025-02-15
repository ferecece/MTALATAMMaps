engineSetModelLODDistance(8172, 500)

function triggerGrav()
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		setTimer(triggerGrav,1000,1)
		return
	end
	setTimer(changeGrav,15000,1)
	
	-- setTimer(function()
		-- local veh = getPedOccupiedVehicle(localPlayer)
		-- if veh then
			-- fixVehicle(veh)
		-- end
	-- end,1000,0)
	
	setTimer(function()
			for index,theMarker in ipairs(getElementsByType("marker")) do
				if getMarkerType(theMarker) == "checkpoint" then
					local r,g,b = math.random(0,1)*255,math.random(0,1)*255,math.random(0,1)*255
					setMarkerColor(theMarker,r,g,b,255)
				end
			end
	end,500,0)
end
addEvent ( "changeGrav", true )
addEventHandler ("changeGrav", getRootElement(), triggerGrav )

local angle = 45
function changeGrav()
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		setTimer(changeGrav,1000,1)
		return
	end
	playSFX("script", 6, 1, false) -- airhorn sound
	setVehicleGravity(veh,0,-math.sin(math.rad(angle)),-math.cos(math.rad(angle)))
end

-- if a player gets the disco car, make them fall at an angle of 60, else 45
function raceState(dataName,oldValue)
	if (dataName == "disco") then
		local newangle
		local discoActivated = getElementData (source,"disco")
		if discoActivated then
			newangle = 60
		else
			newangle = 45
		end
		setVehicleGravity(source,0,-math.sin(math.rad(newangle)),-math.cos(math.rad(newangle)))
	end
end
addEventHandler("onClientElementDataChange", getRootElement(),raceState)

once = true
function enterVehicle2 ( theVehicle, seat, jacked )
	if once then
		once = false
		setTimer(function()
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh then
				setVehicleDamageProof(theVehicle,true)
			end
		end,500,0)
	end
end
addEventHandler ( "onClientPlayerVehicleEnter", localPlayer, enterVehicle2 )


white = dxCreateTexture("white.png")
function draw()
	local target = getCameraTarget()
	local x,y,z
	if target then
		x,y,z = getElementPosition(target) 
	else
		x,y,z = 1624.2998046875,3094.599609375,103.6
	end

	for yDraw= 3300,-3390, -10 do

		if math.abs( y - yDraw - 100) < 200 then
			local range = math.floor((yDraw) / (640-380)) % 2 -- alternates 0/1
			local ind = ((yDraw)) % (640-380) -- current wl index
			local wl = (1 - range)*(380 + ind) + range * (640 - ind) -- get wl from up or down direction
			local r,g,b = wavelengthToRGBA (wl) -- color will alternate up/down the rainbow
			
			dxDrawMaterialLine3D ( 	1624.2998046875-20,	yDraw,103.55, --start
						   		   	1624.2998046875+20,	yDraw,103.55,  --end
									white, 10, tocolor(r,g,b,50), --material, width,color
                  					1624.2998046875,	yDraw,150) --face Towards
		end

	end
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
addEventHandler("onClientRender",root,draw)