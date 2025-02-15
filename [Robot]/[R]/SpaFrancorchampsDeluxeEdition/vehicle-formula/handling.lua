local screenX, screenY = guiGetScreenSize()
local width = 500
local height = 80

local wndPopup = nil

addEventHandler("onClientResourceStart", getResourceRootElement(), 
	function()
		wndPopup = guiCreateLabel(0, screenY-height, width, height, '', false) -- guiCreateLabel((screenX - width) / 2, screenY - height, width, height, '', false)
		guiSetAlpha(wndPopup, 0)
		guiSetFont(wndPopup, "sa-gothic")
		guiSetProperty(wndPopup, "HorizontalAlignment", "Centre")
	end
)


local c_DefaultPopupTimeout = 5000 --ms
local c_FadeDelta = .03 --alpha per frame
local c_MaxAlpha = .9

local function fadeIn(wnd)
	local function raiseAlpha()
		local newAlpha = guiGetAlpha(wnd) + c_FadeDelta
		if newAlpha <= c_MaxAlpha then
			guiSetAlpha(wnd, newAlpha)
		else
			removeEventHandler("onClientRender", root, raiseAlpha)
		end
	end
	guiSetAlpha(wnd, 0)
	removeEventHandler("onClientRender", root, lowerAlpha)
	addEventHandler("onClientRender", root, raiseAlpha)
end

function lowerAlpha()
	local wnd = wndPopup
	local newAlpha = guiGetAlpha(wnd) - c_FadeDelta
	if newAlpha >= 0 then
		guiSetAlpha(wnd, newAlpha)
	else
		removeEventHandler("onClientRender", root, lowerAlpha)
		guiSetText(wnd, "")
		guiSetAlpha(wnd, 0)
	end
end

local function fadeOut(wnd)
	addEventHandler("onClientRender", root, lowerAlpha)
end



addEvent("onClientZoneChange", true)
addEventHandler("onClientZoneChange", getLocalPlayer(), 
	function(zoneName, checkpointNum)
		outputGuiPopup(zoneName, 3500)
	end
)


function outputGuiPopup(text, timeout)
	guiSetText(wndPopup, text)

	fadeIn(wndPopup)
	setTimer(fadeOut, timeout or 5000, 1, wndPopup)
end










---------------------------------------------------------------------------
-- Vector3D
---------------------------------------------------------------------------
Vector3D = {
	new = function(self, _x, _y, _z)
		local newVector = { x = _x or 0.0, y = _y or 0.0, z = _z or 0.0 }
		return setmetatable(newVector, { __index = Vector3D })
	end,

	Copy = function(self)
		return Vector3D:new(self.x, self.y, self.z)
	end,

	Normalize = function(self)
		local mod = self:Length()
		self.x = self.x / mod
		self.y = self.y / mod
		self.z = self.z / mod
	end,

	Dot = function(self, V)
		return self.x * V.x + self.y * V.y + self.z * V.z
	end,

	Length = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
	end,

	AddV = function(self, V)
		return Vector3D:new(self.x + V.x, self.y + V.y, self.z + V.z)
	end,

	SubV = function(self, V)
		return Vector3D:new(self.x - V.x, self.y - V.y, self.z - V.z)
	end,

	CrossV = function(self, V)
		return Vector3D:new(self.y * V.z - self.z * V.y,
							self.z * V.x - self.x * V.z,
							self.x * V.y - self.y * V.z)
	end,

	Mul = function(self, n)
		return Vector3D:new(self.x * n, self.y * n, self.z * n)
	end,

	Div = function(self, n)
		return Vector3D:new(self.x / n, self.y / n, self.z / n)
	end,
}
---------------------------------------------------------------------------




---------------------------------------------------------------------------
-- Math extentions
---------------------------------------------------------------------------
function math.lerp(from,to,alpha)
    return from + (to-from) * alpha
end

function math.unlerp(from,to,pos)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end


function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.wrap(low,value,high)
    while value > high do
        value = value - (high-low)
    end
    while value < low do
        value = value + (high-low)
    end
    return value
end

function math.wrapdifference(low,value,other,high)
    return math.wrap(low,value-other,high)+other
end

