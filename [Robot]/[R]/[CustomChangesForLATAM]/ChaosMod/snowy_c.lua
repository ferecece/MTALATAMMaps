settings = {type = "real", density = 1500, wind_direction = {0.01,0.01}, wind_speed = 1, snowflake_min_size = 1, snowflake_max_size = 3, fall_speed_min = 1, fall_speed_max = 2, jitter = true}

local bEffectEnabled
local noiseTexture
local snowShader
local treeShader
local naughtyTreeShader

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect clever stuff
----------------------------------------------------------------
----------------------------------------------------------------
local maxEffectDistance = 250		-- To speed up the shader, don't use it for objects further away than this

-- List of world texture name matches
-- (The ones later in the list will take priority) 
local snowApplyList = 
{
	"*",				-- Everything!
}

-- List of world textures to exclude from this effect
local snowRemoveList = {
	"",												-- unnamed

	"vehicle*", "?emap*", "?hite*",					-- vehicles
	"*92*", "*wheel*", "*interior*",				-- vehicles
	"*handle*", "*body*", "*decal*",				-- vehicles
	"*8bit*", "*logos*", "*badge*",					-- vehicles
	"*plate*", "*sign*",							-- vehicles
	"headlight", "headlight1",						-- vehicles

	"shad*",										-- shadows
	"coronastar",									-- coronas
	"tx*",											-- grass effect
	"lod*",											-- lod models
	"cj_w_grad",									-- checkpoint texture
	"*cloud*",										-- clouds
	"*smoke*",										-- smoke
	"sphere_cj",									-- nitro heat haze mask
	"particle*",									-- particle skid and maybe others
}

local treeApplyList = {
	"sm_des_bush*", "*tree*", "*ivy*", "*pine*",	-- trees and shrubs
	"veg_*", "*largefur*", "hazelbr*", "weeelm",
	"*branch*", "cypress*",
	"*bark*", "gen_log", "trunk5",
	"bchamae", "vegaspalm01_128",
}

local naughtyTreeApplyList = {
	"planta256", "sm_josh_leaf", "kbtree4_test", "trunk3",					-- naughty trees and shrubs
	"newtreeleaves128", "ashbrnch", "pinelo128", "tree19mi",
	"lod_largefurs07", "veg_largefurs05","veg_largefurs06",
	"fuzzyplant256", "foliage256", "cypress1", "cypress2",
}


function enableGroundSnow()
	if bEffectEnabled then return end

	snowShader = dxCreateShader ("bin/snow_ground.fx", 0, maxEffectDistance)
	treeShader = dxCreateShader("bin/snow_trees.fx")
	naughtyTreeShader = dxCreateShader("bin/snow_naughty_trees.fx")
	sNoiseTexture = dxCreateTexture("bin/smallnoise3d.dds")

	if not snowShader or not treeShader or not naughtyTreeShader or not sNoiseTexture then return nil end

	-- Setup shaders
	dxSetShaderValue(treeShader, "sNoiseTexture", sNoiseTexture)
	dxSetShaderValue(naughtyTreeShader, "sNoiseTexture", sNoiseTexture)
	dxSetShaderValue(snowShader, "sNoiseTexture", sNoiseTexture)
	dxSetShaderValue(snowShader, "sFadeEnd", maxEffectDistance)
	dxSetShaderValue(snowShader, "sFadeStart", maxEffectDistance/2)

	-- Process tree apply list
	for _,applyMatch in ipairs(treeApplyList) do
		engineApplyShaderToWorldTexture (treeShader, applyMatch)
	end

	-- Process naughty tree apply list
	for _,applyMatch in ipairs(naughtyTreeApplyList) do
		engineApplyShaderToWorldTexture (naughtyTreeShader, applyMatch)
	end

	-- Init vehicle checker
	doneVehTexRemove = {}
	vehTimer = setTimer(checkCurrentVehicle, 100, 0)
	removeVehTextures()

	-- Flag effect as running
	bEffectEnabled = true
end

--------------------------------
-- Switch effect off
--------------------------------
function disableGroundSnow()
	if not bEffectEnabled then return end

	-- Destroy all elements
	destroyElement(sNoiseTexture )
	destroyElement(treeShader)
	destroyElement(naughtyTreeShader)
	destroyElement(snowShader)

	killTimer(vehTimer)

	-- Flag effect as stopped
	bEffectEnabled = false
end
addEventHandler("onClientResourceStop", resourceRoot, disableGroundSnow)

----------------------------------------------------------------
-- removeVehTextures
--		Keep effect off vehicles
----------------------------------------------------------------
local nextCheckTime = 0
local bHasFastRemove = getVersion().sortable > "1.1.1-9.03285"

addEventHandler("onClientPlayerVehicleEnter", root, function() removeVehTexturesSoon() end )

-- Called every 100ms
function checkCurrentVehicle()
	local veh = getPedOccupiedVehicle(localPlayer)
	local id = isElement(veh) and getElementModel(veh)
	if lastveh ~= veh or lastid ~= id then
		lastveh = veh
		lastid = id
		removeVehTexturesSoon()
	end
	if nextCheckTime < getTickCount() then
		nextCheckTime = getTickCount() + 5000
		removeVehTextures()
	end
end

-- Called the players current vehicle need processing
function removeVehTexturesSoon ()
    nextCheckTime = getTickCount() + 200
end

-- Remove textures from players vehicle from effect
function removeVehTextures ()
	if not bHasFastRemove then return end

	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local id = getElementModel(veh)
		local vis = engineGetVisibleTextureNames("*",id)
		-- For each texture
		if vis then	
			for _,removeMatch in pairs(vis) do
				-- Remove for each shader
				if not doneVehTexRemove[removeMatch] then
					doneVehTexRemove[removeMatch] = true
					engineRemoveShaderFromWorldTexture (snowShader, removeMatch)
				end
			end
		end
	end
end

