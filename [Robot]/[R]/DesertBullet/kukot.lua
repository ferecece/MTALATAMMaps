-- DDC OMG generated script, PLACE IT SERVER-SIDE

function omg_kukot()
  kukko2 = createObject(16776, 2468.1928710938, 1373.7377929688, 9.3219003677368, 0, 0, 270)
  omgMovekukko2(1)
  kukko = createObject(16776, 2387.1215820313, 1471.8558349609, 9.3219003677368, 0, 0, 90)
  omgMovekukko(1)
end

function omgMovekukko2(point)
  if point == 1 then
    moveObject(kukko2, 5000, 2385.0043945313, 1373.1088867188, 9.3219003677368, 0, 0, 0)
    setTimer(omgMovekukko2, 5000, 1, 2)
  elseif point == 2 then
    moveObject(kukko2, 5000, 2468.1928710938, 1373.7377929688, 9.3219003677368, 0, 0, 0)
    setTimer(omgMovekukko2, 5000, 1, 1)
  end
end

function omgMovekukko(point)
  if point == 1 then
    moveObject(kukko, 5000, 2467.1320800781, 1472.0123291016, 9.3219003677368, 0, 0, 0)
    setTimer(omgMovekukko, 5000, 1, 2)
  elseif point == 2 then
    moveObject(kukko, 5000, 2387.1215820313, 1471.8558349609, 9.3219003677368, 0, 0, 0)
    setTimer(omgMovekukko, 5000, 1, 1)
  end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_kukot)
