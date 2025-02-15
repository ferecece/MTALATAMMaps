function blabla ()
	outputChatBox ( "<== Las Wateras Fights ==>", getRootElement(), 255, 255 )
	outputChatBox ( "<== Drive through the blue markers for weapons! ==>", getRootElement(), 255, 255 )
end
addEventHandler ( "onResourceStart", getRootElement(), blabla )

createWater ( 700, 500, 13, 2990, 500, 13, 700, 2990, 13, 2990, 2990, 13 )

setWeather ( 29 )

setCloudsEnabled ( true )

setSkyGradient ( 0,0,0, 0, 125, 255 )

createMarker ( 2161.666748, 1483.062256, 26.241549, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2037.542114, 1503.001953, 19.293812, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2119.038818, 1404.550781, 15.132477, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2290.475830, 1517.061279, 41.820313, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2143.812256, 1631.880737, 19.390625, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2211.998291, 1578.278320, 19.383698, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2218.251221, 1503.807983, 15.843752, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2208.301514, 1443.157837, 25.523003, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2250.226318, 1389.615723, 25.422230, "corona", 3, 0, 0, 255, 255 )
createMarker ( 2117.749512, 1481.640015, 30.141546, "corona", 3, 0, 0, 255, 255 )

function MarkerHit( thePed )
	takeAllWeapons ( thePed )

	setPedDoingGangDriveby ( thePed, true )

	local weapons = { 22,23,24,  25,26,27,  28,29,32 } 
	local randomid = weapons[math.random(1,9)] 
	giveWeapon ( thePed, randomid, 1, true )

	local tehweapon = getPedWeapon( thePed )

	if (getPedWeapon ( thePed ) == 22) then
	setWeaponAmmo ( thePed, tehweapon, 10 )
	end
	if (getPedWeapon ( thePed ) == 23) then
	setWeaponAmmo ( thePed, tehweapon, 10 )
	end
	if (getPedWeapon ( thePed ) == 24) then
	setWeaponAmmo ( thePed, tehweapon, 10 )
	end

	
	if (getPedWeapon ( thePed ) == 25) then
	setWeaponAmmo ( thePed, tehweapon, 5 )
	end
	if (getPedWeapon ( thePed ) == 26) then
	setWeaponAmmo ( thePed, tehweapon, 5 )
	end
	if (getPedWeapon ( thePed ) == 27) then
	setWeaponAmmo ( thePed, tehweapon, 5 )
	end

	
	if (getPedWeapon ( thePed ) == 28) then
	setWeaponAmmo ( thePed, tehweapon, 30 )
	end
	if (getPedWeapon ( thePed ) == 29) then
	setWeaponAmmo ( thePed, tehweapon, 30 )
	end
	if (getPedWeapon ( thePed ) == 32) then
	setWeaponAmmo ( thePed, tehweapon, 30 )
	end
end
addEventHandler( "onMarkerHit", getRootElement(), MarkerHit )