function drawBoost()
	for index,item in ipairs (objects) do
		dxDrawMaterialLine3D(item[1],item[2],item[3],item[4],item[5],item[6],image,7,tocolor(255,255,255,255),item[1],item[2],item[3]-1)
	end
end

objects = {}
function start()
	for i=1,7 do
		local obj1 = getElementByID("boost"..i.."-1")
		local obj2 = getElementByID("boost"..i.."-2")
		local x1,y1,z1 = getElementPosition(obj1)
		local x2,y2,z2 = getElementPosition(obj2)
		table.insert(objects,{x1,y1,z1,x2,y2,z2})
	end
	image = dxCreateTexture("arrow1.png")
	addEventHandler("onClientRender",root,drawBoost)
end
start()

function expert()
	for index, theObject in ipairs (getElementsByType("object")) do
		if getElementModel(theObject) == 18450 then
			setElementModel(theObject,4652)
		end
	end
end
addCommandHandler("expert",expert)