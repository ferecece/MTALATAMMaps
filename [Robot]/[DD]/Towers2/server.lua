boundaries = {
	{ -- Center
		{3723,3757},
		{-1779,-1819},
		141
	},
	{ -- North
		{3723,3757},
		{-1693,-1735},
		141
	},
	{ -- East
		{3838,3801},
		{-1779,-1819},
		141
	},
	{ -- West
		{3678,3643},
		{-1779,-1819},
		141
	},
	{ -- South
		{3723,3757},
		{-1864,-1907},
		141
	}
}

addEventHandler("onResourceStart",getResourceRootElement(),function()
	t = Towers:new()
	t:setBoundaries(boundaries)
	t:setLevelBoundary(3740,-1800,350)
	t:setIncreasedAircraftChance(0.2)
	t:start()
end
)
