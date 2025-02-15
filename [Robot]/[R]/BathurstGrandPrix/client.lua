--------------
--LOD script--
--------------

    local models = {
			[4000] = true,
			[4001] = true,
			[4002] = true,
			[4003] = true,
			[4004] = true,
			[4005] = true,
			[4006] = true,
			[4007] = true,
			[4008] = true,
			[4009] = true,
			[4010] = true,
			[4011] = true,
			[4012] = true,
			[4013] = true,
			[4014] = true,
			[4015] = true,
			[4016] = true,
			[4017] = true,
			[4018] = true,
			[4019] = true,
			[4020] = true,
			[4021] = true,
			[4022] = true,
			[4023] = true,
			[4024] = true,
			[4025] = true,
			[4026] = true,
			[4027] = true,
			[4028] = true,
			[4029] = true,
			[4030] = true,
			[4031] = true,
			[4032] = true,
			[4033] = true,
			[4814] = true,
			[615] = true,
			[669] = true,
			[672] = true,
			[673] = true,
			[700] = true,
			[705] = true,
			[708] = true,
			[713] = true,
			[729] = true,
			[730] = true,
			[768] = true,
			[772] = true,
			[775] = true,
			[16061] = true
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
                                    engineSetModelLODDistance(model,250)
                            end
                    end
            end
    )
