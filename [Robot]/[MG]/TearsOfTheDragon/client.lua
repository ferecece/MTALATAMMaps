-- Clientside Script
-- Author: Ali_Digitali
-- twitch.tv/AliDigitali
-- Anyone reading this has permission to copy parts of this script

--setDevelopmentMode(true)

-- Generate a string that is unique for this resource (the resource name) to be used as a data key.
uniqueKey = tostring(getResourceName(getThisResource()))

--function to update the race states
function clientRaceState(dataName,oldValue)
	if dataName == uniqueKey.."raceState" then
		local newstate = getElementData(source,uniqueKey.."raceState")
		if (newstate == "GridCountdown") then
			--code here
		end
	end
end
addEventHandler("onClientElementDataChange",root,clientRaceState)

local material =  dxCreateTexture("black.png")
function draw()
	local count = 0
	for i,o in ipairs (getElementsByType("object")) do
		if getElementModel(o) == 3095 then
			local x,y,z = getElementPosition(o)
			if count ==0 then
				dxDrawMaterialLine3D(x-2.7,y,z+0.6,x+2.7,y,z+0.6,material,6,tocolor(0,255,0,255),x,y,z-10)
			elseif count < 13 then
				local ratio = count/12
				local p = -510*ratio
				local r,g = math.max(math.min(p + 255*ratio + 255, 255), 0), math.max(math.min(p + 765*ratio, 255), 0)
				dxDrawMaterialLine3D(x-2.7,y,z+0.6,x+2.7,y,z+0.6,material,6,tocolor(r,g,0,255),x,y,z-10)
			end
			count = count+1
			fxAddTankFire(x,y,z+1,0,0,-90)
		end
	end
	--local x,y,z = getElementPosition(localPlayer)
	--fxAddTankFire(x,y,z,0,0,90)
	--outputChatBox("tile objects: "..count)
end
addEventHandler("onClientRender",root,draw)


function createHydrants()
	local GLP = getLocalPlayer()
	local x, y, z = getElementPosition(GLP) -- Get your location.
	for i=0, 20 do -- 20 Hydrants.
		fxAddWaterHydrant(x + math.random(-5,5), y + math.random(-5,5), z) -- Using math.random, and your current location 20 water hydrants are created.
	end
end
addCommandHandler("hydrantmania", createHydrants)