----------------------------------------------------------------
-- Unhealthy hacks
----------------------------------------------------------------
_dxCreateShader = dxCreateShader
function dxCreateShader(filepath, priority, maxDistance, bDebug)
	priority = priority or 0
	maxDistance = maxDistance or 0
	bDebug = bDebug or false

	-- Slight hack - maxEffectDistance doesn't work properly before build 3236 if fullscreen
	local build = getVersion ().sortable:sub(9)
	local fullscreen = not dxGetStatus ().SettingWindowed
	if build < "03236" and fullscreen then
		maxDistance = 0
	end

	return _dxCreateShader (filepath, priority, maxDistance, bDebug)
end

local snowflakes = {}
local snowing = false

local box_width, box_depth, box_height, box_width_doubled, box_depth_doubled = 4,4,4,8,8
local position = {0,0,0}
local flake_removal = nil
local snow_fadein = 10
local snow_id = 1

sx,sy = guiGetScreenSize()
sx2,sy2 = sx/2,sy/2
localPlayer = getLocalPlayer()


--local random = math.random
function random(lower,upper)
	return lower+(math.random()*(upper-lower))
end

function startSnow()
	if not snowing then
		snowflakes = {}
			
		local lx,ly,lz = getWorldFromScreenPosition(0,0,1)
		local rx,ry,rz = getWorldFromScreenPosition(sx,0,1)
		box_width = getDistanceBetweenPoints3D(lx,ly,lz,rx,ry,rz)+3 -- +1.5 each side of the screen
		box_depth = box_width

		box_width_doubled = box_width*2
		box_depth_doubled = box_depth*2

		lx,ly,lz = getWorldFromScreenPosition(sx2,sy2,box_depth)
		position = {lx,ly,lz}		

		-- let it snow
		for i=1, settings.density do
			local x,y,z = random(0,box_width*2),random(0,box_depth*2),random(0,box_height*2)
			createFlake(x-box_width,y-box_depth,z-box_height,0)
		end

		addEventHandler("onClientRender",root,drawSnow)
		snowing = true
		return true
	else return false end
	return false
end

function stopSnow()
	if snowing then
		removeEventHandler("onClientRender", root, drawSnow)
		for i,flake in pairs(snowflakes) do
			snowflakes[i] = nil
		end
		snowflakes = nil
		flake_removal = nil
		snowing = false
	
		return true
	end
	return false
end
addEventHandler("onClientResourceStop",resourceRoot,stopSnow)


function updateSnowType(type)
	if type then
		settings.type = type
		return true
	end
	return false
end


function updateSnowDensity(dense,blend,speed)
	if dense and tonumber(dense) then
		dense = tonumber(dense)
		if snowing then
			if blend then
				-- if we are blending in more flakes
				if dense > settings.density then
					-- default speed
					if not tonumber(speed) then
						speed = 300
					end
					-- create 1/20 of the new amount every 'speed'ms for 20 iterations
					setTimer(function(old,new)
						for i=1, (new-old)/20, 1 do
							local x,y = random(0,box_width*2),random(0,box_depth*2)
							createFlake(x-box_width,y-box_depth,box_height,0)							
						end
					end,tonumber(speed),20,settings.density,dense)
				
				-- if we are blending out existing flakes, just flag that we should stop recreating them and check in createFlake()
				elseif dense < settings.density then
					if not tonumber(speed) then
						speed = 10
					end
					flake_removal = {settings.density-dense,0,tonumber(speed)}
				end
				
				if not tonumber(speed) then
					speed = 0
				end
			else
				speed = 0
				if dense > settings.density then
					for i=settings.density+1, dense do
						local x,y = random(0,box_width*2),random(0,box_depth*2)
						createFlake(x-box_width,y-box_depth,box_height,0)				
					end
				elseif dense < settings.density then
					for i=density, dense+1, -1 do
						table.remove(snowflakes,i)
					end
				end
			end
		else
			speed = 0
		end
		
		settings.density = tonumber(dense)
		return true
	end
	return false
end


function updateSnowWindDirection(xdir,ydir)
	if xdir and tonumber(xdir) and ydir and tonumber(ydir) then
		settings.wind_direction = {tonumber(xdir)/100,tonumber(ydir)/100}
		return true
	end
	return false
end


function updateSnowWindSpeed(speed)
	if speed and tonumber(speed) then
		settings.wind_speed = tonumber(speed)
		return true
	end
	return false
end


function updateSnowflakeSize(min,max)
	if min and tonumber(min) and max and tonumber(max) then
		settings.snowflake_min_size = tonumber(min)
		settings.snowflake_max_size = tonumber(max)
		return true
	end
	return false
end


function updateSnowFallSpeed(min,max)
	if min and tonumber(min) and max and tonumber(max) then
		settings.fall_speed_min = tonumber(min)
		settings.fall_speed_max = tonumber(max)
		return true
	end
	return false
end


function updateSnowAlphaFadeIn(alpha)
	if alpha and tonumber(alpha) then
		snow_fadein = tonumber(alpha)
		return true
	end
	return false
end


function updateSnowJitter(jit)
	settings.jitter = jit
end


function createFlake(x,y,z,alpha,i)	
	if flake_removal then
		if (flake_removal[2] % flake_removal[3]) == 0 then
			flake_removal[1] = flake_removal[1] - 1
			if flake_removal[1] == 0 then
				flake_removal = nil
			end
			table.remove(snowflakes,i)
			return
		else
			flake_removal[2] = flake_removal[2] + 1
		end
	end
	
	snow_id = (snow_id % 4) + 1
	
	if i then
		local randy = math.random(0,180)
		snowflakes[i] = {x = x, y = y, z = z, 
						 speed = math.random(settings.fall_speed_min,settings.fall_speed_max)/100, 
						 size = 2^math.random(settings.snowflake_min_size,settings.snowflake_max_size), 
						 section = {(snow_id % 2 == 1) and 0 or 32,  (snow_id < 3) and 0 or 32},
						 rot = randy, 
						 alpha = alpha, 
						 jitter_direction = {math.cos(math.rad(randy*2)), -math.sin(math.rad(math.random(0,360)))}, 
						 jitter_cycle = randy*2,
						 jitter_speed = 8
						}
	else
		local randy = math.random(0,180)
		table.insert(snowflakes,{x = x, y = y, z = z, 
								 speed = math.random(settings.fall_speed_min,settings.fall_speed_max)/100, 
								 size = 2^math.random(settings.snowflake_min_size,settings.snowflake_max_size),
								 section = {(snow_id % 2 == 1) and 0 or 32,  (snow_id < 3) and 0 or 32},
								 rot = randy, 
								 alpha = alpha,
								 jitter_direction = {math.cos(math.rad(randy*2)), -math.sin(math.rad(math.random(0,360)))}, 
								 jitter_cycle = randy*2,
								 jitter_speed = 8
								}					 
					)
	end
