-- Disco Derby script by Ali Digitali --
-- Feel free to copy this script, as long as you don't claim it as your own --

-- script is client side --

-- This script will make a car explode if they come in contact with the party bus --

function TriggerExplosion(theHitElement)
	if theHitElement then
		if getElementType(theHitElement)== "vehicle" and getElementData(theHitElement,"disco") == true then
			triggerServerEvent("triggerBlow",localPlayer,source)
		end
	end
end
addEventHandler("onClientVehicleCollision", getRootElement(),TriggerExplosion)


function getRandomBrightColor()
	local r,g,b
	
	r = math.random(0,1)*255
	g = math.random(0,1)*255
	
	if (r == 255) and (g == 255) then
		b = 0
	elseif (r==0) and (g == 0) then
		b = 255
	else
		b = math.random(0,1)*255
	end
	return r,g,b
end


function cycleSky(red,green,blue)
	local red2,green2,blue2
	repeat 
		red2,green2,blue2 = getRandomBrightColor()
	until (red2 ~= red) or (blue2 ~= blue) or (green2 ~= green)
	
	--outputChatBox("current = " .. tostring(red) .. "  " .. tostring(green) .. "   " .. tostring(blue))
	--outputChatBox("moveto = " .. tostring(red2) .. "  " .. tostring(green2) .. "   " .. tostring(blue2))
	
	red_save=red
	blue_save=blue
	green_save=green
	
	directionRed = ((red2-red)/255)
	directionGreen = (green2-green)/255
	directionBlue = (blue2-blue)/255
	
	startTime = getTickCount()
	finishTime = startTime+5000
	
	setTimer(cycleSky,5500,1,red2,green2,blue2)
end


function markerColor()
		for index,theMarker in ipairs(getElementsByType("marker")) do
			if (getMarkerType(theMarker) == "corona") and (getMarkerSize(theMarker)>7) then
				local progress = 1-((finishTime-getTickCount())/5000)
				if progress > 1 then
					progress = 1 
				elseif progress < 0 then
					progress = 0
				end
				--outputChatBox(progress)
				local r,g,b
				r= math.floor(red_save + directionRed*progress*255)
				g= math.floor(green_save + directionGreen*progress*255)
				b = math.floor(blue_save + directionBlue*progress*255)
				--outputChatBox("brightColor = " .. r .. "  " .. g.. "   " .. b)
				setMarkerColor(theMarker,r,g,b,255)
			end
		end
end
cycleSky(0,255,0)
addEventHandler("onClientRender",root,markerColor)