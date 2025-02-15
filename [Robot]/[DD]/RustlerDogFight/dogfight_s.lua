addEventHandler("onResourceStart", resourceRoot, function()
	setAircraftMaxHeight(360)
	
	setWeaponProperty(31, "pro", "weapon_range", 300)
	setWeaponProperty(31, "std", "weapon_range", 300)
	setWeaponProperty(31, "poor", "weapon_range", 300)
	
	setWeaponProperty(31, "pro", "target_range", 300)
	setWeaponProperty(31, "std", "target_range", 300)
	setWeaponProperty(31, "poor", "target_range", 300)
	
	setWeaponProperty(31, "pro", "damage", 80)
	setWeaponProperty(31, "std", "damage", 80)
	setWeaponProperty(31, "poor", "damage", 80)
	
	setTimer(function() setWeather(math.random(19)) end, 1500, 1)
	setTimer(function() setWeatherBlended(math.random(19)) end, 300000, 0)
end )