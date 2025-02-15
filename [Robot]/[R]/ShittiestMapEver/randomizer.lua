vehicles = {441,594,564,571,532,408,524,578,486,406,403,443,515,514,602,496,401,518,527,589,419,533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,467,426,547,405,409,550,566,540,421,529,581,509,481,462,521,463,510,522,461,448,468,586,485,552,431,438,437,574,420,525,416,433,427,490,528,407,544,523,470,598,596,597,599,601,428,499,498,573,455,588,423,414,531,456,459,422,482,530,418,572,582,413,440,543,583,478,554,536,575,534,567,535,576,412,402,542,603,475,568,424,504,457,483,508,500,444,471,495,429,541,415,480,562,565,434,503,502,494,411,559,561,560,506,451,558,555,477,579,400,404,489,479,442,458}
checks = {5,9,14,20,26,30,34}

function randomCar(checkpoint)
	outputConsole(checkpoint)
	if (checkpoint == 27) then
		return
	end
	if isPedInVehicle(source) then
		for i,v in ipairs(checks) do
			--if checkid == v then
				math.randomseed(getTickCount())
				local veh = getPedOccupiedVehicle(source)
				setElementModel(veh,vehicles[math.random(1,#vehicles)])
				break
			--end
		end
	end
end

addEvent("onPlayerReachCheckpoint",true)
addEventHandler("onPlayerReachCheckpoint",getRootElement(),randomCar)
