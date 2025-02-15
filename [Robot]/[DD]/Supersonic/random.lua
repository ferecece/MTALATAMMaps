-- This is the IDs list of all the vehicles players will get when they pass throught the marker or when they spawn.
local vehicles = {602,545,496,517,401,410,518,600,527,436,589,580,419,439,533,549,526,491,474,445,604,507,585,587,466,492,546,551,516,467,426,547,405,409,550,566,540,421,529,581,509,481,462,521,463,510,522,461,448,468,586,485,552,431,438,437,574,420,525,408,416,433,427,490,528,407,544,523,470,598,596,597,599,601,428,499,609,498,524,532,578,486,406,573,455,588,403,514,423,414,443,515,531,456,459,422,482,605,530,418,572,582,413,440,543,583,478,554,536,575,534,567,535,576,412,402,542,603,475,568,424,504,457,483,508,571,500,444,556,557,471,495,429,541,415,480,562,323,492,502,503,411,559,561,560,506,451,558,555,477,579,400,404,489,505,479,442,458}

-- This is the vehicle change marker that will be created on your map, just edit the coordinates.
local MARKER = createMarker(2475.8999023438, -4417.8999023438, 1.7000000476837, "corona" , 5, 109, 12, 242, 255)
local MARKER2 = createMarker(2475.5, -4415.6000976562, 25.200000762939, "corona" , 7, 109, 12, 242, 255)

function changeState(newstate,oldstate)
	
	if (newstate == "GridCountdown") then 
		alivePlayers = getAlivePlayers ()
		if ( alivePlayers ) then -- if we got the table
		    -- Loop through the table
		    for playerKey, playerObject in ipairs(alivePlayers) do
		    	givePlayerRandomVehicle(playerObject) --give each alive player a random vehicle
		    end
		end

	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), changeState)

function onMarkerHit_S ( hit )
	if getElementType(hit ) == "vehicle" then
		giveRandomVehicle(hit)
	end
end
addEventHandler("onMarkerHit",getRootElement(),onMarkerHit_S)

function giveRandomVehicle(vehicle)
	local newCarID = (vehicles[math.random(#vehicles)]) -- gets a random vehicle ID from the list		
	local x, y, z = getElementPosition(vehicle)      -- gets location of player
	setElementModel(vehicle,newCarID) 		        -- sets the player car model to the random generated ID
	setElementPosition(vehicle, x, y, z + 1.5)       -- Set the z-height of the vehicle + 0.5 to prevent from being stuck in the ground if you get a larger vehicle
end

function givePlayerRandomVehicle(player)
	local theVehicle = getPedOccupiedVehicle(player)    -- get the vehicle object the player is in.
	local newCarID = (vehicles[math.random(#vehicles)]) -- gets a random vehicle ID from the list		
	local x, y, z = getElementPosition(theVehicle)      -- gets location of player
	setElementModel(theVehicle,newCarID) 		        -- sets the player car model to the random generated ID
	setElementPosition(theVehicle, x, y, z + 1.5)       -- Set the z-height of the vehicle + 0.5 to prevent from being stuck in the ground if you get a larger vehicle
end
