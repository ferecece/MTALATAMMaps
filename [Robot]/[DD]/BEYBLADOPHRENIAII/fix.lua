local marker1 = createMarker(5139.1469726562,-1645.515625,143,"checkpoint", 3, 60, 0, 0, 255)
local marker2 = createMarker(5139.1748046875,-1985.1324462891,143,"checkpoint", 3, 60, 0, 0, 255)
local marker3 = createMarker(5314.8984375,-1815.8842773438,143,"checkpoint", 3, 60, 0, 0, 255)
local marker4 = createMarker(4977.3662109375,-1816.0004882812,143,"checkpoint", 3, 60, 0, 0, 255)
local marker5 = createMarker(5262.15625,-1692.8317871094,143,"checkpoint", 3, 60, 0, 0, 255)
local marker6 = createMarker(5023.34765625,-1932.1021728516,143,"checkpoint", 3, 60, 0, 0, 255)
local marker7 = createMarker(5261.9331054688,-1938.8355712891,143,"checkpoint", 3, 60, 0, 0, 255)
local marker8 = createMarker(5023.501953125,-1700.1644287109,143,"checkpoint", 3, 60, 0, 0, 255)

gMe = getLocalPlayer()

function markeru(hitPlayer)
    if hitPlayer~=gMe then return end
    vehicle=getPedOccupiedVehicle(hitPlayer)
	if source == marker1 then
setElementVelocity(vehicle, 0, -2.3, 0)
				end
	if source == marker2 then
setElementVelocity(vehicle, 0, 2.3, 0)
				end
	if source == marker3 then
setElementVelocity(vehicle, -2.3, 0, 0)
				end
    if source == marker4 then
setElementVelocity(vehicle, 2.3, 0, 0)
				end
    if source == marker5 then
setElementVelocity(vehicle, -1.6, -1.6, 0.00029705147608183)
				end
     if source == marker6 then
setElementVelocity(vehicle, 1.6, 1.6, 0.00029705147608183)
				end
     if source == marker7 then
setElementVelocity(vehicle, -1.6, 1.6, -2.1172781998757e-06)
				end
     if source == marker8 then
setElementVelocity(vehicle, 1.6, -1.6, -2.1172781998757e-06)
				end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),markeru)
--
