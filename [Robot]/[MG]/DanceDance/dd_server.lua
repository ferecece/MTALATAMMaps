
function mapStarting(newState,oldState)
	-- if (newState == "PreGridCountdown") then
		-- for i,thePlayer in ipairs (getElementsByType("player")) do
			-- local veh = getPedOccupiedVehicle(thePlayer)
			-- if veh then
				
			-- end
		-- end
	-- end

	if (newState == "GridCountdown") then
		outputChatBox("Bounce to the beat by pressing the arrow keys at the correct time.",root,0,255,0)
		
		for i,veh in ipairs (getElementsByType("vehicle")) do
			local ped = getVehicleOccupant(veh)
			if getElementType(ped) ~= "player" then
				setElementAlpha(veh,0)
				setElementAlpha(ped,0)
			end
		end
		
	end

	if (newState == "Running" and oldState == "GridCountdown") then
		generateSequence()
	end
end
addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging",root,mapStarting)


 femaleSkins = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}
 
 maleSkins = {0,105,106,107,102,103,104,108,109,110,114,115,116}
 
function enterVehicle ( veh, seat, jacked ) --when a player enters a vehicle
    if getElementType(source) == "player" then
		addVehicleUpgrade(veh,1087)
		setVehiclePaintjob(veh,math.random(0,3))
		removeVehicleUpgrade(veh,1130)
		removeVehicleUpgrade(veh,1131)
		
		setElementModel(source,maleSkins[math.random(1,#maleSkins)])
		
		local x,y,z = getElementPosition(veh)
		for i=1,math.random(1,3) do
			local ped = createPed(femaleSkins[math.random(1,#femaleSkins)],x,y,z)
			warpPedIntoVehicle(ped,veh,i)
			setPedAnimation ( ped, "DANCING", "dnce_m_b")
		end
	end
	
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onPlayerVehicleEnter







--generating key pattern
--every key is saved into the sequence array, the first entry is the key (1,2,3,4) and the second entry is the time after the start it should enter

sequence = {}
function generateSequence()
	local addTime = 0
	for i=1,5 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 1500
	end
	
	addTime = addTime - 500
	for i=5,8,3 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		sequence[i+1] = {math.random(1,4),addTime+250} --time after the previous key entered the screen
		sequence[i+2] = {math.random(1,4),addTime+500} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	addTime = addTime - 250
	
	for i=8,18 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	addTime = addTime - 750
	
	for i=18,27,3 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		sequence[i+1] = {math.random(1,4),addTime+250} --time after the previous key entered the screen
		sequence[i+2] = {math.random(1,4),addTime+500} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	for i=27,37 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 800
	end
	
	for i=37,50 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 500
	end
	
	for i=51,60 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	for i=61,70 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 300
	end
	
	addTime = addTime + 500
	
	for i=70,76,3 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		sequence[i+1] = {math.random(1,4),addTime+250} --time after the previous key entered the screen
		sequence[i+2] = {math.random(1,4),addTime+500} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	for i=76,81 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 300
	end
	
	for i=81,90 do
		sequence[i] = {math.random(1,4),addTime} --time after the previous key entered the screen
		addTime = addTime + 1000
	end
	
	triggerClientEvent ("sendSequence", getResourceRootElement(getThisResource()), sequence)
end