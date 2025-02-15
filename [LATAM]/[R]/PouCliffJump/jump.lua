local canJump = true

function initBind()
	bindKey("lshift", "down", jumpKey)
	outputChatBox("Salta con el skate con la tecla 'Shift izquierdo'")
end
addEventHandler("onClientResourceStart", resourceRoot, initBind)

function jumpKey()
	if not isPedInVehicle(localPlayer) then return end

	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle) == localPlayer then
		local vehType = getVehicleType(vehicle)
		if vehType == "Plane" or vehType == "Helicopter" then return end
		if canJump then
			local sx, sy, sz = getElementVelocity(vehicle)
			setElementVelocity(vehicle, sx, sy, sz + 0.33)
			canJump = false
			setTimer(checkIfVehicleOnGround, 1000, 1, vehicle)
		end
	end
end

function checkIfVehicleOnGround(vehicle)
	if not isElement(vehicle) then return end
	if isVehicleOnGround(vehicle) then
		canJump = true
	else
		setTimer(checkIfVehicleOnGround, 1000, 1, vehicle)
	end
end

addEventHandler("onClientRender", root, function()
	if not isPedInVehicle(localPlayer) then
		canJump = true
	end
end)
