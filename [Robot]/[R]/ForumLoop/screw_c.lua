local screw = getElementByID("SCREW")
local screwn = false

local SCREW_C = 59
local SCREW_D = 79
local SCREW_R = 180
local SCREW_T = 5000

setOcclusionsEnabled(false)

function checkScrew ()
	local cp = getElementData(localPlayer, "race.checkpoint")
	local x, y, z = getElementPosition ( screw )
	if (not cp or cp < SCREW_C) then 
		if screwn then
			screwn = false
			moveObject ( screw, 1, x, y, 26.22656, 0, 0, -SCREW_R )
		end
		return 
	end
	local x2, y2, z2 = getElementPosition ( localPlayer )
	local d = getDistanceBetweenPoints2D(x,y,x2,y2)
	if (d > SCREW_D and not screwn ) then
		moveObject ( screw, zToT(z), x, y, -1.8, 0, 0, zToRot(z) )
		screwn = true
	elseif (d < SCREW_D and screwn ) then
		moveObject ( screw, 15000, x, y, 26.22656, 0, 0, -SCREW_R )
		screwn = false
	end
end
addEventHandler ( "onClientPreRender", root, checkScrew )

function zToRot(z)
	local max = 26.22656 + 1.8
	local z2 = z + 1.8
	local div = z2 / max
	return SCREW_R * div
end

function zToT(z)
	local max = 26.22656 + 1.8
	local z2 = z + 1.8
	local div = z2 / max
	return SCREW_T * div
end

function reenableOcclusions()
	setOcclusionsEnabled(true)
end
addEventHandler("onClientResourceStop", resourceRoot, reenableOcclusions)