boundaries = {
	{ -- Center
		{709,694},
		{-2391,-2407},
		123
	},
	{
		{795,750},
		{-2419,-2381},
		101
	},
	{ -- North, Center
		{718,686},
		{-2309,-2349},
		101
	},
	{ -- North, Left
		{663,622},
		{-2346,-2313},
		101
	},
	{ -- West, Center
		{663,622},
		{-2381,-2416},
		101
	},
	{ -- West, South
		{663,622},
		{-2452,-2486},
		101
	},
	{ -- South, Center
		{718,686},
		{-2449,-2489},
		101
	},
	{ -- Center bridge
		{720,746},
		{-2406,-2394},
		101
	}
}

addEventHandler("onResourceStart",getResourceRootElement(),function()
	t = Towers:new()
	t:setBoundaries(boundaries)
	t:setLevelBoundary(700,-2400,350)
	t:setIncreasedAircraftChance(0.2)
	t:start()
end
)
