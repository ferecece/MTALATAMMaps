--------------
--LOD script--
--------------

    local models = {
            		[7639] = true,
			[7637] = true,
			[7609] = true,
			[7608] = true,
			[2221] = true,
			[2222] = true,
			[2223] = true,
			[3092] = true,
			[8397] = true,
			[2189] = true,
			[1956] = true,
			[1322] = true,
			[10184] = true,
			[1649] = true,
			[800] = true,
			[1655] = true,
			[3440] = true,
			[2655] = true,
			[12922] = true,
			[13647] = true,
			[10871] = true
    }
     
    addEventHandler("onClientResourceStart",resourceRoot,
            function()
                    for i,object in ipairs (getElementsByType("object")) do
                            local model = getElementModel(object)
                            if models[model] then
                                    local x,y,z = getElementPosition(object)
                                    local a,b,c = getElementRotation(object)
                                    local lodobject = createObject(model,x,y,z,a,b,c,true)
                                    setElementDimension(lodobject,getElementDimension(object))
                                    setObjectScale(lodobject,getObjectScale(object))
                                    setLowLODElement(object,lodobject)
                                    engineSetModelLODDistance(model,80)
                            end
                    end
            end
    )

---------------------
--Red bollardlights--
---------------------

	addEventHandler("onClientResourceStart",resourceRoot,
		function ()
			for i,obj in ipairs (getElementsByType("object")) do
				if getElementModel(obj) == 7609 then
					setElementCollisionsEnabled (obj, false)
				end
			end
		end
	)




