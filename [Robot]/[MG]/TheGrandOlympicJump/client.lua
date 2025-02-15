

-- Grand Olympic Jump Disco Rally Reversed Festive Editition
-- Grand Olympic Jump Rally Reversed Festive Editition
-- Grand Olympic Jump Rally: KEEP or ROLL
-- Grand Olympic Jump Festive Reroll Edition

setDevelopmentMode(true)
setCloudsEnabled (false)
local white = dxCreateTexture("white.png")
local keep = dxCreateTexture("keep.png")
local roll = dxCreateTexture("roll.png")
local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)


local vehicleNames = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perennial", "Sentinel", "Dumper", "Fire Truck", "Trashmaster", "Stretch", "Manana", 
    "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", 
    "Mr. Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", 
    "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", 
    "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", 
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", 
    "Quadbike", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", 
    "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking", 
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer 2", "Hotring Racer 3", "Bloodring Banger", 
    "Rancher Lure", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain", "Nebula", 
    "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune", "Cadrona", "FBI Truck", 
    "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Brown Streak", "Vortex", "Vincent", 
    "Bullet", "Clover", "Sadler", "Fire Truck Ladder", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility Van", 
    "Nevada", "Yosemite", "Windsor", "Monster 2", "Monster 3", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", 
    "Tahoma", "Savanna", "Bandito", "Freight Train Flatbed", "Streak Train Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", 
    "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer (Tanker Commando)", "Emperor", "Wayfarer", "Euros", "Hotdog", 
    "Club", "Box Freight", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police LS", "Police SF", "Police LV", "Police Ranger", 
    "Picador", "S.W.A.T.", "Alpha", "Phoenix", "Glendale Damaged", "Sadler Damaged", "Baggage Trailer (covered)", 
    "Baggage Trailer (Uncovered)", "Trailer (Stairs)", "Boxville Mission", "Farm Trailer", "Street Clean Trailer"}
local sorted_models = {530,572,574,531,432,486,408,406,601,573,444,578,524,509,483,514,481,403,515,431,508,532,499,455,510,609,588,498,414,423,443,418,482,478,416,526,456,459,401,410,419,401,410,552,437,419,438,525,485,518,536,534,500,471,457,475,504,575,542,576,567,412,535,599,439,436,492,413,440,582,467,474,466,491,540,529,546,549,566,545,547,550,527,600,543,405,445,422,517,551,580,516,507,585,583,554,568,424,428,427,470,490,407,495,544,528,421,409,420,555,433,462,521,522,581,463,461,448,586,468,523,565,558,429,562,560,480,559,434,561,597,402,589,603,602,596,426,587,477,533,496,598,494,541,506,415,451,411}


local max_speed, min_distance, jump_phase, ramp_clear
local stunt_score, health_score, speed_score, distance_score
local total_score = 0
local permanent_marker_score = 0
local judging = false

local start_air_col = createColCuboid ( -500, -2897.7299804688, 261, 100, 10, 300 )
function start_judging(hitElement)
	local elementType = getElementType(hitElement)
	if hitElement == localPlayer then
		local veh = getPedOccupiedVehicle(localPlayer)
		if not veh then
			return
		end
		jump_phase = true
	end
end
addEventHandler("onClientColShapeHit", start_air_col, start_judging)


function handleVehicleDamage(attacker, weapon, loss, x, y, z, tire)
    if getVehicleOccupant(source) == localPlayer then
    	jump_phase = false
    end
end
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)

local start_rx, start_ry, start_rz = 0,0,0
function reset_judge()
	max_speed = 0
	min_distance = 2000

	stunt_score = 0
	health_score = 0
	distance_score = 0
	speed_score = 0

	jump_phase = false
	judging = true
	ramp_clear = false

end
reset_judge()


