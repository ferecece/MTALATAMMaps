-- DDC OMG generated script, PLACE IT SERVER-SIDE

function omg_kukot()
  kukko = createObject(16776, -1830.2541503906, 1103.3840332031, 44.039100646973, 0, 0, 90)
  omgMovekukko(1)
end

function omgMovekukko(point)
  if point == 1 then
    moveObject(kukko, 5000, -1754.283203125, 1103.4030761719, 44.039100646973, 0, 0, 0)
    setTimer(omgMovekukko, 5000, 1, 2)
  elseif point == 2 then
    moveObject(kukko, 5000, -1830.2541503906, 1103.3840332031, 44.039100646973, 0, 0, 0)
    setTimer(omgMovekukko, 5000, 1, 1)
  end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_kukot)