end



function drawSnow()	
	local tick = getTickCount()
	
	local cx,cy,cz = getCameraMatrix()

	local lx,ly,lz = getWorldFromScreenPosition(sx2,sy2,box_depth)

	--local hit,hx,hy,hz = processLineOfSight(lx,ly,lz,lx,ly,lz+20,true,true,false,true,false,true,false,false,localPlayer)
	if (isLineOfSightClear(cx,cy,cz,cx,cy,cz+20,true,false,false,true,false,true,false,localPlayer) or
		isLineOfSightClear(lx,ly,lz,lx,ly,lz+20,true,false,false,true,false,true,false,localPlayer)) then
		
		-- if we are underwater, substitute the water level for the ground level
		local check = getGroundPosition
		if testLineAgainstWater(cx,cy,cz,cx,cy,cz+20) then
			check = getWaterLevel
		end
	--	local gz = getGroundPosition(lx,ly,lz)
	
		-- split the box into a 3x3 grid, each section of the grid takes its own ground level reading to apply for every flake within it	
		local gpx,gpy,gpz = lx+(-box_width),ly+(-box_depth),lz+15
				
		local ground = {}
		
		for i=1, 3 do
			local it = box_width_doubled*(i*0.25)
			ground[i] = {
				check(gpx+(it), gpy+(box_depth_doubled*0.25), gpz),
				check(gpx+(it), gpy+(box_depth_doubled*0.5), gpz),
				check(gpx+(it), gpy+(box_depth_doubled*0.75), gpz)
			}
		end	
			
		--	outputDebugString(string.format("Gn: %.1f %.1f %.1f",ground[i][1],ground[i][2],ground[i][3]))
		--	outputDebugString(string.format("Gy: %.1f %.1f %.1f",groundy[i][1],groundy[i][2],groundy[i][3]))

	--	outputDebugString(string.format("%.1f %.1f %.1f, %.1f %.1f %.1f, %.1f %.1f %.1f",ground[1][1],ground[1][2],ground[1][3],ground[2][1],ground[2][2],ground[2][3],ground[3][1],ground[3][2],ground[3][3]))
	--	outputDebugString(string.format("%.1f %.1f %.1f, %.1f %.1f %.1f",(-box_width)+grid[1],(-box_width)+grid[1]*3,(-box_width)+grid[1]*5,(-box_depth)+grid[2],(-box_depth)+grid[2]*3,(-box_depth)+grid[2]*5))
	
		local dx,dy,dz = position[1]-lx,position[2]-ly,position[3]-lz
	
		--local alpha = (math.abs(dx) + math.abs(dy) + math.abs(dz))*15
		
	--	outputDebugString(tostring(alpha))
	

		for i,flake in pairs(snowflakes) do
			if flake then				
				-- check the flake hasnt moved beyond the box or below the ground
				-- actually, to preserve a constant density allow the flakes to fall past ground level (just dont show them) and remove once at the bottom of the box
			--	if (flake.z+lz) < ground[gx][gy] or flake.z < (-box_height) then
				if flake.z < (-box_height) then
				--	outputDebugString(string.format("Flake removed. %.1f %.1f %.1f",flake.x,flake.y,flake.z))
					-- createFlake(x, y, z, alpha, index)
					createFlake(random(0,box_width*2) - box_width, random(0,box_depth*2) - box_depth, box_height, 0, i)	
				else

					-- find the grid section the flake is in				
					local gx,gy = 2,2
					if flake.x <= (box_width_doubled*0.33)-box_width then gx = 1
					elseif flake.x >= (box_width_doubled*0.66)-box_width then gx = 3
					end
						
					if flake.y <= (box_depth_doubled*0.33)-box_depth then gy = 1
					elseif flake.y >= (box_depth_doubled*0.66)-box_depth then gy = 3
					end
					
					-- check it hasnt moved past the ground
					if ground[gx][gy] and (flake.z+lz) > ground[gx][gy] then
						local draw_x, draw_y, jitter_x, jitter_y = nil,nil,0,0
						
						-- draw all onscreen flakes
						if settings.jitter then
							local jitter_cycle = math.cos(flake.jitter_cycle) / flake.jitter_speed
							
							jitter_x = (flake.jitter_direction[1] * jitter_cycle)
							jitter_y = (flake.jitter_direction[2] * jitter_cycle)
						end
						
						draw_x,draw_y = getScreenFromWorldPosition(flake.x + lx + jitter_x, flake.y + ly + jitter_y ,flake.z + lz, 15, false)	
						
						if draw_x and draw_y then
							--	outputDebugString(string.format("Drawing flake %.1f %.1f",draw_x,draw_y))
						
							-- only draw flakes that are infront of the player
							-- peds seem to have very vague collisions, resulting in a dome-like space around the player where no snow is drawn, so leave this out due to it looking rediculous
							--	if isLineOfSightClear(cx,cy,cz,flake.x+lx,flake.y+ly,flake.z+lz,true,true,true,true,false,false,false,true) then
							--dxDrawImage(draw_x,draw_y,flake.size,flake.size,"bin/flakes/snowflake"..tostring(flake.image).."_".. settings.type ..".png",flake.rot,0,0,tocolor(222,235,255,flake.alpha))
							dxDrawImageSection(draw_x, draw_y, flake.size, flake.size, flake.section[1], flake.section[2], 32, 32, "bin/flakes/".. settings.type .. "_tile.png", flake.rot, 0, 0, tocolor(222,235,255,flake.alpha))
							--	end
							
							-- rotation and alpha (do not need to be done if the flake isnt being drawn)
							flake.rot = flake.rot + settings.wind_speed
										
							if flake.alpha < 255 then
								flake.alpha = flake.alpha + snow_fadein --[[+ alpha]]
								if flake.alpha > 255 then flake.alpha = 255 end
							end	
						else
						--	outputDebugString(string.format("Cannot find screen pos. %.1f %.1f %.1f",flake.x+lx,flake.y+ly,flake.z+lz))
						end
					end
	
				
					if settings.jitter then
						flake.jitter_cycle = (flake.jitter_cycle % 360) + 0.1
					end
					
					-- horizontal movement
					flake.x = flake.x + (settings.wind_direction[1] * settings.wind_speed)
					flake.y = flake.y + (settings.wind_direction[2] * settings.wind_speed)
				
					-- vertical movement
					flake.z = flake.z - flake.speed
					
					-- update flake position based on movement of the camera				
					flake.x = flake.x + dx
					flake.y = flake.y + dy
					flake.z = flake.z + dz
	
				--	outputDebugString(string.format("Diff: %.1f, %.1f, %.1f",position[1]-lx,position[2]-ly,position[3]-lz))
					
					if flake.x < -box_width or flake.x > box_width or
						flake.y < -box_depth or flake.y > box_depth or
						flake.z > box_height then

						--	outputDebugString(string.format("Flake removed (move). %.1f %.1f %.1f",flake.x,flake.y,flake.z))
						
						-- mirror flakes that were removed due to camera movement onto the opposite side of the box (and hope nobody notices)
						flake.x = flake.x - dx
						flake.y = flake.y - dy
						local x,y,z = (flake.x > 0 and -flake.x or math.abs(flake.x)),(flake.y > 0 and -flake.y or math.abs(flake.y)),random(0,box_height*2)
					
						createFlake(x, y, z - box_height, 255, i)	
					end
				end
			end
		end
	end
	position = {lx,ly,lz}
