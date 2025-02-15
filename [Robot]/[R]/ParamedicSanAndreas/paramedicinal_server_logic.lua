addEvent("onClientNotifySpectate", true)
addEventHandler("onClientNotifySpectate", root, function(enabled)
	triggerClientEvent(source, g_CLIENT_SPECTATORED_EVENT, source)
end)

addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", root, function(state)
	if state == "GridCountdown" then
		local seed = math.random(1000)
		print("PARAMEDIC: patient seed " .. seed)
		
		addEvent("onPlayerJoin")
		addEventHandler("onPlayerJoin", root, function()
			triggerClientEvent(source, g_SEED_EVENT, resourceRoot, seed)
		end)
		for _, player in ipairs(getElementsByType("player")) do
			triggerClientEvent(player, g_SEED_EVENT, resourceRoot, seed)
		end
	end
end)