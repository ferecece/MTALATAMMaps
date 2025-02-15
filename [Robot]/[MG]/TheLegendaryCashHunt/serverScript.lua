local randomLocation
local x
local y
local z
local theDollar
local dollarCreated = 0

local dollarLocation1 = {2174, -2222, 13.5}
local dollarLocation2 = {2472, -2696, 2.3}
local dollarLocation3 = {2720, -2197, 12.8}
local dollarLocation4 = {1929, -2694, 12.8}
local dollarLocation5 = {1789, -2304, -3.3}
local dollarLocation6 = {1245, -2497, 0.7}
local dollarLocation7 = {1084, -2032, 68.6}
local dollarLocation8 = {847, -1700, 12.8}
local dollarLocation9 = {674, -1867, 4.8}
local dollarLocation10 = {173, -1763, 6.1}
local dollarLocation11 = {229, -1410, 50.9}
local dollarLocation12 = {229, -1160, 74.6}
local dollarLocation13 = {723, -1496, 1.2}
local dollarLocation14 = {586, -1159, 52.5}
local dollarLocation15 = {819, -1096, 25.1}
local dollarLocation16 = {811, -853, 69.2}
local dollarLocation17 = {928, -1248, 15}
local dollarLocation18 = {990, -842, 90.6}
local dollarLocation19 = {1223, -1259, 13.6}
local dollarLocation20 = {1059, -1619, 19.7}
local dollarLocation21 = {1107, -1182, 17.8}
local dollarLocation22 = {2508, -1700, 12.8}
local dollarLocation23 = {2865, -2126, 5.3 }
local dollarLocation24 = {2873, -1588, 21.7 }
local dollarLocation25 = {2804, -1428, 39.3 }
local dollarLocation26 = {2783, -1241, 47.1 }
local dollarLocation27 = {2617, -1093, 68.9 }
local dollarLocation28 = {2496, -1024, 64.7 }
local dollarLocation29 = {2325, -1065, 51.6 }
local dollarLocation30 = {2143, -979, 60.7}
local dollarLocation31 = {1896, -1075, 23.2}
local dollarLocation32 = {1684, -960, 60.2}
local dollarLocation33 = {1404, -801, 79 }
local dollarLocation34 = {1242, -872, 45.9}
local dollarLocation35 = {2380, -1909, 12.8}
local dollarLocation36 = {2062, -1787, 12.8}
local dollarLocation37 = {1689, -1974, 8.1}
local dollarLocation38 = {1670, -1637, 21.8}
local dollarLocation39 = {1975, -1307, 20.1}
local dollarLocation40 = {1905, -1891, 14.3}
local dollarLocation41 = {778, -1661, 4}
local dollarLocation42 = {1472.8, -1012.7, 26.1}
local dollarLocation43 = {1975, -1634, 17.9}
local dollarLocation44 = {2611, -2209, -0.8}
local dollarLocation45 = {976, -942, 40.5}

local dollarLocations = { }

function changeState(newstate,oldstate)
	
	--outputChatBox(oldstate .. " -> " .. newstate) --uncomment this to see the race states in the chat box
	
	if (newstate == "GridCountdown") then 
		--Put code here that executes on countdown start
		CreateDollar(source)		
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then		
		setTimer(function()
    		triggerClientEvent(root, "getPlayerPos", root, randomLocation)
		end, 1000, 0)
	end

	if (newstate == "SomeoneWon") then
		--Put code here that executes when someone wins
	end


end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), changeState)

function CreateDollar ( thePlayer, commandName )
   if ( thePlayer ) then
   	  triggerClientEvent(root, "hideBlips", root, theDollar)
      if (randomLocation == nil) then
      	randomLocation = table.random(dollarLocations)
      end
      x = randomLocation[1]
      y = randomLocation[2]
      z = randomLocation[3]
      -- create a cylindrical marker next to the player:
      theDollar = createObject(1274, x, y, z, 0, 0, 0)
      setObjectScale(theDollar, 2.0)
      triggerClientEvent(root, "setDollar", root, theDollar)
      triggerClientEvent(root, "onClientScreenFadedOut", resourceRoot)
      dollarCreated = 1
   end
end

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

function player_Spawn ( posX, posY, posZ, spawnRotation, theTeam, theSkin, theInterior, theDimension )
	if (dollarCreated == 1) then
		triggerClientEvent(root, "setDollar", root, theDollar)
	end
end
-- add the player_Spawn function as a handler for onPlayerSpawn
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )

function loadMapObjects()
   -- create an object at a specified position with a specified rotation
   table.insert(dollarLocations, dollarLocation1)
   table.insert(dollarLocations, dollarLocation2)
   table.insert(dollarLocations, dollarLocation3)
   table.insert(dollarLocations, dollarLocation4)
   table.insert(dollarLocations, dollarLocation5)
   table.insert(dollarLocations, dollarLocation6)
   table.insert(dollarLocations, dollarLocation7)
   table.insert(dollarLocations, dollarLocation8)
   table.insert(dollarLocations, dollarLocation9)
   table.insert(dollarLocations, dollarLocation10)
   table.insert(dollarLocations, dollarLocation11)
   table.insert(dollarLocations, dollarLocation12)
   table.insert(dollarLocations, dollarLocation13)
   table.insert(dollarLocations, dollarLocation14)
   table.insert(dollarLocations, dollarLocation15)
   table.insert(dollarLocations, dollarLocation16)
   table.insert(dollarLocations, dollarLocation17)
   table.insert(dollarLocations, dollarLocation18)
   table.insert(dollarLocations, dollarLocation19)
   table.insert(dollarLocations, dollarLocation20)
   table.insert(dollarLocations, dollarLocation21)
   table.insert(dollarLocations, dollarLocation22)
   table.insert(dollarLocations, dollarLocation23)
   table.insert(dollarLocations, dollarLocation24)
   table.insert(dollarLocations, dollarLocation25)
   table.insert(dollarLocations, dollarLocation26)
   table.insert(dollarLocations, dollarLocation27)
   table.insert(dollarLocations, dollarLocation28)
   table.insert(dollarLocations, dollarLocation29)
   table.insert(dollarLocations, dollarLocation30)
   table.insert(dollarLocations, dollarLocation31)
   table.insert(dollarLocations, dollarLocation32)
   table.insert(dollarLocations, dollarLocation33)
   table.insert(dollarLocations, dollarLocation34)
   table.insert(dollarLocations, dollarLocation35)
   table.insert(dollarLocations, dollarLocation36)
   table.insert(dollarLocations, dollarLocation37)
   table.insert(dollarLocations, dollarLocation38)
   table.insert(dollarLocations, dollarLocation39)
   table.insert(dollarLocations, dollarLocation40)
   table.insert(dollarLocations, dollarLocation41)
   table.insert(dollarLocations, dollarLocation42)
   table.insert(dollarLocations, dollarLocation43)
   table.insert(dollarLocations, dollarLocation44)
   table.insert(dollarLocations, dollarLocation45)
	
end
addEventHandler("onResourceStart", resourceRoot, loadMapObjects)
