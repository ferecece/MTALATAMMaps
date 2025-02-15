--
-- c_main.lua
--

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        outputChatBox('- Stillwater map by Johnline, shaders and fixes by Ren712',255,255,125)
        outputChatBox('- Hit: "7" - switch LOD objects "8" - reload models "9" - switch shaders',255,255,125)
    end
)

addEventHandler("onClientResourceStart", resourceRoot, function()
    setCloudsEnabled(false)
    setSkyGradient(0, 0, 0, 0, 0, 0)
    loadModels() 
    loadMap() 
    applyShaders()
    applyCoronas()
    applySkybox()
    applyLod()
end
)

addEventHandler("onClientResourceStop", resourceRoot, function()
    setCloudsEnabled(true)
    resetSkyGradient()
    unloadModels() 
    unloadMap()
    removeShaders()
    removeCoronas()
    removeSkybox()
end
)


