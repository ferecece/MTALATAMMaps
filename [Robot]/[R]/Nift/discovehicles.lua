function discoColors()
	for i, discoCar in ipairs( getElementsByType( "vehicle" ) ) do
		local color = {}
		color1r = math.random(0,255)
		color1g = math.random(0,255)
		color1b = math.random(0,255)
		color2r = math.random(0,255)
		color2g = math.random(0,255)
		color2b = math.random(0,255)
		color3r = math.random(0,255)
		color3g = math.random(0,255)
		color3b = math.random(0,255)
		color4r = math.random(0,255)
		color4g = math.random(0,255)
		color4b = math.random(0,255)
		setVehicleColor ( discoCar, color1r, color1g, color1b, color2r, color2g, color2b, color3r, color3g, color3b, color4r, color4g, color4b ) -- setting color to vehicle
	end
end
 
setTimer( discoColors, 500, 0 )