

-- Generates random car from the lower tiers when hitting the KEEP colsphere
--local r = {530,572,574,531,432,486,408,406,601,573,444,578,524,509,483,514,481,403,515,431,508,532,499,455,510,609,588,498,414,423,443,418,482,478,416,526,456,459,401,410,419,401,410,552,437,}

-- Random from all vehicles
local r = {530,572,574,531,432,486,408,406,601,573,444,578,524,509,483,514,481,403,515,431,508,532,499,455,510,609,588,498,414,423,443,418,482,478,416,526,456,459,401,410,419,401,410,552,437,419,438,525,485,518,536,534,500,471,457,475,504,575,542,576,567,412,535,599,439,436,492,413,440,582,467,474,466,491,540,529,546,549,566,545,547,550,527,600,543,405,445,422,517,551,580,516,507,585,583,554,568,424,428,427,470,490,407,495,544,528,421,409,420,555,433,462,521,522,581,463,461,448,586,468,523,565,558,429,562,560,480,559,434,561,597,402,589,603,602,596,426,587,477,533,496,598,494,541,506,415,451,411}
local choose_random = createColCuboid ( -554.55999755859, -3404.31, 500, 50, 5, 300 )
function shapeHit(elem)
	if getElementType(elem) == 'vehicle' then
		setElementModel(elem, r[math.random(1, #r)])
    end
end
addEventHandler("onColShapeHit", choose_random , shapeHit)


local start_air_col = createColCuboid ( -500, -2897.7299804688, 261, 100, 10, 300 )
function fixCar(hitElement)
	local elementType = getElementType(hitElement)
	if elementType == 'vehicle' then
		fixVehicle(hitElement)
	end
end
addEventHandler("onColShapeHit", start_air_col , fixCar)


function raceState(newstate,oldstate)
	setElementData(root, "racestate", newstate, true)
    if (newstate == "PreGridCountdown") then
        outputChatBox ( "- Hit the marker with a score of 10 to finish.", root, 177, 255, 4, true )
        outputChatBox ( "- The judges will grant you a permanent +0.1 bonus for hitting the marker.", root, 177, 255, 4, true )
        outputChatBox ( "- A higher score will also give a faster vehicle on the next attempt.", root, 177, 255, 4, true )
        outputChatBox ( "- Each time you reset before the end of the ramp you get a permanent -0.1 penalty.", root, 177, 255, 4, true )
    end

	if (newstate == "GridCountdown") then
		outputChatBox ( "ARE YOU READY TO ROLL?", root, 177, 255, 4, true )
		for playerKey, playerValue in ipairs(getAlivePlayers()) do
			local veh = getPedOccupiedVehicle(playerValue)
			setElementModel(veh, 530)
	    end
    end

    if (newstate == "Running" and oldstate == "GridCountdown") then
    	outputChatBox ("LET THE JUDGEMENT BEGIN!", root, 177, 255, 4, true )
    end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )


-- Use below script to generate a tier list based on vehicle characterisic (like maxSpeed)


-- local models = {568,424,504,457,508,483,500,444,471,495,448,461,462,463,468,481,509,510,521,522,581,586,401,410,419,401,410,419,436,439,474,491,496,517,518,526,527,533,545,549,587,589,600,602,405,409,421,426,445,466,467,492,507,516,529,540,546,547,550,551,566,580,585,604,408,420,431,437,438,485,525,552,574,407,416,427,428,432,433,470,490,523,528,544,596,597,598,599,601,499,609,498,524,532,578,486,406,573,455,588,403,423,414,443,515,514,531,456,459,422,482,605,530,418,572,582,413,440,543,583,478,554,536,575,534,567,535,576,412,402,542,603,475,429,541,415,480,562,565,434,494,411,559,561,560,506,451,558,555,477}
-- local vehicleNames = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perennial", "Sentinel", "Dumper", "Fire Truck", "Trashmaster", "Stretch", "Manana",
--     "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat",
--     "Mr. Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife",
--     "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo",
--     "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
--     "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot",
--     "Quadbike", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis",
--     "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking",
--     "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer 2", "Hotring Racer 3", "Bloodring Banger",
--     "Rancher Lure", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain", "Nebula",
--     "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune", "Cadrona", "FBI Truck",
--     "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Brown Streak", "Vortex", "Vincent",
--     "Bullet", "Clover", "Sadler", "Fire Truck Ladder", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility Van",
--     "Nevada", "Yosemite", "Windsor", "Monster 2", "Monster 3", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash",
--     "Tahoma", "Savanna", "Bandito", "Freight Train Flatbed", "Streak Train Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado",
--     "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer (Tanker Commando)", "Emperor", "Wayfarer", "Euros", "Hotdog",
--     "Club", "Box Freight", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police LS", "Police SF", "Police LV", "Police Ranger",
--     "Picador", "S.W.A.T.", "Alpha", "Phoenix", "Glendale Damaged", "Sadler Damaged", "Baggage Trailer (covered)",
--     "Baggage Trailer (Uncovered)", "Trailer (Stairs)", "Boxville Mission", "Farm Trailer", "Street Clean Trailer"}

-- setTimer ( function()
-- 	local s = {}
-- 	print(#models)
-- 	for i, model in ipairs(models) do
-- 		h = getModelHandling(model)
-- 		s[i] = {model, vehicleNames[model-399], h['maxVelocity']}
-- 	end
-- 	local function sort_func(a,b)
-- 		local model1, name1, speed1 = unpack(a)
-- 		local model2, name2, speed2 = unpack(b)
-- 		if (speed1 < speed2) then
-- 			return true
-- 		else
-- 			return false
-- 		end
-- 	end
-- 	table.sort(s, sort_func)
-- 	for i, p in ipairs(s) do
-- 		local model, name, speed = unpack(p)
-- 		outputConsole(model .. ' "' .. name .. '", speed = ' .. speed)
-- 	end
-- end, 1000, 1 )


-- THE LIST
-- 530 "Forklift", speed = 60
-- 572 "Mower", speed = 60
-- 574 "Sweeper", speed = 60
-- 531 "Tractor", speed = 70
-- 432 "Rhino", speed = 80
-- 486 "Dozer", speed = 100
-- 408 "Trashmaster", speed = 110
-- 406 "Dumper", speed = 110
-- 601 "S.W.A.T.", speed = 110
-- 573 "Dune", speed = 110
-- 444 "Monster", speed = 110
-- 578 "DFT-30", speed = 110
-- 524 "Cement Truck", speed = 110
-- 509 "Bike", speed = 120
-- 483 "Camper", speed = 120
-- 514 "Tanker", speed = 120
-- 481 "BMX", speed = 120
-- 403 "Linerunner", speed = 120
-- 515 "Roadtrain", speed = 120
-- 431 "Bus", speed = 130
-- 508 "Journey", speed = 140
-- 532 "Combine Harvester", speed = 140
-- 499 "Benson", speed = 140
-- 455 "Flatbed", speed = 140
-- 510 "Mountain Bike", speed = 140
-- 609 "Boxville Mission", speed = 140
-- 588 "Hotdog", speed = 140
-- 498 "Boxville", speed = 140
-- 414 "Mule", speed = 140
-- 423 "Mr. Whoopee", speed = 145
-- 443 "Packer", speed = 150
-- 418 "Moonbeam", speed = 150
-- 482 "Burrito", speed = 150
-- 478 "Walton", speed = 150
-- 416 "Ambulance", speed = 155
-- 526 "Fortune", speed = 160
-- 456 "Yankee", speed = 160
-- 459 "Berkley's RC Van", speed = 160
-- 401 "Bravura", speed = 160
-- 410 "Manana", speed = 160
-- 419 "Esperanto", speed = 160
-- 401 "Bravura", speed = 160
-- 410 "Manana", speed = 160
-- 552 "Utility Van", speed = 160
-- 437 "Coach", speed = 160
-- 419 "Esperanto", speed = 160
-- 438 "Cabbie", speed = 160
-- 525 "Towtruck", speed = 160
-- 485 "Baggage", speed = 160
-- 518 "Buccaneer", speed = 160
-- 536 "Blade", speed = 160
-- 534 "Remington", speed = 160
-- 500 "Mesa", speed = 160
-- 471 "Quadbike", speed = 160
-- 457 "Caddy", speed = 160
-- 475 "Sabre", speed = 160
-- 504 "Bloodring Banger", speed = 160
-- 575 "Broadway", speed = 160
-- 542 "Clover", speed = 160
-- 576 "Tornado", speed = 160
-- 567 "Savanna", speed = 160
-- 412 "Voodoo", speed = 160
-- 535 "Slamvan", speed = 160
-- 599 "Police Ranger", speed = 160
-- 439 "Stallion", speed = 160
-- 436 "Previon", speed = 160
-- 492 "Greenwood", speed = 160
-- 413 "Pony", speed = 160
-- 440 "Rumpo", speed = 160
-- 582 "Newsvan", speed = 160
-- 467 "Oceanic", speed = 160
-- 474 "Hermes", speed = 160
-- 466 "Glendale", speed = 160
-- 491 "Virgo", speed = 160
-- 540 "Vincent", speed = 160
-- 529 "Willard", speed = 160
-- 546 "Intruder", speed = 160
-- 549 "Tampa", speed = 160
-- 566 "Tahoma", speed = 160
-- 545 "Hustler", speed = 160
-- 547 "Primo", speed = 160
-- 550 "Sunrise", speed = 160
-- 527 "Cadrona", speed = 160
-- 600 "Picador", speed = 165
-- 543 "Sadler", speed = 165
-- 405 "Sentinel", speed = 165
-- 445 "Admiral", speed = 165
-- 422 "Bobcat", speed = 165
-- 517 "Majestic", speed = 165
-- 551 "Merit", speed = 165
-- 580 "Stafford", speed = 165
-- 516 "Nebula", speed = 165
-- 507 "Elegant", speed = 165
-- 585 "Emperor", speed = 165
-- 583 "Tug", speed = 170
-- 554 "Yosemite", speed = 170
-- 568 "Bandito", speed = 170
-- 424 "BF Injection", speed = 170
-- 428 "Securicar", speed = 170
-- 427 "Enforcer", speed = 170
-- 470 "Patriot", speed = 170
-- 490 "FBI Rancher", speed = 170
-- 407 "Fire Truck", speed = 170
-- 495 "Sandking", speed = 170
-- 544 "Fire Truck Ladder", speed = 170
-- 528 "FBI Truck", speed = 170
-- 421 "Washington", speed = 180
-- 409 "Stretch", speed = 180
-- 420 "Taxi", speed = 180
-- 555 "Windsor", speed = 180
-- 433 "Barracks", speed = 180
-- 462 "Faggio", speed = 190
-- 521 "FCR-900", speed = 190
-- 522 "NRG-500", speed = 190
-- 581 "BF-400", speed = 190
-- 463 "Freeway", speed = 190
-- 461 "PCJ-600", speed = 190
-- 448 "Pizzaboy", speed = 190
-- 586 "Wayfarer", speed = 190
-- 468 "Sanchez", speed = 190
-- 523 "HPV1000", speed = 190
-- 565 "Flash", speed = 200
-- 558 "Uranus", speed = 200
-- 429 "Banshee", speed = 200
-- 562 "Elegy", speed = 200
-- 560 "Sultan", speed = 200
-- 480 "Comet", speed = 200
-- 559 "Jester", speed = 200
-- 434 "Hotknife", speed = 200
-- 561 "Stratum", speed = 200
-- 597 "Police SF", speed = 200
-- 402 "Buffalo", speed = 200
-- 589 "Club", speed = 200
-- 603 "Phoenix", speed = 200
-- 602 "Alpha", speed = 200
-- 596 "Police LS", speed = 200
-- 426 "Premier", speed = 200
-- 587 "Euros", speed = 200
-- 477 "ZR-350", speed = 200
-- 533 "Feltzer", speed = 200
-- 496 "Blista Compact", speed = 200
-- 598 "Police LV", speed = 200
-- 494 "Hotring Racer", speed = 220
-- 541 "Bullet", speed = 230
-- 506 "Super GT", speed = 230
-- 415 "Cheetah", speed = 230
-- 451 "Turismo", speed = 240
-- 411 "Infernus", speed = 240