function updateCamera ()

	-- Keep / Roll indicators
	dxDrawMaterialLine3D (  -544.56, -3404.31, 772,
                        	-544.56, -3404.31, 770,
                        	roll, 7.5, tocolor(177,255,4, 255), --material, width, color
                        	-544.56, 3304.31, 628.2) --face towards up

	dxDrawMaterialLine3D (  -564.56, -3404.31, 772,
                        	-564.56, -3404.31, 770,
                        	keep, 7.5, tocolor(0,255,0, 255), --material, width, color
                        	-544.56, 3304.31, 628.2) --face towards up

	dxDrawMaterialLine3D (  -554.56, -3404.31, 768.2,
                        	-534.56, -3404.31, 768.2,
                        	white, 10, tocolor(177,255,4, 155), --material, width, color
                        	-554.56, -3304.31, 628.2) --face towards up

	dxDrawMaterialLine3D (  -574.56, -3404.31, 768.2,
                        	-554.56, -3404.31, 768.2,
                        	white, 10, tocolor(0,255,0, 155), --material, width, color
                        	-574.56, -3304.31, 628.2) --face towards up

	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		return
	end

	if not judging then
		return
	end

	-- distance
	local x,y,z = getElementPosition(veh)
	local distance =  getDistanceBetweenPoints3D (-399.51953125, -2386.5595703125, 91.87, x, y, z)
	min_distance = math.min(distance, min_distance)
	distance_score = getScore((550 - math.min(min_distance,550))/550, 0.5)
    --dxDrawText ( distance, 300, 300, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
    --dxDrawText ( distance_score, 300, 320, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )

    -- vehicle health
    local health = getElementHealth (veh)
    health_score = getScore(math.min(health+1, 1001) / 1001, 1.5)
	--dxDrawText ( health_score, 300, 500, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )


	-- stunt jump
	if jump_phase then
	    local rx, ry, rz = getElementRotation ( veh )
	    local rxt = math.min(rx - start_rx, 360 - (rx - start_rx))
	    local ryt = math.min(ry - start_ry, 360 - (ry - start_ry))
	    local rzt = math.min(rz - start_rz, 360 - (rz - start_rz))
    	stunt_score = math.max(stunt_score, getScore(math.max(math.max(math.min(rxt, 180),math.min(ryt, 180)),math.min(rzt, 180))/180, 2))
    end
	--dxDrawText ( stunt_score, 300, 600, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )


    -- top speed
    local speedx, speedy, speedz = getElementVelocity ( veh )
	local actual_speed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	max_speed = math.max(max_speed, actual_speed)
	speed_score = getScore(math.min(max_speed, 2.31) / 2.31, 1.5)

	--dxDrawText ( actual_speed, 300, 350, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
	--dxDrawText ( max_speed, 300, 370, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
	--dxDrawText ( speed_score, 300, 390, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )


	total_score = (distance_score + health_score + stunt_score + speed_score)*2.5 + permanent_marker_score
	if y < -2906 then
		dxDrawText ("Score: " .. math.floor(total_score*100)/100, screenWidth/2, screenHeight/2, screenWidth, screenHeight, tocolor ( 255, 0, 0, 255 ), 2, "pricedown" )
	else
		ramp_clear = true
		dxDrawText ("Score: " .. math.floor(total_score*100)/100, screenWidth/2, screenHeight/2, screenWidth, screenHeight, tocolor ( 255, 255, 0, 255 ), 2, "pricedown" )
	end

end
addEventHandler ( "onClientRender", root,  updateCamera)

-- https://www.desmos.com/calculator/nnx152ryl5
function getScore(x, n)
	return 1 / (1 + (1/x -1)^n)
end


addEventHandler("onClientPlayerWasted", localPlayer, function(killer, weapon, bodyPart)
	if not ramp_clear then
		if getElementData(root, "racestate") == "Running" then
			permanent_marker_score = math.max(permanent_marker_score - 0.1, -0.5)
		end
	end
end)

-- local first_time = true
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), function()

	outputChatBox(
		"Total: " .. math.floor(total_score*100)/100 ..
		" (#86FF04Speed: " .. math.floor(speed_score*250)/100 .. 
		", #04FFD1Cool Stunt: " .. math.floor(stunt_score*250)/100 .. 
		", #BC04FFDistance: " .. math.floor(distance_score*250)/100 .. 
		", #FF0482Health: " .. math.floor(health_score*250)/100 .. 
		", #B0FF04Bonus: " .. permanent_marker_score .. 
		")",255,255,255,true)

	local new_model = getVehicleFromScore(total_score)

	reset_judge()

	setTimer(function()
		local veh = getPedOccupiedVehicle(localPlayer)
		setElementModel(veh, new_model)
	end,500,1)
	
end)

function getVehicleFromScore(score)
	score = math.floor((score - 4)/5.5 * #sorted_models)
	score = math.max(math.min(score, #sorted_models ), 1)
	return sorted_models[score]
end

local m = getElementByID('finish')
local impressed = false
function MarkerHit ( hitPlayer, matchingDimension )
	if hitPlayer == localPlayer then
		-- outputChatBox ( getPlayerName(hitPlayer) .. " entered a marker with score " .. total_score )
		veh = getPedOccupiedVehicle(localPlayer)
		if total_score < 10 then
			if judging then
				permanent_marker_score = permanent_marker_score + 0.1
			end
			judging = false
			blowVehicle(veh)
		else
			-- outputChatBox("Total: " .. math.floor(total_score*100)/100)
			if not impressed then
				impressed = true
				outputChatBox("You have impressed the judges.", 177, 255, 4)
				local x,y,z = getElementPosition(veh)
				local mover = createObject(1337,x,y,z)
				setElementAlpha(mover,0)
				attachElements(veh, mover)
				moveObject (mover, 10000, -399.22, -2386.51, 137 )
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", m, MarkerHit )


	
setTimer(function()
	setCloudsEnabled (false)
end,1000,0)


function reloadafterdownload() -- not sure if it needs to be done like this, because it might take some time to download the textures
	setCloudsEnabled (false)
	txd = engineLoadTXD ( "sparrow.txd" )
	dff = engineLoadDFF ( "sparrow.dff", 469 )
	if txd and dff then
		engineImportTXD ( txd, 469 )
		engineReplaceModel ( dff, 469 )
		engineImportTXD ( txd, 1305 )
		engineReplaceModel ( dff, 1305 )
	else
		setTimer(function()
			reloadafterdownload()
		end,1000,1)
	end
end


addEventHandler('onClientResourceStart', resourceRoot, function()	-- load the custom UFO texture on the sparrow
	reloadafterdownload()
	mothership = createObject(1305,-399.22,-2386.51,144)
	setObjectScale(mothership,10)
	engineSetModelLODDistance(1305,3000)
	setElementCollisionsEnabled(mothership,false)
	setElementDoubleSided (mothership, true)

end)


-- addEventHandler("onClientVehicleCollision", root,
--     function(collider, damageImpulseMag, bodyPart, x, y, z, nx, ny, nz)
--          if ( source == getPedOccupiedVehicle(localPlayer) ) then
--              -- force does not take into account the collision damage multiplier (this is what makes heavy vehicles take less damage than banshees for instance) so take that into account to get the damage dealt
--              local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
--              -- Create a marker (Scaled down to 1% of the actual damage otherwise we will get huge markers)
--              local m = createMarker(x, y, z, "corona", damageImpulseMag* fDamageMultiplier * 0.01, 0, 9, 231)
--              -- Destroy the marker in 2 seconds
--              setTimer(destroyElement, 2000, 1, m)
--          end
--     end
-- )