end

shaders = {}

textures = {
	{"road", "texRep"},
	{"road2", "texRep"},
	{"ground", "texRep"},
	{"rails", "texRep"},
	{"lowground", "texRep"},
	{"bush", "texRep"},
	{"vehicletyres128", "texRep"},
	{"thread", "texRep"},
	{"CTP_tire_style1", "texRep"},
	{"CTP_tire_style2", "texRep"},
	{"tire_CTP", "texRep"},
	{"wheel_tire_SS", "texRep"},
	{"newtreeleavesb128", "texRep"},
	{"newtreeleaves128", "texRep"},
	{"Newtreed256", "texRep"},
	{"kb_ivy2_256", "texRep"},
	{"newhedgea", "texRep"},
	{"snowflakes", "texRep"},
	{"tiretrack", "texRep"},
	{"grass", "texRep"}
}

for k, v in pairs(textures) do
	shaders[v[1]] = dxCreateShader("bin/" .. v[2] .. ".fx")
	texture = dxCreateTexture("bin/textures/" .. v[1] .. ".png")
	dxSetShaderValue(shaders[v[1]], "gTexture", texture)
end

replaceTextures = {
	["Lae2_roads33"] = shaders["road"],
	["Lae2_roads34"] = shaders["road"],
	["Lae2_roads37"] = shaders["road"],
	["Lae2_roads26"] = shaders["road"],
	["snpedtest1"] = shaders["road"],
	["vegasdirtyroad1_256"] = shaders["road"],
	["vegasdirtyroad2_256"] = shaders["road"],
	["craproad1_LAe"] = shaders["road"],
	["craproad2_LAe"] = shaders["road"],
	["craproad3_LAe"] = shaders["road"],
	["vegasdirtypave2_256"] = shaders["ground"],
	["craproad5_LAe"] = shaders["ground"],
	["craproad6_LAe"] = shaders["ground"],
	["des_1line256"] = shaders["ground"],
	["des_1lineend"] = shaders["ground"],
	["craproad7_LAe7"] = shaders["road"],
	["metpat64"] = shaders["lowground"],
	["ws_traintrax1"] = shaders["lowground"],
	["ws_traingravel"] = shaders["lowground"],
	["trainground2"] = shaders["lowground"],
	["heliconcrete"] = shaders["lowground"],
	["dt_road"] = shaders["road"],
	["dt_road_stoplinea"] = shaders["lowground"],
	["crossing_law"] = shaders["ground"],
	["trainground1"] = shaders["ground"],
	["trainground3"] = shaders["ground"],
	["sjmhoodlawn41"] = shaders["ground"],
	["sjmscorclawn"] = shaders["ground"],
	["scumtiles3_lae"] = shaders["ground"],
	["comptwall4"] = shaders["ground"],
	["comptroof1"] = shaders["ground"],
	["shingles1"] = shaders["ground"],
	["ws_rooftarmac1"] = shaders["ground"],
	["lasrmd2_sjm"] = shaders["ground"],
	["stormdrain2_nt"] = shaders["ground"],
	["stormdrain1_nt"] = shaders["ground"],
	["lasrmd3_sjm"] = shaders["ground"],
	["dirt64b2"] = shaders["ground"],
	["dirtgaz64b"] = shaders["ground"],
	["bow_abattoir_conc2"] = shaders["ground"],
	["backalley1_lae"] = shaders["ground"],
	["roof11l256"] = shaders["ground"],
	["sjmlahus28"] = shaders["ground"],
	["adet"] = shaders["ground"],
	["sjmscorclawn3"] = shaders["ground"],
	["newtreeleaves128"] = shaders["newtreeleavesb128"],
	["newtreed256"] = shaders["newtreeleavesb128"],
	["elm_treegrn"] = shaders["newtreeleaves128"],
	["planta256"] = shaders["newtreeleaves128"],
	["cos_hiwaymid_256"] = shaders["road"],
	["cos_hiwayout_256"] = shaders["ground"],
	["badmarb1_lan"] = shaders["ground"],
	["dockpave_256"] = shaders["ground"],
	["sidelatino1_lae"] = shaders["ground"],
	["grifnewtex1x_las"] = shaders["ground"],
	["grifnewtex1b"] = shaders["ground"],
	["cityhallroof"] = shaders["ground"],
	["pavemiddirt_law"] = shaders["ground"],
	["sidewgrass1"] = shaders["ground"],
	["sidewgrass2"] = shaders["ground"],
	["sidewgrass3"] = shaders["ground"],
	["sidewgrass5"] = shaders["ground"],
	["sidewgrass_fuked"] = shaders["ground"],
	["grassdry_path_128HV"] = shaders["ground"],
	["grassdry_128HV"] = shaders["ground"],
	["concretenewb256"] = shaders["ground"],
	["concretebigb256128"] = shaders["ground"],
	["sandnew_law"] = shaders["ground"],
	["venwalkway_law"] = shaders["ground"],
	["waterclear256"] = shaders["snow"],
	["pier69_ground1"] = shaders["ground"],
	["grasstype3"] = shaders["ground"],
	["redclifftop256"] = shaders["ground"],
	["desgreengrass"] = shaders["ground"],
	["rocktbrn128"] = shaders["ground"],
	["vehicletyres128"] = shaders["vehicletyres128"],
	["thread"] = shaders["thread"],
	["CTP_tire_style1"] = shaders["CTP_tire_style1"],
	["CTP_tire_style2"] = shaders["CTP_tire_style2"],
	["tire_CTP"] = shaders["tire_CTP"],
	["wheel_tire_SS"] = shaders["wheel_tire_SS"],
	["tardor9"] = shaders["ground"],
	["wgush1"] = shaders["ground"],
	["concretemanky"] = shaders["ground"],
	["pinelo128"] = shaders["newtreeleavesb128"],
	["oakleaf1"] = shaders["newtreeleavesb128"],
	["oakleaf2"] = shaders["newtreeleavesb128"],
	["stormdrain6"] = shaders["ground"],
	["block2"] = shaders["ground"],
	["golf_heavygrass"] = shaders["ground"],
	["sm_agave_1"] = shaders["newtreeleavesb128"],
	["sm_minipalm1"] = shaders["newtreeleavesb128"],
	["starflower3"] = shaders["newtreeleavesb128"],
	["indund_64"] = shaders["ground"],
	["newhedgea"] = shaders["newhedgea"],
	["bow_church_grass_gen"] = shaders["ground"],
	["greyground256"] = shaders["ground"],
	["bow_church_grass_alt"] = shaders["ground"],
	["golf_hedge1"] = shaders["newhedgea"],
	["ws_nicepave"] = shaders["ground"],
	["grassshort2long256"] = shaders["ground"],
	["pinebranch2"] = shaders["newtreeleaves128"],
	["beachwalk_law"] = shaders["ground"],
	["grass_128hv"] = shaders["ground"],
	["grass_lawn_128hv"] = shaders["ground"],
	["grass_concpath_128hv"] = shaders["ground"],
	["tar_1line256hv"] = shaders["road2"],
	["pavebsand256"] = shaders["ground"],
	["pavebsandend"] = shaders["ground"],
	["desgreengrassmix"] = shaders["ground"],
	["desertgryard256"] = shaders["ground"],
	["desertgravelgrassroad"] = shaders["ground"],
	["grassbrn2rockbrng"] = shaders["ground"],
	["roadnew4_512"] = shaders["road"],
	["des_dirt2grass"] = shaders["ground"],
	["desmud"] = shaders["ground"],
	["dirttracksgrass256"] = shaders["road"],
	["desmudtrail"] = shaders["road"],
	["desmudgrass"] = shaders["ground"],
	["elm_treegrn2"] = shaders["newtreeleaves128"],
	["desmuddesgrsblend"] = shaders["ground"],
	["desertstones256"] = shaders["ground"],
	["stonestandkb2_128"] = shaders["ground"],
	["ws_hextile"] = shaders["ground"],
	["stormdrain3_nt"] = shaders["ground"],
	["tarmacplain_bank"] = shaders["ground"],
	["snpdwargrn1"] = shaders["ground"],
	["mono2_sfe"] = shaders["ground"],
	["mono1_sfe•"] = shaders["ground"],
	["grassgrn256"] = shaders["ground"],
	["newpavement"] = shaders["ground"],
	["mono3_sfe"] = shaders["ground"],
	["mono4_sfe"] = shaders["ground"],
	["tar_1line256hvblend"] = shaders["road2"],
	["tar_1line256hvblend2"] = shaders["road2"],
	["hedge2"] = shaders["newhedgea"],
	["tar_1line256hvblend"] = shaders["road2"],
	["grassdead1"] = shaders["ground"],
	["grassdeadbrn256"] = shaders["ground"],
	["grassdead1blnd"] = shaders["ground"],
	["forestfloor256"] = shaders["ground"],
	["lasclifface"] = shaders["ground"],
	["forestfloorgrass"] = shaders["ground"],
	["rocktbrn128blnd"] = shaders["ground"],
	["cs_rockdetail2"] = shaders["ground"],
	["desertgravelgrass256"] = shaders["newhedgea"],
	["aamanbev96x"] = shaders["ground"],
	["kb_ivy2_256"] = shaders["kb_ivy2_256"],
	["tar_1line256hvblenddrtdot"] = shaders["road2"],
	["tar_1line256hvblenddrt"] = shaders["road2"],
	["tar_freewyleft"] = shaders["road2"],
	["desgrassbrn_grn"] = shaders["ground"],
	["dirtblendlit"] = shaders["ground"],
	["grassbrn2rockbrn"] = shaders["ground"],
	["desgrassbrn"] = shaders["ground"],
	["grasstype4"] = shaders["ground"],
	["grasstype4_mudblend"] = shaders["ground"],
	["rocktq128_grass4blend"] = shaders["ground"],
	["txgrass1_1"] = shaders["kb_ivy2_256"],
	["tree19mi"] = shaders["newtreeleaves128"],
	["ws_patchygravel"] = shaders["ground"],
	["newcrop3"] = shaders["ground"],
	["bow_church_dirt"] = shaders["ground"],
	["grass4dirtytrans"] = shaders["ground"],
	["grasstype5_4"] = shaders["ground"],
	["grasstype5"] = shaders["ground"],
	["grasstype5_desdirt"] = shaders["ground"],
	["cw2_weeroad1"] = shaders["road"],
	["bullethitsmoke"] = shaders["snowflakes"],
	["particleskid"] = shaders["tiretrack"],
	["grasstype4_forestblend"] = shaders["ground"],
	["forestfloorblendded"] = shaders["road2○"],
	["forestfloor_sones256"] = shaders["ground"],
	["forestfloorblendded"] = shaders["ground"],
	["forest_rocks"] = shaders["ground"],
	["forestfloor3_forest"] = shaders["ground"],
	["forestfloor3"] = shaders["ground"],
	["cw2_mounttrail"] = shaders["ground"],
	["cw2_mounttrailblank"] = shaders["ground"],
	["rocktq128"] = shaders["ground"],
	["rock_country128"] = shaders["ground"],
	["rocktq128_forestblend"] = shaders["ground"],
	["rocktq128_forestblend2"] = shaders["ground"],
	["stones256"] = shaders["ground"],
	["mountainskree_stones256"] = shaders["road2"],
	["des_dirtgrassmixbmp"] = shaders["ground"],
	["des_dirtgrassmix_grass4"] = shaders["ground"],
	["des_dirtgrassmixb"] = shaders["ground"],
	["des_dirtgrassmixc"] = shaders["ground"],
	["grass4_des_dirt2"] = shaders["ground"],
	["cuntbrnclifftop"] = shaders["ground"],
	["cuntbrncliffbtmbmp"] = shaders["ground"],
	["forestfloor256_blenddirt"] = shaders["ground"],
	["sw_sand"] = shaders["ground"],
	["des_dirt1"] = shaders["ground"],
	["grasstype4blndtomud"] = shaders["road2"],
	["pavebsand256grassblended"] = shaders["ground"],
	["grasstype10"] = shaders["ground"],
	["grasstype4_10"] = shaders["ground"],
	["cw2_mountdirt"] = shaders["ground"],
	["cw2_mountdirt2grass"] = shaders["ground"],
	["cw2_mountdirtscree"] = shaders["ground"],
	["cw2_mountrock"] = shaders["ground"],
	["cw2_mountroad"] = shaders["road2"],
	["tar_freewyright"] = shaders["road2"],
	["ws_drysand2grass"] = shaders["ground"],
	["ws_drysand"] = shaders["ground"],
	["drvin_ground1"] = shaders["ground"],
	["ws_wetdryblendsand"] = shaders["ground"],
	["ws_wetsand"] = shaders["ground"],
	["ws_freeway3"] = shaders["road"],
	["ws_freeway3blend"] = shaders["road"],
	["sf_road5"] = shaders["road"],
	["sf_pave6"] = shaders["ground"],
	["sf_junction5"] = shaders["ground"],
	["fancy_slab128"] = shaders["ground"],
	["newrockgrass_sfw"] = shaders["ground"],
	["cst_rock_coast_sfw"] = shaders["ground"],
	["sf_junction3"] = shaders["ground"],
	["fancy_slab128"] = shaders["ground"],
	["pavetilealley256128"] = shaders["road2"],
	["sf_tramline2"] = shaders["rails"],
	["sf_pave2"] = shaders["ground"],
	["sf_pave3"] = shaders["ground"],
	["sf_pave4"] = shaders["ground"],
	["sf_pave5"] = shaders["ground"],
	["ws_airpt_concrete"] = shaders["ground"],
	["concretedust2_line"] = shaders["ground"],
	["cs_rockdetail2"] = shaders["ground"],
	["sw_stonesgrass"] = shaders["ground"],
	["grassbrn2rockbrng2"] = shaders["ground"],
	["sw_stones"] = shaders["ground"],
	["cs_rockdetail2"] = shaders["ground"],
	["dirttracksforest"] = shaders["road"],
	["sw_rockgrassb1"] = shaders["ground"],
	["sw_rockgrassb2"] = shaders["ground"],
	["sw_sandgrass4"] = shaders["ground"],
	["sw_rockgrass1"] = shaders["ground"],
	["carpark_128"] = shaders["ground"],
	["sw_newcorrug"] = shaders["ground"],
	["parking2plain"] = shaders["ground"],
	["parking2"] = shaders["ground"],
	["grass"] = shaders["ground"],
	["sw_corrug"] = shaders["ground"],
	["sw_crops"] = shaders["ground"],
	["sw_grassb01"] = shaders["ground"],
	["sw_grass01"] = shaders["ground"],
	["sw_dirt01lod"] = shaders["ground"],
	["sw_dirt01"] = shaders["ground"],
	["sw_cropslod"] = shaders["ground"],
	["sw_grass01a"] = shaders["ground"],
	["sw_farmroad01"] = shaders["road"],
	["des_dirt1grass"] = shaders["ground"],
	["hilltest2_las"] = shaders["kb_ivy2_256"],
	["desgreengrasstrckend"] = shaders["ground"],
	["roadnew4_256"] = shaders["road"],
	["des_dirt2"] = shaders["ground"],
	["sw_sandgrass"] = shaders["ground"],
	["desclifftypebsmix"] = shaders["ground"],
	["boardwalk_la"] = shaders["ground"],
	["cos_hiwayins_256"] = shaders["ground"],
	["sjmhoodlawn42b"] = shaders["ground"],
	["gb_nastybar08"] = shaders["ground"],
	["laroad_centre1"] = shaders["ground"],
	["laroad_offroad1"] = shaders["ground"],
	["grass_concpath2"] = shaders["ground"],
	["kbpavement_test"] = shaders["ground"],
	["brickred2"] = shaders["ground"],
	["ws_carparknew2"] = shaders["ground"],
	["ws_carparknew1"] = shaders["ground"],
	["sl_sfngrass01"] = shaders["ground"],
	["sl_roadbutt1"] = shaders["road"],
	["sl_pavebutt1"] = shaders["ground"],
	["sl_pavebutt2"] = shaders["ground"],
	["sl_sfngrssdrt01"] = shaders["ground"],
	["desertgryard256grs2"] = shaders["ground"],
	["grassgrnbrn256"] = shaders["ground"],
	["concretenewb256"] = shaders["ground"],
	["ws_rotten_concrete1"] = shaders["ground"],
	["ws_corr_metal1"] = shaders["ground"],
	["tenniscourt1_256"] = shaders["ground"],
	["ws_corr_plastic"] = shaders["ground"],
	["ws_carpark2"] = shaders["ground"],
	["ws_floortiles2"] = shaders["ground"],
	["ws_football_lines2"] = shaders["ground"],
	["ws_floortiles4"] = shaders["ground"],
	["ws_sub_pen_conc3"] = shaders["ground"],
	["ws_sub_pen_conc"] = shaders["ground"],
	["des_grass2dirt1"] = shaders["ground"],
	["des_roadedge1"] = shaders["ground"],
	["des_roadedge2"] = shaders["ground"],
	["tar_1line256hvtodirt"] = shaders["road2"],
	["brngrss2stones"] = shaders["ground"],
	["des_yelrock"] = shaders["ground"],
	["des_dirttrack1"] = shaders["road2"],
	["des_dirttrack1r"] = shaders["road2"],
	["des_dirttrackl"] = shaders["road2"],
	["grasstype5_dirt"] = shaders["ground"],
	["rocktq128_dirt"] = shaders["ground"],
	["des_redrock2"] = shaders["ground"],
	["des_redrock1"] = shaders["ground"],
	["des_dirt2blend"] = shaders["ground"],
	["des_dirt2stones"] = shaders["ground"],
	["des_dirt2track"] = shaders["ground"],
	["des_dirt2 trackl"] = shaders["ground"],
	["des_dirtgravel"] = shaders["ground"],
	["desstones_dirt1"] = shaders["ground"],
	["des_crackeddirt1"] = shaders["ground"],
	["des_rocky1"] = shaders["ground"],
	["des_rocky1_dirt1"] = shaders["ground"],
	["des_ripplsand"] = shaders["ground"],
	["parking1plain"] = shaders["ground"],
	["plaintarmac1"] = shaders["ground"],
	["des_scrub1"] = shaders["ground"],
	["des_scrub1_dirt1"] = shaders["ground"],
	["des_1line256"] = shaders["road2"],
	["des_oldrunway"] = shaders["ground"],
	["des_oldrunwayblend"] = shaders["ground"],
	["des_panelconc"] = shaders["ground"],
	["des_dirttrackx"] = shaders["ground"],
	["des_grass2scrub"] = shaders["ground"],
	["golf_heavygrass"] = shaders["ground"],
	["golf_greengrass"] = shaders["ground"],
	["golf_fairway3"] = shaders["ground"],
	["golf_fairway1"] = shaders["ground"],
	["seabed"] = shaders["ground"],
	["des_dirt1_glfhvy"] = shaders["ground"],
	["vgs_rockmid1a"] = shaders["ground"],
	["vgs_rockbot1a"] = shaders["ground"],
	["grasslawnfade_256"] = shaders["ground"],
	["yardgrass1"] = shaders["ground"],
	["concretedust2_256128"] = shaders["ground"],
	["con2sand1c"] = shaders["ground"],
	["des_scrub1_dirt1a"] = shaders["ground"],
	["des_scrub1_dirt1b"] = shaders["ground"],
	["con2sand1a"] = shaders["ground"],
	["con2sand1b"] = shaders["ground"],
	["vegasdirtyroad1_256"] = shaders["road"],
	["vegasroad3_256"] = shaders["road"],
	["vegasroad2_256"] = shaders["road"],
	["road2_256"] = shaders["road"],
	["vegasroad1_256"] = shaders["road"],
	["vegastriproad1_256"] = shaders["ground"],
	["vegasdirtypave1_256"] = shaders["ground"],
	["crossing_law3"] = shaders["ground"],
	["crossing_law2"] = shaders["ground"],
	["ws_carparknew2b"] = shaders["ground"],
	["hiwaymidlle_256"] = shaders["road"],
	["hiwayinside2_256"] = shaders["ground"],
	["hiwayinsideblend2_256"] = shaders["ground"],
	["hiwayinsideblend3_256"] = shaders["ground"],
	["hiwaygravel1_256"] = shaders["ground"],
	["hiway2sand1a"] = shaders["ground"],
	["hiwayoutside_256"] = shaders["ground"],
	["hiwayinside4_256"] = shaders["ground"],
	["hiwayinside5_256"] = shaders["ground"],
	["hiwayinside3_256"] = shaders["ground"],
	["hiwayinside1_256"] = shaders["ground"],
	["hiwayend_256"] = shaders["road"],
	["venturas_fwend"] = shaders["ground"],
	["tar_venturasjoin"] = shaders["road2"],
	["tar_1linefreewy"] = shaders["road2"],
	["block"] = shaders["ground"],
	["tar_lineslipway"] = shaders["road2"],
	["stormdrain5_nt"] = shaders["ground"],
	["des_dirt2gygrass"] = shaders["ground"],
	["des_dirt2dedgrass"] = shaders["ground"],
	["rocktbrn128blndlit"] = shaders["ground"],
	["blendrock2grgrass"] = shaders["ground"],
	["sfn_rocktbrn128"] = shaders["ground"],
	["sfn_rockhole"] = shaders["ground"],
	["sfn_grass1"] = shaders["ground"],
	["hedge1"] = shaders["newhedgea"],
	["sf_junction2"] = shaders["ground"],
	["greyground256128"] = shaders["ground"],
	["ws_slatetiles"] = shaders["ground"],
	["ws_carpark1"] = shaders["ground"],
	["was_scrpyd_ground_muddier"] = shaders["ground"],
	["bow_church_dirt_to_grass_side_t"] = shaders["ground"],
	["bow_grass_gryard"] = shaders["ground"],
	["ws_baseballdirt"] = shaders["ground"],
	["ws_rooftarmac2"] = shaders["ground"],
	["ws_asphalt2"] = shaders["ground"],
	["dustyconcrete"] = shaders["ground"],
	["ws_corr_metal2"] = shaders["ground"],
	["golf_grassrock"] = shaders["ground"],
	["golf_fairway2"] = shaders["ground"],
	["golf_gravelpath"] = shaders["ground"],
	["dt_road2grasstype4"] = shaders["ground"],
	["grass4dirty"] = shaders["ground"],
	["crazy paving"] = shaders["ground"],
	["cw2_mountdirt2forest"] = shaders["ground"],
	["grasstype510"] = shaders["ground"],
	["grasstype510_10"] = shaders["ground"],
	["grasstype10"] = shaders["ground"],
	["rocktq128blender"] = shaders["ground"],
	["grass10_stones256"] = shaders["ground"],
	["grass10_grassdeep1"] = shaders["ground"],
	["grassdeep1"] = shaders["ground"],
	["roadblendcunt"] = shaders["road2"],
	["forestfloorbranch256"] = shaders["ground"],
	["grassgrnbrnx256"] = shaders["ground"],
	["tar_1line256hvlightsand"] = shaders["road2"],
	["tar_1line256hvgtravel"] = shaders["road2"],
	["grass10forest"] = shaders["ground"],
	["sw_copgrass01"] = shaders["ground"],
	["rodeo3sjm"] = shaders["ground"],
	["grasstype10_rail"] = shaders["ground"],
	["grass10dirt"] = shaders["ground"],
	["grassdeep256"] = shaders["ground"],
	["grassdirtblend"] = shaders["road"],
	["forestfloor4"] = shaders["ground"],
	["grasstype4_staw"] = shaders["ground"],
	["grasstype4-3"] = shaders["ground"],
	["ws_traingravelblend"] = shaders["ground"],
	["ws_woodyhedge"] = shaders["newhedgea"],
	["hedgealphad1"] = shaders["newhedgea"],
	["veg_hedge1_256"] = shaders["newhedgea"],
	["txgrass0_1"] = shaders["grass"],
	["backalley1_LAe"] = shaders["ground"],
	["laemacpark02"] = shaders["ground"],
	["laemacpark01"] = shaders["ground"],
	["vegaspavement2_256"] = shaders["ground"],
	["blendpavement2_256"] = shaders["ground"],
	["blendpavement2b_256"] = shaders["ground"],
	["VegasEroad094"] = shaders["road"],
	["VegasEroad134"] = shaders["road"],
	["VegasEroad048"] = shaders["road"],
	["VegasEroad009"] = shaders["road"],
	["VegasEroad139"] = shaders["road"],
	["VegasEroad140"] = shaders["road"],
	["VegasEroad141"] = shaders["road"],
	["VegasEroad142"] = shaders["road"],
	["VegasEroad037"] = shaders["ground"],
	["VegasEroad036"] = shaders["road"],
	["VegasEroad023"] = shaders["road"],
	["VegasEroad008"] = shaders["road"],
	["vgsEedge14"] = shaders["road"],
	["vgsEedge15"] = shaders["road"],
	["vegasWedge24"] = shaders["road"],
	["vegasWedge11"] = shaders["road"],
	["vegasWedge111"] = shaders["road"],
	["vegasWedge22"] = shaders["road"],
	["vegasWedge23"] = shaders["road"],
	["vegasNedge01"] = shaders["road"],
	["vgsEedge15"] = shaders["road"],
	["vgsEedge16"] = shaders["road"],
	["vgsEedge17"] = shaders["road"],
	["vgsEedge18"] = shaders["road"],
	["vgsEedge19"] = shaders["road"],
	["vgsEland31_lvs"] = shaders["ground"],
	["vgsEland03_lvs"] = shaders["ground"],
	["vgsNedge11"] = shaders["road"],
	["vgsNedge16"] = shaders["road"],
	["VegasNroad0162"] = shaders["road"],
	["VegasNroad079"] = shaders["road"],
	["VegasNroad083"] = shaders["road"]
}

function applySnow(state)
	if (state) == true then
		for k, v in pairs(replaceTextures) do
			engineApplyShaderToWorldTexture(v, k)
		end
	elseif (state) == false then
		for k, v in pairs(replaceTextures) do
			engineRemoveShaderFromWorldTexture(v, k)
		end
	end
end

function snow_on()
	applySnow(true)
	for i = 0, 177 do
		engineSetSurfaceProperties(i, "wheeleffect", "disabled")
		engineSetSurfaceProperties(i, "skidmarktype", "disabled")
		engineSetSurfaceProperties(i, "audio", "water")
		engineSetSurfaceProperties(i, "roughness", 0)
	end
end

function snow_off()
	applySnow(false)
	for i = 0, 177 do
		engineResetSurfaceProperties(i)
	end	
end
addEventHandler("onClientResourceStop", root, snow_off)

function enableSnow()
	snow_on()
	enableGroundSnow()
	startSnow()
end

function disableSnow()
	snow_off()
	disableGroundSnow()
	stopSnow()
end