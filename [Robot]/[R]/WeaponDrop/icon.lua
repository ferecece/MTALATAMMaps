imgs = {"files/icon1.png", "files/icon2.png", "files/icon3.png", "files/icon4.png", "files/icon6.png", "files/icon7.png", "files/icon8.png", "files/icon9.png", "files/icon10.png", "files/icon11.png", "files/icon5.png"}
rndm = 0
inumcount = 0
pickup = 0
uses = 0
threeuses = 0
helpvar = 0
helpinit = 0

function makeicon()
	local x,y = guiGetScreenSize()
	iconimg = guiCreateStaticImage( (x/2)-25, y/12, 50, 50, "files/icon5.png", false )
	inumimg = guiCreateStaticImage( (x/2)-25, y/12, 50, 50, "files/i3.png", false )
	guiSetVisible (inumimg, false )
	xtraimg = guiCreateStaticImage( (x/2)-25, y/12, 50, 50, "files/iconx.png", false )
	guiSetVisible (xtraimg, false )
	whiteimg = guiCreateStaticImage( 0, 0, x, y, "files/white.png", false )
	guiSetVisible (whiteimg, false )
	trollimg = guiCreateStaticImage( (x-y)/2, 0, y, y, "files/troll.png", false )
	guiSetVisible (trollimg, false )
	notbadimg = guiCreateStaticImage( x-(y/3), (y/3)*2, y/3, y/3, "files/notbad.png", false )
	guiSetVisible (notbadimg, false )
	ffsimg = guiCreateStaticImage( x-(y/3), (y/3)*2, y/3, y/3, "files/ffs.png", false )
	guiSetVisible (ffsimg, false )
	omgimg = guiCreateStaticImage( (x-(y/1.5))/2, y/4, y/1.5, y/1.5, "files/omg.png", false )
	guiSetVisible (omgimg, false )
	slamimg = guiCreateStaticImage(0, 0, x, y, "files/slam.png", false )
	guiSetVisible (slamimg, false )
	barrelimg = guiCreateStaticImage(0, y-600, 600, 600, "files/barrel.png", false )
	guiSetVisible (barrelimg, false )
	countimg = guiCreateStaticImage((x/2)-150, (y/2)-150, 300, 300, "files/5.png", false )
	guiSetVisible (countimg, false )
	invincimg = guiCreateStaticImage( 0, 0, x, y, "files/invincible.png", false )
	guiSetVisible (invincimg, false )
	if y <= 900 then
		helpimg = guiCreateStaticImage( (x-(y/1.3))/2, (y-(y/1.3))/2, y/1.3, y/1.3, "files/help.png", false )
	elseif y>= 901 then
		helpimg = guiCreateStaticImage( (x-800)/2, (y-800)/2, 800, 800, "files/help.png", false )
	end
	setTimer ( function()
		guiSetVisible ( helpimg, false )
		helpinit = 1
	end, 5000, 1)
	bindKey("2","down",jumpy)
	bindKey("lctrl","down",jumpy)
	bindKey("rctrl","down",jumpy)
	bindKey("mouse1","down",jumpy)
	bindKey("m","down",help)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), makeicon)

function help()
	if helpinit == 1 then
		if helpvar == 0 then
			guiSetVisible (helpimg, true)
			helpvar = 1
		elseif helpvar == 1 then
			guiSetVisible (helpimg, false)
			helpvar = 0
		end
	end
end

function markerHit ()
	inumhider()
	uses = 1
	pickup = math.random(1,10)
	guiStaticImageLoadImage ( iconimg, imgs[pickup] )
	if pickup <= 2 then
		dropvar = math.random(1,9)
		if dropvar >= 6 then
			threeuses = 0
			inums ()
		end
	end
end
addEvent( "hitmarker", true )
addEventHandler( "hitmarker", getRootElement(), markerHit )

