addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging",root,
	function(newState)
		if newState == "PreGridCountdown" then
			local time = get("#time")
			setTimer(setTime,150,1,gettok(time,1,58),gettok(time,2,58))
		end
	end
)