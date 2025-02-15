local delayvalue = false


datmarker = createMarker(3499.8000488281,-1500.0002441406,175,"corona",5,12,7,77,153)


function changeVehFunc ( hitPlayer, matchingDimension )
 if (matchingDimension and hitPlayer == localPlayer) then
  if delayvalue == false then
   triggerServerEvent("changeVeh", localPlayer)
   delayvalue = true
   setTimer(function ()
    delayvalue = false
    end, 10000, 1)
  end
 end
end


addEventHandler("onClientMarkerHit", datmarker, changeVehFunc)




