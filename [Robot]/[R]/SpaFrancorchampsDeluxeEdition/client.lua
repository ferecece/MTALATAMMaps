--------------
--LOD script--
--------------

    local models = {
            		[5000] = true,
			[5001] = true,
			[5002] = true,
			[5003] = true,
			[5004] = true,
			[5005] = true,
			[5006] = true,
			[5007] = true,
			[5008] = true,
			[5009] = true,
			[5010] = true,
			[5011] = true,
			[5012] = true,
			[5013] = true,
			[5014] = true,
			[5015] = true,
			[5016] = true,
			[5017] = true,
			[5018] = true,
			[5019] = true,
			[5020] = true,
			[5021] = true,
			[5022] = true,
			[5023] = true,
			[5024] = true,
			[5025] = true,
			[5026] = true,
			[5027] = true,
			[5028] = true,
			[5029] = true,
			[5030] = true,
			[5031] = true,
			[5032] = true,
			[5033] = true,
			[5034] = true,
			[5035] = true,
			[5036] = true,
			[5037] = true,
			[5038] = true,
			[5039] = true,
			[5040] = true,
			[5041] = true,
			[5042] = true,
			[5043] = true,
			[5044] = true,
			[5045] = true,
			[5046] = true,
			[9137] = true,
			[9138] = true,
			[9139] = true,
			[8003] = true,
			[6223] = true,
			[4810] = true,
			[4814] = true,
			[7956] = true,
			[13209] = true,
			[13147] = true,
			[13099] = true,
			[906] = true,
			[693] = true,
			[791] = true
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
                                    engineSetModelLODDistance(model,300)
                            end
                    end
            end
    )
