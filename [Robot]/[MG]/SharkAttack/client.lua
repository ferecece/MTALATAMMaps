started = false -- if you switch this to false the bots will only start if you write /start
function start()
	started = true
	for k,v in ipairs(clientVehicles) do
		local vehicles = getElementsByType("vehicle")
		cVeh = v
		for k,v in ipairs(vehicles) do
			setElementCollidableWith(v,cVeh,true)
		end
	end
end
setTimer(start,30000,2)

function resumeScript() ------ this is needed if a player is a latejoiner, so he needs to request the vehicles from the server.
	if clientVehicles then
	else
		triggerServerEvent("requestVehicles",root,getLocalPlayer())
		setTimer(resumeScript,5000,1)
	end
end
setTimer(resumeScript,1000,1)

local screenWidth, screenHeight = guiGetScreenSize()
	function helpDesk() -- helpdesk is a helpdesk, you can use it to debug or anything... im used it while scripted this, its very helpful
		if clientSyncers then
			for k,v in pairs(clientSyncers) do
				--if clientSyncers[k] == getPlayerName(getLocalPlayer()) then
					--if getPlayerName(cTargetsTable[k]) ~= false then
					--dxDrawText("Syncer: "..k.." - "..tostring(getPlayerName(cTargetsTable[k])),47,screenHeight-800+k*20,screenWidth,screenHeight,tocolor(0,200,255,255),1.6,"princedown")
					--dxDrawText("O HEY THANKS:",47,screenHeight-800+k*20,screenWidth,screenHeight,tocolor(0,200,255,255),1.6,"princedown")
					--end
				--end
			end
		end
		if clientVehicles then
			for k,v in ipairs(clientVehicles) do
				local x,y,z = getElementPosition(v)
				local mx,my,mz = getElementPosition(getLocalPlayer())
				local sx,sy = getScreenFromWorldPosition(x,y,z+1)
				if mx then
					local distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz)
					if distance then
						if distance < 80 and sx then
						dxDrawText("It_Is_Rain",sx,sy,sx,sy,tocolor(255,255,255),0.7+distance*0.01,"default-bold")
						end
					end
				end
			end
		end
	end
	addEventHandler("onClientPreRender",root,helpDesk)
-------------------------------HELP-------------------------------------------------
function cTargetRefresh(sTargetsTable) -- receiving information from the server about the vehicles targets, so your client can continue the driving of any vehicle anytime
	if clientVehicles then
		for k,v in ipairs(clientVehicles) do
			targetsTable[k] = sTargetsTable[k]
		end
	end
end
addEvent("targetRefresh",true)
addEventHandler("targetRefresh",root,cTargetRefresh)

reverseTable = {}
checkReverse = {}
targetsTable = {}
function start(botVehicles,botPeds,crazyness)
	clientVehicles = botVehicles -- creating tables on clientside from the serverside vehicles, its usually does not change so its enough to sync it once
	clientPeds = botPeds
	setTimer(vehicleControl,100,0)
	for k,v in ipairs(botVehicles) do
		table.insert(reverseTable,0)
		table.insert(checkReverse,0)
		addVehicleUpgrade(v,1010)
		setElementStreamable(v,false)
		setElementAlpha(v,0)
		local model = createObject(1608,0,0,0)
		engineSetModelLODDistance(1608,300)
		setElementAlpha(clientPeds[k],0)
		attachElements(model,v,0,0,-1,0,0,0)
		setElementStreamable(clientPeds[k],false)
		currentVeh = v
	end
end
addEvent("onVehiclesCreated",true)
addEventHandler("onVehiclesCreated",root,start)


function globalizeSyncers(syncers)
	clientSyncers = syncers
end
addEvent("sendSyncers",true)
addEventHandler("sendSyncers",root,globalizeSyncers)
--------------------------------- progress / refresh targets
function cTargetSync(sTargetsTable)
	cTargetsTable = sTargetsTable
end
addEvent("targetSync",true)
addEventHandler("targetSync",root,cTargetSync)

