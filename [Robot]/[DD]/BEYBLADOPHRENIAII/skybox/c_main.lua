-- Shader SKYBOX v1.22 by DaXx

-- Adjust texture size and other properties
local skybox = {
	modelID = 15057, -- model id to replace
	
	objRescale = {10,10,10}, -- (0.1-1) ball texture rescale
	animateTexture = {1,1,1}, -- (0-1) will animate by values
	rotateTexture = {0,0,0}, -- x,y,z rotation angles (radian)
	fogEnable = false, -- enable fog effect
	fogPow = 2.0, -- (1-2) fog effect intensity power
	fogMul = 0.97, -- (0-1) fog effect intensity multiplier
	sphereShadStretch = {1,1,2}, -- (0.5-2) sphere shape stretch
	sphereShadMove = {0,0,0}, -- (0-1) sphere shape move
	textureColorMul = {1,1,1,1}, -- (0-1) multiply color values
	textureColorPow = 1.3, -- (1-2) contrast power
    textureColorAlpha = 1, -- (0-1) alpha multiplier
	
	shader = nil, texture = nil, object = nil, txd = nil, dff = nil
}

function startShaderResource()
	if sbxEffectEnabled then return end
	skybox.txd = engineLoadTXD( 'skybox/tex/sphere.txd' )
	engineImportTXD( skybox.txd, skybox.modelID)
	skybox.dff = engineLoadDFF( 'skybox/dff/sphere.dff', skybox.modelID )
	engineReplaceModel( skybox.dff, skybox.modelID, true )  

	local camX, camY, camZ = getCameraMatrix()
	skybox.object = createObject ( skybox.modelID, camX, camY, camZ, 0, 0, 0, true ) 
	setElementAlpha( skybox.object, 1 )
	setObjectScale ( skybox.object, 7, 7, 7)  
 
	skybox.shader = dxCreateShader ( "skybox/fx/skybox.fx", 0, 0, false, "object", skybox.object )
	skybox.texture = dxCreateTexture ( "skybox/tex/cubebox.dds" )

	if not skybox.shader or not skybox.texture then 
		outputChatBox('Could not start Skybox shader!',255,0,0)
		return 
	else
		outputConsole('Skybox Shader Started.')
	end
	dxSetShaderValue ( skybox.shader, "sTextureCube", skybox.texture )

	dxSetShaderValue ( skybox.shader, "gRescale", skybox.objRescale[1]/8, skybox.objRescale[2]/8, skybox.objRescale[3]/8)
	dxSetShaderValue ( skybox.shader, "fFogEnable", skybox.fogEnable )
	dxSetShaderValue ( skybox.shader, "fFogMul", skybox.fogMul )
	dxSetShaderValue ( skybox.shader, "fFogMul", skybox.fogPow )
	
	dxSetShaderValue ( skybox.shader, "gColorMul", skybox.textureColorMul )
	dxSetShaderValue ( skybox.shader, "gColorPow", skybox.textureColorPow )
	dxSetShaderValue ( skybox.shader, "gColorAlpha", skybox.textureColorAlpha )
	
	dxSetShaderValue ( skybox.shader, "gAnimate", skybox.animateTexture) 
	dxSetShaderValue ( skybox.shader, "gRotate", skybox.rotateTexture) 

	dxSetShaderValue ( skybox.shader, "gStretch",skybox.sphereShadStretch) 
	dxSetShaderValue ( skybox.shader, "gMove",skybox.sphereShadMove) 
 
	engineApplyShaderToWorldTexture ( skybox.shader, "skybox_tex" )

	sbxEffectEnabled = true
	addEventHandler ( "onClientPreRender", getRootElement (), renderSphere )
end

function stopShaderResource()
	if not sbxEffectEnabled then return end
	removeEventHandler ( "onClientPreRender", getRootElement (), renderSphere )
	engineRemoveShaderFromWorldTexture ( skybox.shader, "*" ) 
	destroyElement( skybox.shader )
	destroyElement( skybox.texture )
	skybox.object = nil
	skybox.shader = nil
	skybox.texture = nil
	engineRestoreModel( skybox.modelID )	
	destroyElement( skybox.dff )
	destroyElement( skybox.txd ) 
	skybox.dff = nil
	skybox.txd = nil
	sbxEffectEnabled = false
end

function renderSphere()
	if not sbxEffectEnabled then return end
	local camX, camY, camZ = getCameraMatrix()
	setElementPosition ( skybox.object, camX, camY, camZ ,false )
	local watLvl = getWaterLevel( camX, camY, camZ )
	if watLvl then
		if ( camZ - 0.65 < watLvl ) then
			dxSetShaderValue ( skybox.shader, "gIsInWater", true )
		end
	end
	if not watLvl or ( camZ - 0.65 > watLvl ) then
		dxSetShaderValue ( skybox.shader, "gIsInWater", false )
	end	
end


setSkyGradient(0,0,0,0,0,0)
setWaterColor(0,0,0,255)
setFogDistance(500)