-- curve is { {x1, y1}, {x2, y2}, {x3, y3} ... }
function math.evalCurve( curve, input )
	-- First value
	if input<curve[1][1] then
		return curve[1][2]
	end
	-- Interp value
	for idx=2,#curve do
		if input<curve[idx][1] then
			local x1 = curve[idx-1][1]
			local y1 = curve[idx-1][2]
			local x2 = curve[idx][1]
			local y2 = curve[idx][2]
			-- Find pos between input points
			local alpha = (input - x1)/(x2 - x1);
			-- Map to output points
			return math.lerp(y1,y2,alpha)
		end
	end
	-- Last value
	return curve[#curve][2]
end

function math.round ( value )
	return math.floor ( value + 0.5 )
end






------------------------------------------------------
-- Stuff
------------------------------------------------------
handingDef1 = {
				accCurve = { {0, 0.015625}, {0.5, 0.055}, {1.125, 0.52}, {8, 0.337}, {11, 0.0} },
				decCurve = { {0, 0}, {0.5, 0}, {1, 1}, {12.6, 0.0} },
				rzCurve  = { {0, 0}, {0.5, 0}, {1, 1}, {12.6, 0.0} },
				dfCurve  = { {0, 0}, {0.5, 0}, {1, 1}, {12.6, 0.0} },
				accScale = 0.33,
				decScale = 0.2,
				rzScale  = 0.0,
				dfScale  = 0.15,
			}

function applyHanding ( ticks, veh, def )
		local seconds = ticks / 1000

		-- Input
		local inputAccelerate = getControlState ( 'accelerate' ) and 1 or getAnalogControlState( 'accelerate' )
		local inputBrake  =  getControlState ( 'brake_reverse' ) and 1 or getAnalogControlState( 'brake_reverse' )

		-- Get vehicle state
		local vx, vy, vz = getElementVelocity( veh )
		local rx, ry, rz = getVehicleTurnVelocity ( veh )
		local speed = getDistanceBetweenPoints3D( 0, 0, 0, vx, vy, vz )
		local matrix = getElementMatrix(veh)
		local fwd = Vector3D:new( matrix[2][1], matrix[2][2], matrix[2][3] )
		local up = Vector3D:new( matrix[3][1], matrix[3][2], matrix[3][3] )
		local upNess = up:Dot( Vector3D:new( 0, 0, 1 ) )
		local onGroundNess = isVehicleOnGround ( veh ) and 1 or 0

		-- Get apply amounts
		local accAlpha = math.evalCurve ( def.accCurve, speed )
		local decAlpha = math.evalCurve ( def.decCurve, speed )
		local rzAlpha = math.evalCurve ( def.rzCurve, speed )
		local dfAlpha = math.evalCurve ( def.dfCurve, speed )

		-- Apply acceleration
		local addmul = def.accScale * seconds * inputAccelerate * accAlpha
		local toAdd = fwd:Mul( addmul )
		vx = vx + toAdd.x
		vy = vy + toAdd.y
		vz = vz + toAdd.z

		-- Apply braking
		local toMul = 1 - math.min( 1, def.decScale * seconds * inputBrake ) * decAlpha
		vx = vx * toMul
		vy = vy * toMul
		vz = vz * toMul

		-- Apply spin
		rz = rz + rz * def.rzScale * seconds * inputAccelerate * rzAlpha
		setVehicleTurnVelocity ( veh, rx, ry, rz )

		-- Apply down force
		vz = vz - def.dfScale * seconds * dfAlpha

		-- Set vehicle state
		setElementVelocity ( veh, vx, vy, vz )
		setVehicleTurnVelocity ( veh, rx, ry, rz )


		if showspeed then
			local x,y = 1, 0
			local desc = string.format( "Speed: %2.0f", speed*100 )
			dxDrawText ( desc, x+1, y+1, x+1, y+1, tocolor(0,0,0,255) )
			dxDrawText ( desc, x, y )
		end
end

local lastUpdate = 0

function InitHandling()
	addEventHandler("onClientPreRender", root,
		function (ticks)
			local veh = getPedOccupiedVehicle(getLocalPlayer())
			if veh then
				applyHanding(ticks, veh, handingDef1)
				local time = getTickCount()
				if time - lastUpdate > 1000 then
					lastUpdate = time
					--exports.race_nos2:SetSpeedometerMaxValue(360)
				end
			end
		end
	)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), InitHandling)