----------------------------------- vehicles controlling
-- yes, this is the magical part, this is how the vehicles are controlled around the track.
function vehicleControl()
	if clientSyncers then
		for k,v in ipairs(clientVehicles) do
		if started then
			if getElementHealth(v) > 250 then -- if its not burning then
			setVehicleDamageProof(v,true)
				local thisVeh = v
				setElementCollisionsEnabled(thisVeh,true)
				local x,y,z = getElementPosition(v)
				local rx,ry,rz = getElementRotation(v)
				if clientSyncers[k] == getPlayerName(getLocalPlayer()) then
						if cTargetsTable[k] ~= getLocalPlayer() then
							cTargetsTable[k] = getLocalPlayer()
						elseif not cTargetsTable[k] then
							cTargetsTable[k] = getLocalPlayer()
						else
							local x,y,z = getElementPosition(v)
							local distanceLeftX = x+2.4*math.cos(math.rad(rz+180))
							local distanceLeftY = y+2.4*math.sin(math.rad(rz+180))
							local distanceRightX = x+2.4*math.cos(math.rad(rz+0))
							local distanceRightY = y+2.4*math.sin(math.rad(rz+0))
							local tx,ty,tz = getElementPosition(cTargetsTable[k])
							local distance = getDistanceBetweenPoints3D(x,y,z,tx,ty,tz)
							local distanceLeft = getDistanceBetweenPoints3D(distanceLeftX,distanceLeftY,z,tx,ty,tz)
							local distanceRight = getDistanceBetweenPoints3D(distanceRightX,distanceLeftY,z,tx,ty,tz)
						end
						triggerServerEvent("clientBotTarget",root,cTargetsTable[k],k) -- telling the server what is the target of the current but, so it can tell the other clients, so the other clients will know this..... and they will be ready to drive this bot when they have to
						local target = cTargetsTable[k]
						if target then
							local speedx,speedy,speedz = getElementVelocity(v)
							local velocity = (speedx^2 + speedy^2 + speedz^2)^(0.5)*100
							local tx,ty,tz = getElementPosition(target)
							local left1 = x+1.4*math.cos(math.rad(rz+180))
							local left2 = y+1.4*math.sin(math.rad(rz+180))
							local right1 = x+1.4*math.cos(math.rad(rz+0))
							local right2 = y+1.4*math.sin(math.rad(rz+0))
							local middle1 = x+1.4*math.cos(math.rad(rz+90))
							local middle2 = y+1.4*math.sin(math.rad(rz+90))
							local rear1 = x+1.4*math.cos(math.rad(rz+270))
							local rear2 = y+1.4*math.sin(math.rad(rz+270))
							-- distances
							local dleft = getDistanceBetweenPoints2D(left1,left2,tx,ty)
							local dright = getDistanceBetweenPoints2D(right1,right2,tx,ty)
							local dmid = getDistanceBetweenPoints2D(middle1,middle2,tx,ty)
							local drear = getDistanceBetweenPoints2D(rear1,rear2,tx,ty)
							local difference = dleft - dright
							if k == 1 then -- its for the debug, in this way you can check these values of the first vehicle in the table
								gMid = dmid
								gRight = dright
								gLeft = dleft
								gRear = drear
							end
							----- steering
							if reverseTable[k] == 1 or drear - dmid <= 0.3 then
								if difference < 0.28 and difference > -0.28 and dmid < dleft then -- check if the vehicle is not reverse to its target
									setPedControlState(clientPeds[k],"vehicle_right",false)
									setPedControlState(clientPeds[k],"vehicle_left",false)
								elseif dleft < dright then
									setPedControlState(clientPeds[k],"vehicle_right",true)
									setPedControlState(clientPeds[k],"vehicle_left",false)
								elseif dleft > dright then
									setPedControlState(clientPeds[k],"vehicle_right",false)
									setPedControlState(clientPeds[k],"vehicle_left",true)
								else
								end
							else	
								if difference < 0.28 and difference > -0.28 and dmid < dleft then -- check if the vehicle is not reverse to its target
									setPedControlState(clientPeds[k],"vehicle_right",false)
									setPedControlState(clientPeds[k],"vehicle_left",false)
								elseif dleft > dright then
									setPedControlState(clientPeds[k],"vehicle_right",true)
									setPedControlState(clientPeds[k],"vehicle_left",false)
								elseif dleft < dright then
									setPedControlState(clientPeds[k],"vehicle_right",false)
									setPedControlState(clientPeds[k],"vehicle_left",true)
								else
								end
							end
							----------------- accelerate
							speedLimit = 1000
							--local speedLimit = 20 -- this was used in the first stages, a constant speed limit
							local accel = getPedControlState(clientPeds[k],"accelerate")
							local brake = getPedControlState(clientPeds[k],"brake_reverse")
							if reverseTable[k] == 0 then
								if drear - dmid > 0.3 then
									if velocity < speedLimit then
											if accel then
											else
												setPedControlState(clientPeds[k],"accelerate",true)
											end
											if brake then
												setPedControlState(clientPeds[k],"brake_reverse",false)
											end
									elseif velocity > speedLimit+6 then
										setPedControlState(clientPeds[k],"accelerate",false)
										setPedControlState(clientPeds[k],"brake_reverse",true)
									else
									setPedControlState(clientPeds[k],"accelerate",false)
										if brake then
											setPedControlState(clientPeds[k],"brake_reverse",false)
										end
									end
									if reverseTable[k] == 1 then
										setPedControlState(clientPeds[k],"accelerate",false)
									end
								else 
									if accel then
										setPedControlState(clientPeds[k],"accelerate",false)
									end
									if brake then
									else
										setPedControlState(clientPeds[k],"brake_reverse",true)
									end
								end
							else
							end
								if velocity < 1.4 and checkReverse[k] == 0 then
									setTimer(vcheck2,3000,1,k)
									checkReverse[k] = 1
								end
							---------------- nitro
							local nitro = getPedControlState(clientPeds[k],"vehicle_fire")
							if velocity < speedLimit-7 and velocity > 7 or velocity < 3 then
								if nitro then
								else
								setPedControlState(clientPeds[k],"vehicle_fire",true)
								end
							elseif nitro then
								setPedControlState(clientPeds[k],"vehicle_fire",false)
								removeVehicleUpgrade(clientVehicles[k],1010)
								setTimer(function() addVehicleUpgrade(v,1010)
													end,2000,1)
							end
							-------------------- handbrake --- sadly its not working very well now, working on it.
							local handbrakeDist = (dleft - dright)^2
							local handbrake = getPedControlState(clientPeds[k],"handbrake")
							-- if the car is too far and too fast and heads the wrong direction
							if dmid > 50 and velocity > 40 and handbrakeDist > 4 then
								if handbrake then
								else
									setPedControlState(clientPeds[k],"handbrake",true)
								end
							else
							setPedControlState(clientPeds[k],"handbrake",false)
							end
							-- if the car is next to you anytime and faster than 20
							if handbrakeDist > 4.5 and velocity > speedLimit+4 then
								if handbrake then
								else
									setPedControlState(clientPeds[k],"handbrake",true)
								end
							else
								setPedControlState(clientPeds[k],"handbrake",false)
							end
							--------- prepare for trigger and trigger
							local currentPed = clientPeds[k]
							local data = {}
							data["px"],data["py"],data["pz"] = getElementPosition(clientVehicles[k])
							data["rx"],data["ry"],data["rz"] = getElementRotation(clientVehicles[k])
							data["vx"],data["vy"],data["vz"] = getElementVelocity(clientVehicles[k])
							local controls = {["accelerate"] = false,
											["brake_reverse"] = false,
											["vehicle_left"] = false,
											["vehicle_right"] = false,
											["vehicle_fire"] = false,
											["handbrake"] = false}
								for k,v in pairs(controls) do
									controls[k] = getPedControlState(currentPed,k)
								end
							triggerServerEvent("clientToServerBotSync",root,data,controls,k)
						end -- if dont have target
					elseif clientSyncers[k] == false then -- this part is important, making sure that if nobody controls a vehicle, its steering its straight, otherwise it may go the left or right when your client start to drive it
						setPedControlState(clientPeds[k],"vehicle_right",false)
						setPedControlState(clientPeds[k],"vehicle_left",false)
					end
				else
					setPedControlState(clientPeds[k],"accelerate",false)
					setPedControlState(clientPeds[k],"brake_reverse",false)
					setPedControlState(clientPeds[k],"vehicle_fire",false)
					setVehicleDamageProof(v,true)
					setElementHealth(v,200)
				end
			end
		end
	end
