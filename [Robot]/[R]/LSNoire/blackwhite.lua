local screenX, screenY = guiGetScreenSize()
local screenSource = dxCreateScreenSource(screenX, screenY)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
    if getVersion ().sortable < "1.1.0" then
        return
	else
		blackWhiteShader, blackWhiteTec = dxCreateShader("fx/blackwhite.fx")
    end
end)

addEventHandler("onClientPreRender", getRootElement(),
function()
    if (blackWhiteShader) then
        dxUpdateScreenSource(screenSource)     
        dxSetShaderValue(blackWhiteShader, "screenSource", screenSource)
        dxDrawImage(0, 0, screenX, screenY, blackWhiteShader)
    end
end)