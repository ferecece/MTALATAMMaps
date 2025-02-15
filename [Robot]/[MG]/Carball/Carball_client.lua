-- Carball clicentside script by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script

-- Things handled by this script:
-- - load the texture of the ball on to the dynamic quarry rock object
-- - creating the live-feed screens

function loadBall()
	--setDevelopmentMode(true)
	txd = engineLoadTXD("beachball.txd")
	engineImportTXD(txd,1305)

	dff = engineLoadDFF("beachball.dff",0)
	engineReplaceModel(dff,1305)
end
addEventHandler("onClientResourceStart",root,loadBall)

addEventHandler( "onClientRender", root,
    function()
		if myScreenSource then
            dxUpdateScreenSource( myScreenSource )
			for index,_ in ipairs (screens) do
				dxDrawImage3D(screens[index][1],screens[index][2],screens[index][3],21,11,myScreenSource,screens[index][4],screens[index][5],screens[index][6])
			end
		end
		
		if field then
			dxDrawMaterialLine3D(546.9,-2134.8,6.75,546.9,-2381.3,6.75,field,309,tocolor(255,255,255,255),546.9,-2134.8,20)
		end
    end
)

local white = tocolor(255,255,255,255)
function dxDrawImage3D(x,y,z,w,h,m,...)
	return dxDrawMaterialLine3D(x, y, z+h,x,y,z, m, w,white,...)
end


addEventHandler("onClientResourceStart", resourceRoot,
    function()
        
		local x,y = guiGetScreenSize()
		myScreenSource = dxCreateScreenSource(x,y)    -- Create a screen source texture which is 500 x 500 pixels

		-- load the coordinates of the screens into a table
		screens = {}
		local i = 1
		for index,theObject in ipairs(getElementsByType("object")) do
			local model = getElementModel(theObject)
			if (model == 18275) then
				local rotx,roty,rotz = getElementRotation(theObject)
				if (roty>179) and (roty<181) then
					local x,y,z = getPositionFromElementOffset(theObject,0,0,5.7)
					local xlook,ylook,zlook = getPositionFromElementOffset(theObject,0,-1,0)
					screens[i]={x,y,z,xlook,ylook,zlook}
					i = i+1
				end
			end
		end
		
		field = dxCreateTexture("field.jpg")
	end
)

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end


-----------------
-- Ped Animations
-----------------

for index,thePed in ipairs(getElementsByType("ped"))do
	setElementModel(thePed,math.random(1,400))
	setPedAnimation(thePed,"ON_LOOKERS","wave_loop")
end