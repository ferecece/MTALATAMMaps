local myLabel = guiCreateLabel  ( 0.25, 0.65, 10, 10, "Compass is pointing to: ", true )
local updateLabel = guiCreateLabel  ( 0.25, 0.67, 10, 10, "Next update in: 15 ", true )
local updateInterval = 15
local dollarObject
local gate
local dollarCheck = 0

function updateCompass(location)
	-- get the local player's position
	
	local px, py, pz = getElementPosition(localPlayer)
	local x = location[1]
    local y = location[2]
    local z = location[3]
    local Xdirection = ""
    local Ydirection = ""
	-- output it to the console
	--outputConsole("Your location: ".. px .." ".. py .." ".. pz)
	--outputConsole("Dollar location: ".. x .." ".. y .." ".. z)
	if (py < y) then
		if ( py + 30 < y) then
			Ydirection = "North"
		else
			Ydirection = ""
		end
	else
		if ( py - 30 > y) then
			Ydirection = "South"
		else
			Ydirection = ""
		end
	end
	
	if (px < x) then
		if ( px + 30 < x) then
			Xdirection = "East"
		else
			Xdirection = ""
		end
	else
		if ( px - 30 > x) then
			Xdirection = "West"
		else
			Xdirection = ""
		end
	end
	
	if (Ydirection == "" and Xdirection == "") then
		--outputConsole("Target is close! Just try to find it")
		guiSetText(myLabel, "Target is close! Just try to find it")
	else
		--outputConsole("Compass is pointing to: " .. Ydirection .. Xdirection)
		guiSetText(myLabel, "Compass is pointing to: " .. Ydirection .. Xdirection)
	end	
	
	
end

function callClientFunction(location, theDollar)

	updateInterval = updateInterval - 1
	if (updateInterval == 0) then
		updateCompass(location)
		updateInterval = 15
	end
	guiSetText(updateLabel, "Next update in: " .. updateInterval)
	if (dollarCheck == 1) then
		guiSetText(updateLabel, "Checkpoint is unlocked!")
		guiSetText(myLabel, "You found it!")
	end
	
	
end
addEvent("getPlayerPos", true)
addEventHandler("getPlayerPos", resourceRoot, callClientFunction)

function setClientDollar(source)
	dollarObject = source
end
addEvent("setDollar", true)
addEventHandler("setDollar", resourceRoot, setClientDollar)

function setGUI()
   guiLabelSetColor(myLabel, 0, 255, 0)
   guiLabelSetColor(updateLabel, 255, 255, 0)
   --gate = createObject(971, 1521.3, -1657.5, 16, 0, 0, 90)
   outputChatBox("To reach the checkpoint, find the Dollar Sign that is hidden somewhere in Los Santos. Every 15 seconds, you get a new hint that tells you the direction of where the dollar is located. Use the minimap as a compass, with the N icon as a reference for north!", 0, 255, 0)
  
end
addEventHandler("onClientResourceStart", resourceRoot, setGUI)

-- This code works because onClientVehicleCollision is triggered before any SA reaction to the collision, therefore we can update the knocked off bike status just before the collision and stop the falling off effect happening :)
addEventHandler("onClientVehicleCollision", root,
    function ( hit ) 
        -- firstly did we trigger this event
        if ( source == getPedOccupiedVehicle(localPlayer) ) then
            if ( hit == dollarObject ) then
            	if (dollarCheck == 0) then
            		--outputChatBox("You found it! The checkpoint has been unlocked.", 0, 255, 255)
            		--moveObject(gate, 1000, 1521.3, -1657.5, 0)
            		setElementPosition(source, 1516.5, -1657, 16)
            		--dollarCheck = 1
            	end
            end 
        end
    end
)

addEventHandler("onClientPlayerWasted", localPlayer, function(killer, weapon, bodyPart)
	if (dollarCheck == 1) then
		outputChatBox("Whether you died by accident or you tried to cheat the system, bad news. Checkpoint is locked again", 255, 0 ,0)
		--moveObject(gate, 1000, 1517, -1657.5, 16)
		dollarCheck = 0
	end
end)

addEvent ( "hideBlips", true )
addEventHandler ( "hideBlips", root,
	function()
		local blips = getElementsByType ("blip")
		for i, element in ipairs(blips) do
			setBlipVisibleDistance(element, 0)
		end
	end
)
