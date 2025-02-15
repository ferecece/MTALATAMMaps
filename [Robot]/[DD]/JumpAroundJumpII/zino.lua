speedmarker1 = createMarker(5033.7001953125,234.7001953125,45, "corona", 15, 217, 37, 37, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker1) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 0, 0.82, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker2 = createMarker(5013.7001953125,214.7001953125,45, "corona", 15, 217, 37, 37, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker2) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, -0.82, 0, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker3 = createMarker(5053.7001953125,214.7001953125,45, "corona", 15, 217, 37, 37, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker3) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 0.82, 0, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker4 = createMarker(5033.7001953125,194.7001953125,45, "corona", 15, 217, 37, 37, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker4) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 0, -0.82, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)


speedmarker6 = createMarker(5033.7001953125,414.7001953125,45, "corona", 15, 237, 13, 240, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker6) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 0, -1.12, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker7 = createMarker(5033.7001953125,14.7001953125,45, "corona", 15, 120, 144, 109, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker7) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 0, 1.12, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker8 = createMarker(5233.7001953125,214.7001953125,45, "corona", 15, 14, 239, 78, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker8) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, -1.12, 0, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

speedmarker9 = createMarker(4833.7001953125,214.7001953125,45, "corona", 15, 220, 200, 33, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
if (source==speedmarker9) then
local vehicle = getPedOccupiedVehicle(element)
setElementVelocity(vehicle, 1.12, 0, 1)
end
end
end
end
end

addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)








