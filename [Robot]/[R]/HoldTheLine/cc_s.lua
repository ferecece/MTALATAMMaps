


function start(newstate,oldstate) --function to update the race states
	if (newstate == "LoadingMap") then 
		colID = {}
		for i=1,9 do
			local marker = getElementByID(tostring(i))
			local x,y,z = getElementPosition(marker)
			local col = createColCircle(x,y,12)
			colID[col] = i
			addEventHandler("onColShapeHit",col,checkpointcounter)
		end
		
	end
	
	if (newstate == "GridCountdown") then 
		loadPath()
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

spawnLocations={}
function checkpointcounter(hitElement) --initiate teleport to next checkpoint and save spawn locations for respawning players on death
	if (getElementType(hitElement) == "vehicle") then
		local ped = getVehicleOccupant(hitElement)
		if ped then
			checkpoint = colID[source]
			if checkpoint then
				if not spawnLocations[ped] then
					spawnLocations[ped] = 0
				end
				if launch[checkpoint+1] and (spawnLocations[ped] == (checkpoint - 1)) then
					spawnLocations[ped]=checkpoint
					teleport(checkpoint,ped)
				end
			end
		end
	end
end

launch={}
--launch[i]={x,y,z,velx,vely,velz,rotz}--indices corespond to the spawn location/velocity for checkpoint i
--launch[2]={-1774,-581,16,0.52091771364212,0.011345477774739,0.00018286333943252,271.23046875}
launch[2]={1677.0234375,-843.2978515625,58.646423339844,0.085700280964375,0.80658048391342,-0.038995113223791,353.93005371094}
launch[3]={1030.9296875,-184.0927734375,27.881313323975,-0.80194884538651,0.054398350417614,-0.19270864129066,86.160278320313}
launch[4]={-1634,-463,13,0.31536960601807,0.83232146501541,-0.00775534985587,339.27429199219}
launch[5]={-980,-1907,80,-0.8510445356369,-0.037009015679359,-0.033522751182318,92.554321289063}
launch[6]={-1911,-981,41,0.0056126601994038,-0.76125466823578,-0.061123661696911,180.46142578125}
launch[7]={-514,68,35,-0.30911833047867,0.31895124912262,-0.08707083761692,44.36279296875}
launch[8]={-1557,1840,27,-0.79288506507874,-0.093330532312393,-0.048733990639448,96.61376953125}
launch[9]={-1704,2356,50,-0.41436159610748,-0.42543637752533,-0.11375664919615,136.49963378906}
launch[10]={-665.2,2569.4,155,math.random(-1,1),math.random(-1,1),1,0}

function teleport(checkpoint,thePlayer)
	local id = checkpoint + 1
	local veh = getPedOccupiedVehicle(thePlayer)
	if launch[id] and veh then
		local x,y,z,velx,vely,velz,rotz = unpack(launch[id])
		
		
		-- -- teleport with nothing fancy
		-- setElementPosition(veh,x,y,z)
		-- setElementRotation(veh,0,0,rotz)
		-- setElementVelocity(veh,velx,vely,velz)
			
		-- -- teleport by fading camera
		-- fadeCamera(thePlayer,false)
		-- setTimer(function()
			-- setElementPosition(veh,x,y,z)
			-- setElementRotation(veh,0,0,rotz)
			-- setElementVelocity(veh,velx,vely,velz)
			-- fadeCamera(thePlayer,true)
		-- end,1000,1)
		-- setTimer(fadeCamera,1000,1,thePlayer,true,1000)
		
		-- -- teleport by moving
		local a,b,c = getElementPosition(veh)
		local tel1 = createObject(1337,a,b,c,0,0,0,true)
		setElementAlpha(tel1,0)
		
		local q,r,s = getElementRotation(veh)
		attachElements(veh,tel1,0,0,0,0,0,s)
		moveObject(tel1,1000,x,y,z,0,0,rotz-s,"OutQuad")
		setTimer(function()
			detachElements(veh,tel1)
			destroyElement(tel1)
			setElementPosition(veh,x,y,z)
			setElementRotation(veh,0,0,rotz)
			setElementVelocity(veh,velx,vely,velz)
		end,900,1)
	end
end


-- if you hit checkpoint x and die you should spawn at the location for checkpoint x+1
function player_Spawn ( posX, posY, posZ, spawnRotation, theTeam, theSkin, theInterior, theDimension )
	if spawnLocations[source] then
		setTimer(teleport,100,1,spawnLocations[source],source)

		-- doing teleport twice to fix velocity issues
		setTimer(teleport,1500,1,spawnLocations[source],source)
	end
end
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )

function loadPath()
	local path = xmlLoadFile( "paths/path3.xml" )
	if path then
		local data = {}
		-- Construct a table
		local index = 0
		local node = xmlFindChild( path, "n", index )
		while (node) do
						
			local attributes = xmlNodeGetAttributes( node )
			local row = {}
			for k, v in pairs( attributes ) do
				row[k] = v
			end
			table.insert( data, row )
			
			local x,y,z = row["x1"],row["x2"],row["x3"]
			
			if x and y and z then
				local obj = createObject(1337,x,y,z,0,0,0,true)
				setElementAlpha(obj,10)
			end
			
			index = index + 1
			node = xmlFindChild( path, "n", index )
		end
		xmlUnloadFile( path )
		triggerClientEvent ("loadPath", root, data )
		return true
	end
end