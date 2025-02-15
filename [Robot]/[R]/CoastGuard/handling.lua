function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 472 then
            --setVehicleHandling(veh,"mass",1000)
            setVehicleHandling(veh,"turnMass",3000)
            setVehicleHandling(veh,"collisionDamageMultiplier",0.3)
            setVehicleHandling(veh,"steeringLock",21)
            --setVehicleHandling(veh,"drag",0.0)
            setVehicleHandling(veh,"engineAcceleration",1.4)
            setVehicleHandling(veh,"maxVelocity",255)    
        end
    end     
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), handling)


function waterThing()
    water = {
        createWater ( -2423,1532,18, -2340,1532,18, -2423,1558.5,18, -2340,1558,18)
    }
end
addEventHandler ("onResourceStart", resourceRoot, waterThing)

-- DDC OMG generated script, PLACE IT SERVER-SIDE

function omg_platforms()
    platlight13 = createObject(3526, -2399.9167480469, 1522.5185546875, -0.31364580988884, 0, 0, 90)
    omgMoveplatlight13(1)
    platlight12 = createObject(3526, -2407.6833496094, 1522.5185546875, -0.30465793609619, 0, 0, 90)
    omgMoveplatlight12(1)
    platform1 = createObject(10184, -2407.6066894531, 1524.6815185547, -0.52300798892975, 0, 90, 90)
    omgMoveplatform1(1)
    platlight11 = createObject(3526, -2415.3288574219, 1522.5187988281, -0.29145792126656, 0, 0, 90)
    omgMoveplatlight11(1)
  end
    
function omgMoveplatform1(point)
  if point == 1 then
    moveObject(platform1, 10000, -2407.6066894531, 1524.6815185547, 17.7366771698, 0, 0, 0)
    setTimer(omgMoveplatform1, 10000+3000, 1, 2)
  elseif point == 2 then
    moveObject(platform1, 8000, -2407.6066894531, 1524.6815185547, -0.52300798892975, 0, 0, 0)
    setTimer(omgMoveplatform1, 8000+3000, 1, 1)
  end
end
function omgMoveplatlight13(point)
  if point == 1 then
    moveObject(platlight13, 10000, -2399.9167480469, 1522.5185546875, 18, 0, 0, 0)
    setTimer(omgMoveplatlight13, 10000+3000, 1, 2)
  elseif point == 2 then
    moveObject(platlight13, 8000, -2399.9167480469, 1522.5185546875, -0.32, 0, 0, 0)
    setTimer(omgMoveplatlight13, 8000+3000, 1, 1)
  end
end

function omgMoveplatlight12(point)
  if point == 1 then
    moveObject(platlight12, 10000, -2407.6833496094, 1522.5185546875, 18, 0, 0, 0)
    setTimer(omgMoveplatlight12, 10000+3000, 1, 2)
  elseif point == 2 then
    moveObject(platlight12, 8000, -2407.6833496094, 1522.5185546875, -0.32, 0, 0, 0)
    setTimer(omgMoveplatlight12, 8000+3000, 1, 1)
  end
end

function omgMoveplatlight11(point)
  if point == 1 then
    moveObject(platlight11, 10000, -2415.3288574219, 1522.5187988281, 18, 0, 0, 0)
    setTimer(omgMoveplatlight11, 10000+3000, 1, 2)
  elseif point == 2 then
    moveObject(platlight11, 8000, -2415.3288574219, 1522.5187988281, -0.32, 0, 0, 0)
    setTimer(omgMoveplatlight11, 8000+3000, 1, 1)
  end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_platforms)

