addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	if time > 120000 then
		triggerClientEvent(source, "displayFiredText", source)
	end
	if time < 120000 then
		triggerClientEvent(source, "displayHiredText", source)
	end
end )
