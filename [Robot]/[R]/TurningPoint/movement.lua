-- DDC OMG generated script, PLACE IT SERVER-SIDE

function omg_movement()
  omg2513 = createObject(4651, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 90)
  omgMoveomg2513(1)
  objectcsroadbridge044 = createObject(18450, 3080, -1800, 10, 0, 0, 135)
  omgMoveobjectcsroadbridge044(1)
  omg3543 = createObject(4651, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 180)
  omgMoveomg3543(1)
  spindisk = createObject(7586, 3045, -1720, 20, 0, 90, 0)
  omgMovespindisk(1)
  objectcsroadbridge047 = createObject(18450, 3000, -1640, 10, 0, 0, 90)
  omgMoveobjectcsroadbridge047(1)
  omg8773 = createObject(4651, 3041.8911132813, -1617.3615722656, 35.161041259766, 0, 0, 0)
  omgMoveomg8773(1)
  spindisk2 = createObject(7586, 3035, -1720, 20, 0, 270, 0)
  omgMovespindisk2(1)
  objectcsroadbridge046 = createObject(18450, 3080, -1640, 10, 0, 0, 90)
  omgMoveobjectcsroadbridge046(1)
  lift = createObject(18450, 3080, -1935, 40, 0, 0, 90)
  omgMovelift(1)
  omg3576 = createObject(4651, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 270)
  omgMoveomg3576(1)
  objectcsroadbridge042 = createObject(18450, 3000, -1800, 10, 0, 0, 135)
  omgMoveobjectcsroadbridge042(1)
end

function omgMoveomg2513(point)
    moveObject(omg2513, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
    setTimer(moveObject, 20000, 0, omg2513, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
end

function omgMoveobjectcsroadbridge044(point)
    moveObject(objectcsroadbridge044, 30000, 3080, -1800, 10, 0, 0, 360)
    setTimer(moveObject, 30000, 0, objectcsroadbridge044, 30000, 3080, -1800, 10, 0, 0, 360)
end

function omgMoveomg3543(point)
    moveObject(omg3543, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
    setTimer(moveObject, 20000, 0, omg3543, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
end

function omgMovespindisk(point)
    moveObject(spindisk, 5000, 3045, -1720, 20, 360, 0, 0)
    setTimer(moveObject, 5000, 0, spindisk, 5000, 3045, -1720, 20, 360, 0, 0)
end

function omgMoveobjectcsroadbridge047(point)
    moveObject(objectcsroadbridge047, 30000, 3000, -1640, 10, 0, 0, 360)
    setTimer(moveObject, 30000, 0, objectcsroadbridge047, 30000, 3000, -1640, 10, 0, 0, 360)
end

function omgMoveomg8773(point)
    moveObject(omg8773, 20000, 3041.8911132813, -1617.3615722656, 35.161041259766, 0, 0, 360)
    setTimer(moveObject, 20000, 0, omg8773, 20000, 3041.8911132813, -1617.3615722656, 35.161041259766, 0, 0, 360)
end

function omgMovespindisk2(point)
    moveObject(spindisk2, 5000, 3035, -1720, 20, -360, 0, 0)
    setTimer(moveObject, 5000, 0, spindisk2, 5000, 3035, -1720, 20, -360, 0, 0)
end

function omgMoveobjectcsroadbridge046(point)
    moveObject(objectcsroadbridge046, 30000, 3080, -1640, 10, 0, 0, 360)
    setTimer(moveObject, 30000, 0, objectcsroadbridge046, 30000, 3080, -1640, 10, 0, 0, 360)
end

function omgMovelift(point)
  if point == 1 then
    moveObject(lift, 15000, 3080, -1935, 7.5, 0, 0, 0)
    setTimer(omgMovelift, 15000, 1, 2)
  elseif point == 2 then
    moveObject(lift, 15000, 3080, -1935, 40, 0, 0, 0)
    setTimer(omgMovelift, 15000, 1, 1)
  end
end

function omgMoveomg3576(point)
    moveObject(omg3576, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
    setTimer(moveObject, 20000, 0, omg3576, 20000, 3041.890625, -1617.361328125, 35.161041259766, 0, 0, 360)
end

function omgMoveobjectcsroadbridge042(point)
    moveObject(objectcsroadbridge042, 30000, 3000, -1800, 10, 0, 0, 360)
    setTimer(moveObject, 30000, 0, objectcsroadbridge042, 30000, 3000, -1800, 10, 0, 0, 360)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_movement)
