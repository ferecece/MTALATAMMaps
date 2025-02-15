local objectID=3863

function replace()
	txd = engineLoadTXD("flag.txd")
	engineImportTXD(txd, objectID )
	local dff = engineLoadDFF("flag.dff", objectID) 
	engineReplaceModel(dff, objectID)
	for _,v in ipairs(getElementsByType("object")) do 
		if getElementModel(v)==objectID then
			setElementCollisionsEnabled(v,false)
			setElementDoubleSided(v,true)
			--engineSetModelLODDistance (v,170)
		end
	end
	startShader()
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), replace )


local shader
local flag
local amplitudePower=1.2
local waveSpeed=2
local waves=1
function startShader()
	shader = dxCreateShader("flag.fx")
	if not shader then return end
	dxSetShaderValue(shader,"flag0",dxCreateTexture("flag.png"))--put here your flag texture
	dxSetShaderValue(shader,"noise0",dxCreateTexture("noise.jpg"))
	dxSetShaderValue(shader,"amplitudePower",amplitudePower)
	dxSetShaderValue(shader,"waveSpeed",waveSpeed)
	dxSetShaderValue(shader,"waves",waves)
	engineApplyShaderToWorldTexture(shader,"flag")
end

