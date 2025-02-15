-- Function that converts time in ms into a string in the format "MM:SS.MS"
function convertToRaceTime(time)
	-- Check if the input time is valid (not nil or 0)
	if time ~= nil and time > 0 then
		-- Calculate minutes, seconds, and milliseconds
		local minutes = math.floor(time / 1000 / 60) -- Convert milliseconds to minutes
		local seconds = math.floor((time / 1000) % 60) -- Get remaining seconds after minutes
		local milliseconds = time % 1000 -- Get the remaining milliseconds

		-- Format minutes: If less than 1, display as an empty string, else append a colon
		local minutesStr = (minutes > 0) and (minutes .. ":") or ""

		-- Format seconds: Add leading zero if less than 10
		local secondsStr = (seconds < 10) and ("0" .. seconds) or seconds

		-- Format milliseconds: Add leading zeros to ensure three digits
		local millisecondsStr = string.format("%03d", milliseconds)

		-- Return the final formatted string
		return minutesStr .. secondsStr .. "." .. millisecondsStr
	else
		return ""
	end
end
