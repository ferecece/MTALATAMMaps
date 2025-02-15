local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)

local armed = false
local done = false
function onRender ( )
	local v = getPedOccupiedVehicle(localPlayer)
	if v then
		speedx, speedy, speedz = getElementVelocity ( v )
		mph = math.floor((speedx^2 + speedy^2 + speedz^2)^(0.5) * 111.847) --mph
		if mph > 50 and not armed then
			armed = true
			playSoundFrontEnd ( 4 ) 
		end
		if armed and mph < 50 and not done then
			blowVehicle(v)
			done = true
		end
		if armed then
    		dxDrawText ( mph, screenWidth/2, screenHeight/2, 100, 100, tocolor ( 255, 0, 0, 255 ), 1, 2, "pricedown" )
    	else
    		dxDrawText ( mph, screenWidth/2, screenHeight/2, 100, 100, tocolor ( 0, 255, 0, 255 ), 1, 2, "pricedown" )
    	end
	end
end
addEventHandler ( "onClientRender", root, onRender )