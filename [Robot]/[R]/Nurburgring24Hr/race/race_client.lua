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
			[4034] = true,
			[4035] = true,
			[4036] = true,
			[4037] = true,
			[4038] = true,
			[4039] = true,
			[4040] = true,
			[4041] = true,
			[4042] = true,
			[4043] = true,
			[4044] = true,
			[4045] = true,
			[4046] = true,
			[4047] = true,
			[4048] = true,
			[4049] = true,
			[4050] = true,
			[4051] = true,
			[4052] = true,
			[4053] = true,
			[4054] = true,
			[4055] = true,
			[4056] = true,
			[4057] = true,
			[4058] = true,
			[4059] = true,
			[4060] = true,
			[4061] = true,
			[4062] = true,
			[4063] = true,
			[4064] = true,
			[4065] = true,
			[4066] = true,
			[4067] = true,
			[4068] = true,
			[4069] = true,
			[4070] = true,
			[4071] = true,
			[4072] = true,
			[4073] = true,
			[4074] = true,
			[4075] = true,
			[4076] = true,
			[4077] = true,
			[4078] = true,
			[4079] = true,
			[4080] = true,
			[4081] = true,
			[4082] = true,
			[16061] = true,
			[4811] = true,
			[4812] = true,
			[4814] = true
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
