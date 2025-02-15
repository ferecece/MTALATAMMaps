boundaries = {
	{ -- The Center
		{5836.3,5836.3},
		{-1176.9,-1176.9},
		26
	},
	{
		{5836.47,5836.47},
		{-1125.04,-1125.04},
		26
	},
	{
		{5836.73,5836.73},
		{-1072.90,-1072.90},
		26
	},
	{
		{5774.48,5774.48},
		{-1072.78,-1072.78},
		26
	},
	{
		{5774.88,5774.88},
		{-1124.60,-1124.60},
		26
	},
	{ -- South, Center
		{5774.34,5774.34},
		{-1176.53,-1176.53},
		26
	},
	-- ]]
}

addEventHandler("onResourceStart",getResourceRootElement(),function()
	t = Towers:new()
	t:setBoundaries(boundaries)
	t:setLevelBoundary(5806.1,-1125,400)
	t:setIncreasedAircraftChance(0.0)
	t:start()
end
)
