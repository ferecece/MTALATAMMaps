-- Disco Derby script by Ali Digitali --
-- Feel free to copy this script, as long as you don't claim it as your own --

-- script is client side --

-- This script will make a car explode if they come in contact with the party bus --

function TriggerExplosion(theHitElement)
	if getElementType(theHitElement)== "vehicle" and getElementData(theHitElement,"disco") == true then
		triggerServerEvent("triggerBlow",localPlayer,source)
	end
end
addEventHandler("onClientVehicleCollision", getRootElement(),TriggerExplosion)

function loadModels ()
	txd = engineLoadTXD ( "dyn_drugs.txd" )
	engineImportTXD ( txd, 1576 )
	engineImportTXD ( txd, 1577 )
	engineImportTXD ( txd, 1578 )
	engineImportTXD ( txd, 1580 )
	
	
	dff = engineLoadDFF ( "drug_green.dff", 0 )
	engineReplaceModel ( dff, 1578 )
	
	dff = engineLoadDFF ( "drug_orange.dff", 0 )
	engineReplaceModel ( dff, 1576 )
	
	dff = engineLoadDFF ( "drug_yellow.dff", 0 )
	engineReplaceModel ( dff, 1577 )
	
	dff = engineLoadDFF ( "drug_red.dff", 0 )
	engineReplaceModel ( dff, 1580 )
	
	--textures1 = engineLoadTXD("vgncarshade1.txd")
	--textures2 = engineLoadTXD("vgncarshade2.txd")
	--textures3 = engineLoadTXD("vgncarshade3.txd")
	--textures4 = engineLoadTXD("vgncarshade4.txd")
	
	--engineImportTXD(textures1,8838)
	--engineImportTXD(textures1,3458)
	
	texture5 = engineLoadTXD("stolenbuild02.txd")
	engineImportTXD(texture5,4585)
	
	-- Create shader (to scroll the textures)
		local shader, tec = dxCreateShader ( "uv_scroll.fx" )

		if not shader then
			--outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			--outputChatBox( "Using technique " .. tec )
			-- Apply to world texture
			engineApplyShaderToWorldTexture ( shader, "sl_concretewall1" )
			engineApplyShaderToWorldTexture ( shader, "corr_roof1" )

			
		end
end
addEventHandler("onClientResourceStart",resourceRoot,loadModels)

-- addEventHandler( "onClientResourceStart", resourceRoot,
	-- function()

		-- -- Version check
		-- if getVersion ().sortable < "1.1.0" then
			-- --outputChatBox( "Resource is not compatible with this client." )
			-- return
		-- end

		
	-- end
-- )
