function plrJump()
local vehicle = getPedOccupiedVehicle(localPlayer)
if (isVehicleOnGround( vehicle ) == true) then 
local sx,sy,sz = getElementVelocity ( vehicle )
setElementVelocity( vehicle ,sx, sy, sz+0.37 )
end
end

for keyName, state in pairs(getBoundKeys("jump")) do
	bindKey(keyName, "down", plrJump)
end