function jumpy()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if (veh) then
		if uses == 1 then
			if pickup ==1 then -- *** Barrel Drop ************
				if dropvar <= 5 then
					local x,y,z = getElementPosition(veh)
					local xr,yr,zr = getElementRotation (veh)
					local sx,sy,sz = getElementVelocity(veh)
					local allspeed = (sx^2 + sy^2 + sz^2)^(0.5)
					local closeness = 3
					r1 = createObject(1225, x+(math.sin(math.rad(zr))*closeness), y-(math.cos(math.rad(zr))*closeness), z-1, 0, 0, zr)
					if pickup == 1 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
				elseif dropvar >= 6 then
					inumtrigger ()
					local x,y,z = getElementPosition(veh)
					local xr,yr,zr = getElementRotation (veh)
					local sx,sy,sz = getElementVelocity(veh)
					local allspeed = (sx^2 + sy^2 + sz^2)^(0.5)
					local closeness = 3
					r1 = createObject(1225, x+(math.sin(math.rad(zr))*closeness), y-(math.cos(math.rad(zr))*closeness), z-1, 0, 0, zr)
					threeuses = threeuses + 1
					if threeuses == 3 then
						threeuses = 0
						if pickup == 1 then
							uses = 0
							guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
						end
					end
				end
			elseif pickup == 2 then -- *** Hay Drop ************
				if dropvar <= 5 then
					local x,y,z = getElementPosition(veh)
					local xr,yr,zr = getElementRotation (veh)
					local sx,sy,sz = getElementVelocity(veh)
					local allspeed = (sx^2 + sy^2 + sz^2)^(0.5)
					local closeness = 5
					r1 = createObject(3374, x+(math.sin(math.rad(zr))*closeness), y-(math.cos(math.rad(zr))*closeness), z, 0, 0, zr)
					if pickup == 2 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
				elseif dropvar >= 6 then
					inumtrigger ()
					local x,y,z = getElementPosition(veh)
					local xr,yr,zr = getElementRotation (veh)
					local sx,sy,sz = getElementVelocity(veh)
					local allspeed = (sx^2 + sy^2 + sz^2)^(0.5)
					local closeness = 5
					r1 = createObject(3374, x+(math.sin(math.rad(zr))*closeness), y-(math.cos(math.rad(zr))*closeness), z, 0, 0, zr)
					threeuses = threeuses + 1
					if threeuses == 3 then
						threeuses = 0
						if pickup == 2 then
							uses = 0
							guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
						end
					end
				end
			elseif pickup == 4 then -- *** Nitro ***************
				addVehicleUpgrade ( veh, 1009 )
				guiSetVisible (xtraimg, true )
				guiSetVisible (whiteimg, true )
				counter(0)
				setTimer ( function()
					removeVehicleUpgrade (veh, 1009)
					guiSetVisible (xtraimg, false )
					guiSetVisible (whiteimg, false )
					if pickup == 4 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
				end, 5000, 1 )
			elseif pickup == 3 then -- *** Ghostmode *************
				setElementAlpha ( veh, 20 )
				setElementAlpha ( player, 20 )
				guiSetVisible (xtraimg, true )
				counter(0)
--~ 				for index,vehicle in ipairs(getElementsByType("vehicle")) do
--~ 					setElementCollidableWith(vehicle, veh, false)
--~ 				end
				setTimer ( function()
					guiSetVisible (xtraimg, false )
					setElementAlpha (veh, 255)
					setElementAlpha ( player, 255 )
--~ 					for index,vehicle in ipairs(getElementsByType("vehicle")) do
--~ 						setElementCollidableWith(vehicle, veh, true)
--~ 					end
					if pickup == 3 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
				end, 5000, 1 )
			elseif pickup == 5 then -- *** Mystery *****************
				local lotto = math.random(1,3)
				if lotto == 1 then
					guiSetVisible (trollimg, true )
					local sx,sy,sz = getElementVelocity(veh)
					setElementFrozen ( veh,true)
					setTimer ( function()
						guiSetVisible (trollimg, false )
						setElementFrozen ( veh,false)
						setElementVelocity (veh, sx, sy, sz)
					end, 1000, 1 )
				elseif lotto >= 2 then
					local xx,yy,zz = getElementRotation(veh)
					local sx,sy,sz = getElementVelocity(veh)
					local speed = (sx^2 + sy^2 + sz^2)^(0.5)
					if speed <= 0.45 then
						ffstrigger ()
						setElementVelocity (veh, sx*1.35, sy*1.35, sz+0.2)
					elseif speed <= 0.75 then
						notbadtrigger ()
						setElementVelocity (veh, sx*1.35, sy*1.35, sz+0.2)
						setElementRotation (veh, xx+7, yy, zz)
					elseif speed <= 2 then
						omgtrigger ()
						setElementVelocity (veh, sx*1.35, sy*1.35, sz+0.25)
						setElementRotation (veh, xx+25, yy, zz)
					end
				end
				if pickup == 5 then
					uses = 0
					guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
				end
			elseif pickup == 6 then -- *** Missile ***************
				rockettrigger ()
				if pickup == 6 then
					uses = 0
					guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
				end
			elseif pickup == 7 then -- *** Repair ****************
				fixVehicle (veh)
				if pickup == 7 then
					uses = 0
					guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
				end
			elseif pickup == 8 then -- *** Slam ******************
				local xr,yr,zr = getElementRotation (veh)
				local sx,sy,sz = getElementVelocity(veh)
				setElementVelocity (veh, sx*1.1, sy*1.1, 0.3)
				setElementAngularVelocity ( veh, 0.13*math.cos(math.rad(zr-180)), 0.13*math.sin(math.rad(zr-180)), 0 )
				setTimer ( function()
					setElementVelocity (veh, sx, sy, -1)
					slamtrigger ()
				end, 900, 1 )
				if pickup == 8 then
					uses = 0
					guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
				end
			elseif pickup == 9 then -- *** Barrel Roll **************
				if isVehicleOnGround ( veh ) == true then
					local xr,yr,zr = getElementRotation (veh)
					local sx,sy,sz = getElementVelocity(veh)
					setElementVelocity (veh, sx, sy, sz+0.3)
					setElementAngularVelocity ( veh, 0.115*math.cos(math.rad(zr+90)), 0.115*math.sin(math.rad(zr+90)), 0 )
					barreltrigger ()
					if pickup == 9 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
				end
			elseif pickup == 10 then -- *** Invincible **************
				setVehicleDamageProof ( veh, true )
				counter(0)
				setRadioChannel(0)
				song = playSound("files/invincible.mp3",false)
				setSoundVolume(song,0.5)
				addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
				setTimer ( function()
					setVehicleDamageProof ( veh, false )
					if pickup == 10 then
						uses = 0
						guiStaticImageLoadImage ( iconimg, "files/icon5.png" )
					end
					setSoundVolume(song,0)
					removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
				end, 5000, 1 )
			end
		end
	end
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end

