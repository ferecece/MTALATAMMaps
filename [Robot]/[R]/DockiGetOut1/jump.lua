function jump()      
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
        if (isVehicleOnGround( vehicle ) == true) then
		playSound ("hop.wav", false)          
		local sx,sy,sz = getElementVelocity ( vehicle )
		-- outputChatBox("#59CC00Vehicle Repaired", 255, 255, 255, true)
        setElementVelocity( vehicle ,sx, sy, sz+0.6 )
	fixVehicle(vehicle)
	end
end
bindKey ( "lshift","down", jump)

------------
--HelpText--
------------

local rootElement = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize()

function helpText ()

	Restangle = dxDrawRectangle (((screenWidth/2)-100), (screenHeight-40), 400, 80, tocolor( 0, 0, 0, 150 ))
	HelpText = dxDrawText ("Jump & Repair Vehicle: SHIFT", 0, 0, screenWidth, screenHeight-40, tocolor (255, 255, 255, 255), 0.7, 'bankgothic', "center", "bottom", false, false, false )
end
addEventHandler("onClientRender", rootElement, helpText)