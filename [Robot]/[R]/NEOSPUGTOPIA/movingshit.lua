-- DDC OMG generated script, PLACE IT SERVER-SIDE

function omg_movingshit()
  rotatenew = createObject(7504, -2.9363811016083, -3694.26171875, 1078.0849609375, 0, 90, 54)
  rotatenewAttach1 = createObject(7504, -2.9365234375, -3694.26171875, 1078.0849609375, 0, 0, 53.997802734375)
  attachElements(rotatenewAttach1, rotatenew, -8.3662938013215e-05, 0.00011515215529489, 0, 0, -90, -0.002197265625)
  omgMoverotatenew(1)
  movingtrainnew = createObject(3585, 207.3801574707, -3121.984375, 1106.5516357422, 0, 0, 293.24200439453)
  movingtrainnewAttach1 = createObject(3785, 209.79808044434, -3125.3308105469, 1105.5915527344, 0, 0, 293.74694824219)
  attachElements(movingtrainnewAttach1, movingtrainnew, 4.0290100897948, 0.9011437577638, -0.96008300782501, 0, 0, 0.5049438476575)
  movingtrainnewAttach2 = createObject(3785, 208.19476318359, -3126.03125, 1105.5915527344, 0, 0, 293.75)
  attachElements(movingtrainnewAttach2, movingtrainnew, 4.0399122211155, -0.84846271502388, -0.96008300782501, 0, 0, 0.50799560547)
  omgMovemovingtrainnew(1)
  movingtrainy = createObject(9958, 469.69195556641, -3049.6225585938, 1132.9713134766, 352.00073242188, 359.24261474609, 292.64453125)
  omgMovemovingtrainy(1)
end

function omgMoverotatenew(point)
  moveObject(rotatenew, 2800, 13.73633, -3706.26171875, 1078.0849609375, 0, 360, 0)
  setTimer(moveObject, 2800, 0, rotatenew, 2800, 13.73633, -3706.26171875, 1078.0849609375, 0, 360, 0)
end

function omgMovemovingtrain500(point)
  if point == 1 then
    moveObject(movingtrain500, 11000, 220.82177734375, -3163.5942382812, 1106.5463867188, 0, 0, 0)
    setTimer(omgMovemovingtrain500, 11000, 1, 2)
  elseif point == 2 then
    moveObject(movingtrain500, 3000, 221.72308349609, -3165.6904296875, 1106.5463867188, 0, 0, 0)
    setTimer(omgMovemovingtrain500, 3000+600, 1, 3)
  elseif point == 3 then
    moveObject(movingtrain500, 12000, 221.6474609375, -3122.5693359375, 1106.5463867188, 0, 0, 0)
    setTimer(omgMovemovingtrain500, 12000+1000, 1, 1)
  end
end

function omgMovemovingtrainnew(point)
  if point == 1 then
    moveObject(movingtrainnew, 3000, 208.44660949707, -3124.4453125, 1106.5516357422, 0, 0, 0)
    setTimer(omgMovemovingtrainnew, 3000, 1, 2)
  elseif point == 2 then
    moveObject(movingtrainnew, 14000, 223.68559265137, -3160.5024414062, 1106.5516357422, 0, 0, 0)
    setTimer(omgMovemovingtrainnew, 14000, 1, 3)
  elseif point == 3 then
    moveObject(movingtrainnew, 2000, 224.72369384766, -3163.1567382812, 1106.5516357422, 0, 0, 0)
    setTimer(omgMovemovingtrainnew, 2000+2500, 1, 4)
  elseif point == 4 then
    moveObject(movingtrainnew, 2500, 224.20674133301, -3161.775390625, 1106.5516357422, 0, 0, 0)
    setTimer(omgMovemovingtrainnew, 2500, 1, 5)
  elseif point == 5 then
    moveObject(movingtrainnew, 15000, 207.3801574707, -3121.984375, 1106.5516357422, 0, 0, 0)
    setTimer(omgMovemovingtrainnew, 15000+2000, 1, 1)
  end
end

function omgMovemovingtrainy(point)
  if point == 1 then
    moveObject(movingtrainy, 8000, 272.24496459961, -3130.6291503906, 1159.5113525391, 0.99990844726, 0.0017395019600031, 0.013305664059999)
    setTimer(omgMovemovingtrainy, 8000, 1, 2)
  elseif point == 2 then
    moveObject(movingtrainy, 2000, 215.3380279541, -3152.0224609375, 1164.1363525391, 6.49945068359, 0.0056152343699978, -2.16445922851)
    setTimer(omgMovemovingtrainy, 2000, 1, 3)
  elseif point == 3 then
    moveObject(movingtrainy, 8000, 2.7123727798462, -3230.8803710938, 1163.4613037109, 3.0517580000833e-05, -9.1552729998057e-05, 3.0517569996391e-05)
    setTimer(omgMovemovingtrainy, 8000, 1, 4)
  elseif point == 4 then
    moveObject(movingtrainy, 100, 2.7123727798462, -3230.8803710938, 1400.8214111328, 0, 0, 0)
    setTimer(omgMovemovingtrainy, 100, 1, 5)
  elseif point == 5 then
    moveObject(movingtrainy, 100, 529.06268310547, -3061.5734863281, 1416.8642578125, 0, 0, 0)
    setTimer(omgMovemovingtrainy, 100, 1, 6)
  elseif point == 6 then
    moveObject(movingtrainy, 100, 469.69195556641, -3049.6225585938, 1132.9713134766, -7.49938964843, -0.0072631836000028, 2.15112304688)
    setTimer(omgMovemovingtrainy, 100+6000, 1, 1)
  end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_movingshit)



function changeDistance()
  for i,object in pairs(getElementsByType("object")) do
      if isElement(object) then
          local elementID = getElementModel(object )
          engineSetModelLODDistance(elementID,1000)
      end
  end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)
