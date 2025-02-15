addEventHandler("onResourceStart", resourceRoot, function()
	setAircraftMaxHeight(360)
	
	setWeaponProperty(36, "pro", "weapon_range", 600)
	setWeaponProperty(36, "std", "weapon_range", 600)
	setWeaponProperty(36, "poor", "weapon_range", 600)
	
	setWeaponProperty(36, "pro", "target_range", 550)
	setWeaponProperty(36, "std", "target_range", 550)
	setWeaponProperty(36, "poor", "target_range", 550)
	
	setTimer(function() setWeather(math.random(18)) end, 1500, 1)
	setTimer(function() setWeatherBlended(math.random(18)) end, 300000, 0)
end )