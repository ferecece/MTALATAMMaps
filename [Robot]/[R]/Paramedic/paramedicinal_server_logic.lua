addEvent("onClientNotifySpectate", true)
addEventHandler("onClientNotifySpectate", root, function(enabled)
	triggerClientEvent(source, g_CLIENT_SPECTATORED_EVENT, source)
end)