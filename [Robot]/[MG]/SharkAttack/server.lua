GX = 3080
GY = -1702
GZ = 3
carID = 444
-------------- VEHICLES...... You can freely add or remove vehicles. Boats may work but planet or helicopters won't. Cars, bikes are ok.
botVehicles = {	createVehicle(473,GX,GY+0,GZ,0,0,-90),
				createVehicle(452,GX+800,GY+10,GZ,0,0,-90),
				createVehicle(453,GX+400,GY+400,GZ,0,0,-90),
				createVehicle(446,GX+400,GY-400,GZ,0,0,-90)
				}	
botPeds	= {} -- the drivers
syncers = {} -- the players who syncing the vehicles

sTargetsTable = {} -- all target checkpoints
checkpointProgress = {} -- vehicle target CP progress
---------------------------- tables

---------------------------- creating bots
for k,v in ipairs(botVehicles) do
	setVehicleColor(v,1,1,1)
	local c1,c2,c3 = getVehicleColor(v,true)
	createBlipAttachedTo(v,0,2,c1,c2,c3)
	table.insert(sTargetsTable,false)
	local px,py,pz = getElementPosition(v)
	table.insert(botPeds,createPed(0,px,py,pz+1,0,true))
	warpPedIntoVehicle(botPeds[k],v)
	setElementCollisionsEnabled(v,true)
end
-------------------------------- starttrigger

setTimer(function() 
triggerClientEvent("onVehiclesCreated",root,botVehicles,botPeds) 
end,2000,1)

--------------------------------- tell clients the actual syncers
function getSyncers()
	for k,v in ipairs(botVehicles) do
		local alivePlayers = getAlivePlayers()
		local randomValue = math.random(1,#alivePlayers)
		local randomPlayerName = getPlayerName(alivePlayers[randomValue])
		syncers[k] = randomPlayerName ---- the setElementSyncer is glitching so working it around
	end
	triggerClientEvent("sendSyncers",root,syncers)
	setTimer(getSyncers,10000,1)
end
setTimer(getSyncers,2500,1)


---------------------------------- SYNC!!!!!!!!!!!!!(server)
function passData(data,controls,k)
	triggerClientEvent("passDataFromServer",root,data,controls,k)
end
addEvent("clientToServerBotSync",true)
addEventHandler("clientToServerBotSync",root,passData)
------------------------------- server side thing


function syncTargets()
	triggerClientEvent("targetSync",root,sTargetsTable)
end
setTimer(syncTargets,300,0)

function serverRefreshTables(value1,k)
	sTargetsTable[k] = value1
end
addEvent("clientBotTarget",true)
addEventHandler("clientBotTarget",root,serverRefreshTables)

function giveVehicleTables(player)
	triggerClientEvent("onVehiclesCreated",root,botVehicles,botPeds)
end


addEvent("requestVehicles",true)
addEventHandler("requestVehicles",root,giveVehicleTables)
