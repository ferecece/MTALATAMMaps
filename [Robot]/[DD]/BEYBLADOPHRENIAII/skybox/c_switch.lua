--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchSkyBox", root, true )
--
--	To switch off:
--			triggerEvent( "switchSkyBox", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
-- Auto switch on at start
--------------------------------

addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		outputDebugString('/sSkyBox to switch the effect')
		triggerEvent( "switchSkyBox", resourceRoot, true )
		addCommandHandler( "sSkyBox",
			function()
				triggerEvent( "switchSkyBox", resourceRoot, not sbxEffectEnabled )
			end
		)
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchSkyBox( sbOn )
	outputDebugString( "switchSkyBox: " .. tostring(sbOn) )
	if sbOn then
		startShaderResource()
	else
		stopShaderResource()
	end
end

addEvent( "switchSkyBox", true )
addEventHandler( "switchSkyBox", resourceRoot, switchSkyBox )

--------------------------------
-- onClientResourceStop
-- Stop the resource
--------------------------------
addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)
