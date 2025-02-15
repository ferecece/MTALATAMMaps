--------------------
--      SKC       --
-- Clouds Remover --
--------------------

addEventHandler("onClientResourceStart", resourceRoot,
	function ()

		-- Create shader
		shader, tec = dxCreateShader ( "shader_clouds_remover/texreplace.fx" )

		if not shader then
			outputChatBox ("Could not create shader. Please use debugscript 3")
		else

			engineApplyShaderToWorldTexture (shader, "cloud1")
			engineApplyShaderToWorldTexture (shader, "cloudhigh")
			engineApplyShaderToWorldTexture (shader, "cloudmasked")

		end
	end
)