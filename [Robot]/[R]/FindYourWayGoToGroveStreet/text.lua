SHOW_START = true
STARTTEXT = "Find your way to Grove Street\nPress F11 to get an overview of the map"

SHOW_POINTS = false
POINTSTEXT = "0 / 1 000 000"

function text()
	if (SHOW_START) then
		drawBorderedTextScreenRelative(STARTTEXT, 1.9, 0.1, 0.15, 0.9, 0.9, tocolor(255, 255, 255, 255), 3.2, "pricedown", "center", "top", false, true, true, false)
	end

	if (SHOW_POINTS) then
		local thousands = math.floor(CURRENT_POINTS/1000)
		local units = math.fmod(CURRENT_POINTS, 1000)
		local thousandsT = tostring(thousands)
		local unitsT = tostring(units)
		if thousands == 0 then 
			thousandsT = ""
		else
			unitsT = string.format("%03d", units)
		end
		POINTSTEXT = thousandsT .. " " .. unitsT .. " / 1 000 000\n+" .. LATEST_REWARD_BASE
		if (MULTIPLIER > 1) then
			POINTSTEXT = POINTSTEXT .. MULTIPLIERS .. "= + " .. LATEST_REWARD
		end

		
		drawBorderedTextScreenRelative(POINTSTEXT, 1.9, 0.1, 0.05, 0.85, 0.85, tocolor(255, 255, 255, 255), 2, "default", "right", "top", false, true, true, false)
	end
end
addEventHandler ( "onClientRender", root, text ) -- keep the text visible with onClientRender.

function raceStart()
	if (not SHOW_START) then
		return
	end
	SHOW_START = false
	setTimer(scorePoints, SCORE_RATE, 0)
end
addEvent("onRaceHasBegun", true)
addEventHandler("onRaceHasBegun", root, raceStart)