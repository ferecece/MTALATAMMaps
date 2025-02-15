-- The motherships position
local motherX = -1830
local motherY = 787
local motherZ = 202

function MarkerHit ( hitPlayer, matchingDimension )
	if hitPlayer == getLocalPlayer() then -- Make sure its the local player that hit the marker
		local x,y,z = getElementPosition ( source ) -- Get the position of the marker

		-- If its the Hydra takeoff part 1
		if x == 306 then
			if y == 1862 then
				createExplosion (x,y,z, 10, true, 2, false) -- Create an explosion at the Hydra
				createExplosion (292.79998779297, 1826.1999511719, 18.60000038147, 11, true, 0, false) -- Create an explosion at the Rhino
			end
		-- If its the Hydra takeoff part 2
		elseif x == 303 then
			if y == 2023 then
				createExplosion (305, 2021, z, 10, true, 2, false) -- Create an explosion at the Hydra
				createExplosion (301, 2025, z, 10, true, 2, false) -- Create another an explosion at the Hydra
				createExplosion (338.29998779297, 2064.3999023438, 18.10000038147, 11, true, 0, false) -- Create an explosion at the Rhino
				createExplosion (340.39999389648, 2057, 18.60000038147, 11, true, 0, false) -- Create an explosion at the other Rhino
				
			end
		-- If its the first UFO section part 1
		elseif x == -663 then
			if y == 2588 then
				createExplosion (-666, 2580, 136, 10, true, 2, false) -- Create an explosion at the Rock
				createExplosion (-676, 2571, 127, 10, true, 2, false) -- Create an explosion at the Rock
				createExplosion (-666, 2581, 126, 10, true, 2, false) -- Create an explosion at the Rock
				createExplosion (-670, 2598, 135, 10, true, 2, false) -- Create an explosion at the Rock
				createExplosion (-671, 2597, 127, 10, true, 2, false) -- Create an explosion at the Rock
				createExplosion (-681, 2605, 127, 10, true, 2, false) -- Create an explosion at the Rock
			end
		-- If its the first UFO section part 2
		elseif x == -808 then
			if y == 2608 then
				createExplosion (x, y, z, 10, true, 3, false) -- Create an explosion at the Hydra
			end
		-- If its the dam section part 1
		elseif x == -861 then
			if y == 2189 then
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-793.79998779297, 2036.5, 60.799999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-728, 2076, 76, 11, true, 0, false) -- Create an explosion at the UFOS
				createExplosion (-730, 2050, 71, 11, true, 0, false) -- Create an explosion at the UFOS
			end
		-- If its the dam section part 2
		elseif x == -782 then
			if y == 2118 then
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-793.79998779297, 2036.5, 60.799999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-728, 2076, 76, 11, true, 0, false) -- Create an explosion at the UFOS
				createExplosion (-730, 2050, 71, 11, true, 0, false) -- Create an explosion at the UFOS
			end
			-- If its the dam section part 3
		elseif x == -696 then
			if y == 2122 then
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-793.79998779297, 2036.5, 60.799999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-799.70001220703, 2052.3999023438, 61.299999237061, 11, true, 0, false) -- Create an explosion at the tanks
				createExplosion (-728, 2076, 76, 11, true, 0, false) -- Create an explosion at the UFOS
				createExplosion (-730, 2050, 71, 11, true, 0, false) -- Create an explosion at the UFOS
				createExplosion (-605.09997558594, 2048.6999511719, 61.299999237061, 11, true, 0, false) -- Create an explosion at the other tanks
				createExplosion (-611.29998779297, 2034.5999755859, 61.299999237061, 11, true, 0, false) -- Create an explosion at the other tanks
			end
				-- If its the dam section part 4
		elseif x == -650 then
			if y == 2123 then
				createExplosion (x, y, z, 10, true, 2, false) -- Create an explosion at the Hydra
			end
			-- If its the dam section part 5
		elseif x == -396 then
			if y == 2227 then
				createExplosion (x+1, y+1, z+1, 10, true, 2, false) -- Create an explosion at the Hydra
				createExplosion (x-1, y-1, z-1, 10, true, 2, false) -- Create an explosion at the Hydra
			end
			-- If its the San Fierro section part 1
		elseif x == -2306 then
			if y == 410 then
				createExplosion (x, y, z, 10, true, 2, false) -- Create an explosion at the Hydra
			end
			-- If its the San Fierro section part 2
		elseif x == -1904 then
			if y == 476 then
				createExplosion (x, y, z, 10, true, 3, false) -- Create an explosion at the Hydra
			end
			-- If its the mothership section part 1
		elseif x == -1819 then
			if y == 825 then
				createExplosion (motherX, motherY, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY, 260, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX + 5, motherY, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX - 5, motherY, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY + 5, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY - 5, 255, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY, 265, 10, true, 6, false) -- Create an explosion at the Mothership
				createExplosion (motherX, motherY, 270, 10, true, 6, false) -- Create an explosion at the Mothership
			end
		end
		
		-- TEMP VECTOR STORAGE
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )


 