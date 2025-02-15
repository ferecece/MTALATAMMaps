---------
--Start--
---------

local times = 0
addEvent("onRaceStateChanging",true)
addEventHandler("onRaceStateChanging", getRootElement(), function (state,oldstate)
   if (state == "Running" and oldstate == "GridCountdown") then
      times = times + 1
      if (times == 1) then
		triggerClientEvent ("startclientcowstartsound", getRootElement())
      end
   end
end)