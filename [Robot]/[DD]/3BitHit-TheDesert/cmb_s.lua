
IDlist = {}
IDlist[0] = 2666
IDlist[1] = 2667
IDlist[2] = 2668
IDlist[3] = 2695
IDlist[4] = 2696
IDlist[5] = 2697
IDlist[6] = 2719
IDlist[7] = 2720
IDlist[8] = 2721
IDlist[9] = 2722

function start(newstate,oldstate) --function to update the race states
	setElementData(root,"racestate",newstate,true)
	
	if (newstate == "LoadingMap") then
	end
	
	if (newstate == "GridCountdown") then 
		outputChatBox("Blow up other cars by dialing the number on the back. Hide yours to stay alive!",getRootElement(),0,255,0)
		playerIDs = {} --array of the players with as index their number (so you can get players with  ex. playerIDs[666])
		for index,thePlayer in ipairs (getAlivePlayers()) do
			local theVehicle = getPedOccupiedVehicle(thePlayer)
			if theVehicle then
				
				-- generate a random number and assign it as the player ID (if it is not taken)
				local number,num1,num2,num3,check
				repeat
					number = math.random (100,999)
					--outputChatBox("loop")
					if not playerIDs[number] then
						playerIDs[number] = thePlayer
						check = true
					end
				until check
				--split the number up into digits
				num3 = number%10
				num2 = ((number-num3)/10)%10
				num1 = (((number-num3)/10-num2)/10)
				--outputChatBox(number..": "..num1..","..num2..","..num3)

				-- attach the numbers to the back of the vehicle
				local x,y,z = getElementPosition(theVehicle)
				for i,num in pairs {num1,num2,num3} do
					local o = createObject(IDlist[num],x,y,z-50)
					setObjectScale(o,0.55)
					setElementCollisionsEnabled(o,false)
					attachElements(o,theVehicle,-1+i*0.5,-1.4,0.6,297.246,0,0)
				end
				
				--create dynamite and attach to vehicle
				for i=-1,1 do
					local o = createObject(1654,x,y,z-50)
					setObjectScale(o,2)
					attachElements(o,theVehicle,i*0.5,-0.7,0.8,-90,0,180)
				end
			end
		end
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )


function numberHandler(number)
	local x,y,z = getElementPosition(source)
	if z > 10000 then
		return --only playing players can try to blow up cars. Spectating players have a z of ~35000
	end

	if getElementData(source, "race.finished") then
		return --extra alive player check
	end

	local target = playerIDs[number]
	if target then
		local veh = getPedOccupiedVehicle(target)
		if veh then
			local x,y,z = getElementPosition(target)
			local x2,y2,z2 = getElementPosition(source)
			local distance = math.floor(getDistanceBetweenPoints3D(x,y,z,x2,y2,z2))
			if target==source then
				outputChatBox("You bombed your own car, idiot!",source,255,0,0,true)
			else
				outputChatBox("You've been blown up by #FFFFFF"..getPlayerName(source).." #FF0000from a distance of #FFFFFF"..distance.." #FF0000meters!",target,255,0,0,true)
				outputChatBox("You've blown up #FFFFFF"..getPlayerName(target).." #00FF00from a distance of #FFFFFF"..distance.." #00FF00meters!",source,0,255,0,true)
			end
			blowVehicle(veh)
		end
	else
		local veh = getPedOccupiedVehicle(source)
		if veh then
			outputChatBox("Wrong number, you died!",source,255,0,0)
			blowVehicle(veh)
		end
	end
end
addEvent("processNumber", true )
addEventHandler("processNumber", root, numberHandler)



-- give boosts for players that drive through the markers
boost = {}
boost["marker1"]={-0.6,0.6,1.2} --velx, vely,velz
boost["marker2"]={1.4,0,1.2}
boost["marker3"]={-1,1,2}

function jumpBoost(hitElement)
	if (getElementType(hitElement)=="vehicle") then
		local ID = getElementID(source)
		if ID then
			local a = boost[ID]
			if a then
				local x,y,z = unpack(a)
				setElementVelocity(hitElement,x,y,z)
				fixVehicle(hitElement)
			end
		end
	end
end
addEventHandler("onMarkerHit",root,jumpBoost)