end

--------------------- REVERSE
function vcheck2(k)
	local speedx,speedy,speedz = getElementVelocity(clientVehicles[k])
	local velocity = (speedx^2 + speedy^2 + speedz^2)^(0.5)*100
	if velocity < 1.4 then
		reverseTable[k] = 1
		setPedControlState(clientPeds[k],"brake_reverse",true)
		setPedControlState(clientPeds[k],"accelerate",false)
		setPedControlState(clientPeds[k],"vehicle_right",false)
		setPedControlState(clientPeds[k],"vehicle_left",false)
		setTimer(rbrse2End,1800,1,k)
	else 
	checkReverse[k] = 0
	end
end

function rbrse2End(k)
	reverseTable[k] = 0
	checkReverse[k] = 0
	setPedControlState(clientPeds[k],"brake_reverse",false)
end

------------------------ SYNC(client)
function syncTheBots(data,controls,k)
	if clientSyncers then
		if clientSyncers[k] ~= getPlayerName(getLocalPlayer()) then
			local currentPed = clientPeds[k]
			for k,v in pairs(controls) do
				setPedControlState(currentPed,k,v)
			end
			setElementPosition(clientVehicles[k],data["px"],data["py"],data["pz"])
			setElementRotation(clientVehicles[k],data["rx"],data["ry"],data["rz"])
			setElementVelocity(clientVehicles[k],data["vx"],data["vy"],data["vz"])
		else
		end
	end
end
addEvent("passDataFromServer",true)
addEventHandler("passDataFromServer",root,syncTheBots)
