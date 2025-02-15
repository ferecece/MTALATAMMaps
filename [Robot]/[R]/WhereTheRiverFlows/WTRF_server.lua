function start(newstate,oldstate) --function to update the race states
	if (newstate == "LoadingMap") then
		removeWorldModel(1283, 5000,0,0,0)
		removeWorldModel(1294, 5000,0,0,0)
		removeWorldModel(1226, 5000,0,0,0)
		for i=1,3 do
			local obj1 = getElementByID("turbo"..i)
			local x,y,z = getElementPosition(obj1)
			local col = createColSphere(x,y,z,4)
			addEventHandler ( "onColShapeHit", col, boost )
		end
		
		for index,theElement in ipairs (getElementsByType("object")) do
				if getElementModel(theElement) == 1339 then
					setElementAlpha(theElement,0)
				end
		end
		
		local special1 = getElementByID("specialboost1")
		local x,y,z = getElementPosition(special1)
		local col = createColSphere(x,y,z,8)
		addEventHandler ( "onColShapeHit", col, specialboost )
		
		local special2 = getElementByID("specialboost2")
		local x,y,z = getElementPosition(special2)
		local col = createColSphere(x,y,z,8)
		addEventHandler ( "onColShapeHit", col, specialboost2 )
		
		local special3 = getElementByID("specialboost3")
		local x,y,z = getElementPosition(special3)
		local col = createColSphere(x,y,z,8)
		addEventHandler ( "onColShapeHit", col, specialboost3 )
	end
	
	if (newstate == "GridCountdown") then
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function stop()
	restoreAllWorldModels()
end
addEventHandler("onResourceStop",getResourceRootElement(),stop)


function boost(hitElement)
	if getElementType(hitElement) == "vehicle" then
		local x,y,z = getElementVelocity(hitElement)
		setElementVelocity(hitElement,x*1.5,y*1.5,z*1.5)
	end
end

function specialboost(hitElement)
	if getElementType(hitElement) == "vehicle" then
		local x,y,z = 0.077956557273865,0.83935791254044,0.31947568058968
		setElementVelocity(hitElement,x*4,y*4,z*4)
	end
end

function specialboost2(hitElement)
	if getElementType(hitElement) == "vehicle" then
		local x,y,z = 0.32454413175583,1.3591977357864,0.1528762280941
		setElementVelocity(hitElement,x*2.5,y*2.5,z*2.55)
	end
end

function specialboost3(hitElement)
	if getElementType(hitElement) == "vehicle" then
		local x,y,z = -0.30022314190865,-0.63236540555954,0.22409756481647
		setElementVelocity(hitElement,x*10,y*10,z*11)
	end
end

players = {}
function reverse(source)
	local veh = getPedOccupiedVehicle(source)
	if veh and not players[source] then
		outputChatBox("You are now racing the track in reverse Kappa",source,255,255,0)
		players[source]=true
		local x,y,z = getElementRotation(veh)
		setElementRotation(veh,x,y,z+180)
	end
end
addCommandHandler("reverse",reverse)

function expert(source)
	local veh = getPedOccupiedVehicle(source)
	if veh then
		local x,y,z = getElementPosition(veh)
		local skull = createObject(1254,x,y,z,0,0,1,true)--1254
		attachElements(skull,veh,0,0,1)
	end
end
addCommandHandler("expert",expert)

function finish(rank,time)
	if time < 190000 then
		outputChatBox("*Cheatcode unlocked: You beat the race in under 3:10. Use /expert next time to try the race in expert mode!",source,0,255,0)
	end
end
addEvent("onPlayerFinish",true)
addEventHandler("onPlayerFinish",getRootElement(),finish)
