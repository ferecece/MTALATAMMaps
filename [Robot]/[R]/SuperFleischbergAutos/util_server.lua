function getPlayerFromSerial(serial)
	assert(type(serial) == "string" and #serial == 32, "getPlayerFromSerial - invalid serial")
	for i, player in ipairs(getElementsByType("player")) do
		if (getPlayerSerial(player) == serial) then
			return player
		end
	end
	return false
end