function notbadtrigger ()
	guiSetVisible (notbadimg, true )
	setTimer ( function()
		guiSetVisible (notbadimg, false )
	end, 2200, 1 )
end

function ffstrigger ()
	guiSetVisible (ffsimg, true )
	setTimer ( function()
		guiSetVisible (ffsimg, false )
	end, 2200, 1 )
end

function omgtrigger (point)
	setTimer ( function()
		guiSetVisible (omgimg, true )
	end, 50, 22 )
	setTimer ( function()
		guiSetVisible (omgimg, false )
	end, 100, 11 )
	setTimer ( function()
		guiSetVisible (omgimg, false )
	end, 2300, 1 )
end

function rockettrigger ()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	local x,y,z = getElementPosition(veh)
	local xr,yr,zr = getElementRotation (veh)
	local zangle = math.rad(xr-180)+math.pi
	if zangle >= math.pi then
		zangle = (0 - math.pi*2)+zangle
	end
	createProjectile(getLocalPlayer(),19,x-(math.sin(math.rad(zr)))*4, y+(math.cos(math.rad(zr)))*4,z,1, nil, 0, 0, 180-zr, 1.5*math.cos(math.rad(zr+90)), 1.5*math.sin(math.rad(zr+90)), zangle)
end

function slamtrigger ()
	guiSetVisible (slamimg, true )
	setTimer ( function()
		guiSetVisible (slamimg, false )
	end, 100, 1 )
end

function barreltrigger ()
	guiSetVisible (barrelimg, true )
	setTimer ( function()
		guiSetVisible (barrelimg, false )
	end, 2000, 1 )
end

function counter(point)
		if point == 0 then
			guiSetVisible (xtraimg, true )
			guiSetVisible (invincimg, true )
			guiSetVisible (countimg, true )
		setTimer(counter, 1000, 1, 1)
	elseif point == 1 then
			guiStaticImageLoadImage ( countimg, "files/4.png" )
		setTimer(counter, 1000, 1, 2)
	elseif point == 2 then
			guiStaticImageLoadImage ( countimg, "files/3.png" )
		setTimer(counter, 1000, 1, 3)
	elseif point == 3 then
			guiStaticImageLoadImage ( countimg, "files/2.png" )
		setTimer(counter, 1000, 1, 4)
	elseif point == 4 then
			guiStaticImageLoadImage ( countimg, "files/1.png" )
		setTimer(counter, 1000, 1, 5)
	elseif point == 5 then
		guiSetVisible (xtraimg, false )
		guiSetVisible (countimg, false )
		guiSetVisible (invincimg, false )
		guiStaticImageLoadImage ( countimg, "files/5.png" )
		point = 0
	end
end

function inums ()
	guiStaticImageLoadImage ( inumimg, "files/i3.png" )
	guiSetVisible (inumimg, true )
	inumcount = 0
end

function inumtrigger ()
	inumcount = inumcount + 1
	if inumcount == 1 then
		guiStaticImageLoadImage ( inumimg, "files/i2.png" )
	elseif inumcount == 2 then
		guiStaticImageLoadImage ( inumimg, "files/i1.png" )
	elseif inumcount == 3 then
		guiStaticImageLoadImage ( inumimg, "files/i3.png" )
		guiSetVisible (inumimg, false )
	end
end

function inumhider ()
	guiSetVisible (xtraimg, false )
	guiSetVisible (inumimg, false )
end
