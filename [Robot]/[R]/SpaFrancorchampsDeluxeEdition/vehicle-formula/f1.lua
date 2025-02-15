g_Root = getRootElement()
g_ResRoot = getResourceRootElement()
g_Me = getLocalPlayer()
local boost = 1.1
local carspeed,carboost,carbrake = 500,(boost * 0.003) + 1,(boost * 0.008) + 1
local carid = 415

g_GuiLabel = { }
local show = true

addEventHandler("onClientResourceStart", g_ResRoot, 
	function()
		GuiShow()
		replaceCar("ford")
		addEventHandler ( "onClientRender", g_Root, checkSpeed )
	end
)

function GuiInitialize()
	local screenWidth, screenHeight = guiGetScreenSize()
	local x,y,width,height = -110,-10,100,100
	if screenWidth < 1280 and screenHeight < 1024 then
		resAdjust = adjust
	else resAdjust = function(x) return x end
	end
	x = resAdjust(x)
	y = resAdjust(y)
	width = resAdjust(width)
	height = resAdjust(height)
	if x < 0 then
		x = screenWidth - width + x
	end
	if y < 0 then
		y = screenHeight - height + y
	end
	g_GuiLabel.bg = guiCreateStaticImage(x-20,y-10,width+40, height+20 ,":race_player_stats/images/Speedo.png",false)
	g_GuiLabel.Speed = guiCreateLabel(x, y, width, height, "0", false)
	g_GuiLabel.Unit = guiCreateLabel(x, y+35, width, height, "km/h", false)
	guiSetFont(g_GuiLabel.Speed, "sa-header")
	guiSetFont(g_GuiLabel.Unit, "sa-header")
	guiLabelSetHorizontalAlign(g_GuiLabel.Speed, "center")
	guiLabelSetHorizontalAlign(g_GuiLabel.Unit, "center")
end
function GuiShow()
	if not g_GuiLabel.Speed then
		GuiInitialize()
	end
	guiSetVisible(g_GuiLabel.Speed, true)
	guiSetVisible(g_GuiLabel.Unit, true)
	guiSetVisible(g_GuiLabel.bg, true)
end
function GuiHide()
	guiSetVisible(g_GuiLabel.Speed, false)
	guiSetVisible(g_GuiLabel.Unit, false)
	guiSetVisible(g_GuiLabel.bg, false)
end

function adjust(num)
	if not g_ScreenWidth then
		g_ScreenWidth, g_ScreenHeight = guiGetScreenSize()
	end
	if g_ScreenWidth < 1280 then
		return math.floor(num*g_ScreenWidth/1280)
	else
		return num
	end
end

function replaceCar(arg)
	local txd, dff, col
	txd = engineLoadTXD(arg..".txd")
	engineImportTXD(txd, carid)
	if not txd then
		outputConsole(arg..".txd couldn't be loaded")
	end
		
	if false then
		col = engineLoadCOL(arg..".col", carid)
		if not col then
			outputConsole(arg..".col couldn't be loaded")
		end
	end
		
	dff = engineLoadDFF(arg..".dff", carid)
	local success
	if col then
		success = engineReplaceCOL(col, carid)
	end
	local modelSuccess = engineReplaceModel(dff, carid)
	if not modelSuccess then
		outputConsole("renault.dff couldn't be loaded")
	end
		
	if false then
		setTimer(engineSetModelLODDistance, 1000, 1, carid, "lod")
	end	
end

function checkSpeed()
	local vehicle =  getPedOccupiedVehicle(getLocalPlayer())
    if vehicle and getElementModel(vehicle) ~= carid then return end
	local speed = getPlayerSpeed (g_Me)
	if getControlState ( "accelerate") or getAnalogControlState( "accelerate" ) > 0 then
		--if speed > stats.topspeed then stats.topspeed = speed end
		local x, y, z = getElementVelocity(vehicle)
		if speed >= 1 and speed <= carspeed then
			setElementVelocity(vehicle, x*carboost, y*carboost, z)
		elseif pit then setElementVelocity(vehicle, x*0.95, y*0.95, z)
		end
	end
	if getControlState ( "brake_reverse") or getAnalogControlState( "brake_reverse" ) > 0 then		
		if speed >= 38 then
			local x, y, z = getElementVelocity(vehicle)
			setElementVelocity(vehicle, x/carbrake, y/carbrake, z)
		end
	end
	if vehicle then
		local tboost = boost
		local hp = 1000-getElementHealth(vehicle)
		tboost = tboost < boost and boost or tboost
		tboost = hp > 75 and tboost - hp/10000 or tboost -- 90%
		tboost = hp > 300 and tboost - hp/2500 or tboost -- 60%
		tboost = hp > 525 and tboost - hp/1000 or tboost -- 30%
		carboost,carbrake = (tboost * 0.003) + 1,(tboost * 0.008) + 1
	end
	if guiGetVisible(g_GuiLabel.Speed) then guiSetText(g_GuiLabel.Speed, tostring(speed)) end
end

function getPlayerSpeed( source )
	if (isPedInVehicle( source ) == true) then
		vehicle = getPedOccupiedVehicle( source )
		return math.floor(getDistanceBetweenPoints3D(0,0,0,getElementVelocity(vehicle)) * 100 * 1.61 * 1.14)
	else
		return 0
	end
end