FARES_FOR_FINISH = 50
CITY = 0
COLLECT_ALL_FARES = false
CABBIE_PRICE = 5000
ZEBRA_PRICE = 15000
SULTAN_PRICE = 40000
CRAZY_PRICE = 100000

MAX_Z_VALUE = 12000

-- Destinations limits
MAX_DISTANCE_TAXI_CABBIE = 1000.0
MAX_DISTANCE = 3000.0
MIN_DISTANCE = 250.0

LOCATIONS_COUNT = {34, 27, 45}

introCars = {nil, nil, nil, nil}
taxiLight = {}

taxiSpawns = {
	{ -- Los Santos
		{1752.1, -1701.7, 13.4,   0, 0, 0.000}, -- 1
		{796.10, -1539.6, 13.8,   0, 0, 100.0},
		{624.70, -1569.5, 15.7,   0, 0, 0.000},
		{754.90, -1663.2, 4.20,   0, 0, 0.000},
		{609.30, -1724.3, 14.1,   0, 0, 82.00},
		{526.70, -1397.5, 16.2,   0, 0, 13.90},
		{999.50, -1037.2, 30.6,   0, 0, 90.00},
		{1086.0, -1016.8, 33.8,   0, 0, -2.00},
		{1065.5, -1185.2, 21.0,  10, 0, 0.000},
		{873.40, -1327.4, 13.3,   0, 0, -90.0},
		{1088.1, -1193.7, 17.9,   0, 0,  -180},
		{1084.5, -1193.8, 17.9,   0, 0, 180.0},
		{1091.6, -1193.7, 17.9,   0, 0,  -180},
		{1112.5, -1193.7, 17.9,   0, 0,  -180},
		{1109.1, -1193.7, 17.9,   0, 0,  -180},
		{1105.8, -1193.7, 17.9,   0, 0, 180.0},
		{1116.3, -1193.7, 17.9,   0, 0, 180.0},
		{1088.8, -1217.0, 17.5,   0, 0, 0.000},
		{1092.0, -1217.0, 17.5,   0, 0, 0.000},
		{1095.3, -1217.0, 17.5,   0, 0, 0.000},
		{1098.7, -1217.0, 17.5,   0, 0, 0.000},
		{1102.1, -1217.0, 17.5,   0, 0, 0.000},
		{1105.6, -1217.0, 17.5,   0, 0, 0.000},
		{1109.2, -1217.0, 17.5,   0, 0, 0.000},
		{1112.9, -1217.0, 17.5,   0, 0, 0.000},
		{1215.1, -904.50, 42.6,   0, 0,  -173},
		{1225.0, -930.10, 42.2,   0, 0, 100.0},
		{1409.3, -934.70, 35.1,   0, 0, 82.00},
		{1221.7, -1070.4, 28.9,   0, 0, 8.000},
		{1415.1, -854.90, 47.2, -10, 0, 82.00},
		{1582.1, -1125.3, 23.2,   0, 0, 6.000},
		{1617.2, -1009.6, 23.6,   0, 0,  -178},
		{1613.0, -1009.6, 23.6,   0, 0,  -178},
		{1936.6, -1048.1, 23.7,   0, 0, -98.0},
		{1704.5, -1068.7, 23.6,   0, 0,  -178},
		{1869.3, -1165.8, 23.4,   0, 0, 2.000},
		{1971.6, -1188.3, 25.5,   0, 0, 2.000},
		{2008.3, -1275.4, 23.5,   0, 0, 2.000},
		{1846.1, -1225.4, 17.5,   0, 0, 2.000},
		{2160.5, -1182.7, 23.5,   0, 0, 92.00},
		{2445.5, -1337.3, 23.6,   0, 0,  -178},
		{2227.6, -1159.7, 25.5,   0, 0, 92.00},
		{2227.6, -1169.6, 25.5,   0, 0, 92.00},
		{2340.2, -1408.0, 23.5,   0, 0,  -178},
		{2301.0, -1262.9, 23.6,   0, 0,  -178},
		{2234.6, -1303.3, 23.6,   0, 0, -88.0},
		{2218.3, -1337.1, 23.7,   0, 0, -88.0},
		{2154.0, -1342.9, 23.7,   0, 0, -88.0},
		{2163.0, -1806.1, 13.1,   0, 0, 2.000},
		{2247.4, -1451.7, 23.6,   0, 0, -88.0},
		{2173.9, -1807.0, 13.1,   0, 0, 2.000},
		{2006.7, -1645.1, 13.3,   0, 0, 2.000},
		{1911.2, -1776.3, 13.0,   0, 0, 0.000},
		{1731.2, -1850.6, 13.1,   0, 0, 90.00},
		{1799.9, -1933.2, 13.0,   0, 0, 0.000},
		{1659.9, -1730.4, 13.1,   0, 0, 90.00},
		{1076.9, -1886.2, 13.3,   0, 0, 90.00},
		{1247.0, -2019.6, 59.5,   0, 0, 90.00},
		{991.70, -1809.0, 13.8,   0, 0, 78.00},
		{1150.2, -1567.4, 13.0,   0, 0, 88.00},
		{867.70, -1393.0, 13.0,   0, 0, 88.00},
		{812.40, -1439.6, 13.2,   0, 0, 88.00},
		{1490.9, -1737.7, 13.3,   0, 0, 88.00} -- 63
	},
	{ -- San Fierro
		{-2348.5, -126.2, 35.2,  0, 0,  -180}, -- 1
		{-2352.2, -157.5, 35.0,  0, 0,  0.00},
		{-2423.4, 233.00, 34.9,  0, 0, 180.0},
		{-2415.9, 326.10, 34.8,  0, 0, 150.1},
		{-2612.1, 333.00, 4.00,  0, 0, 130.0},
		{-2675.8, 220.40, 4.00,  0, 0, 90.00},
		{-2744.1, 160.20, 6.80,  0, 0, 90.00},
		{-2820.9, 646.10, 11.7, 15, 0,  0.00},
		{-2717.7, 821.20, 51.1,  0, 0,  -180},
		{-2269.4, 784.70, 49.1,  0, 0, 180.0},
		{-2576.6, 806.00, 49.7,  0, 0, -90.0},
		{-2389.9, 919.50, 45.1,  0, 0, 180.0},
		{-2521.0, 1228.1, 37.3,  0, 0,  -150},
		{-2344.0, 985.70, 50.5,  0, 0, 90.00},
		{-2288.3, 1079.4, 55.4,  0, 0, 90.00},
		{-2571.8, 1148.4, 55.6,  0, 0, 160.0},
		{-2511.9, 1205.3, 37.3,  0, 0, -90.0},
		{-2644.3, 1349.9, 7.00,  0, 0, -90.0},
		{-2475.5, 1372.0, 6.90,  0, 0, -90.0},
		{-2644.3, 1357.2, 7.00,  0, 0, -90.0},
		{-1810.6, 1356.2, 6.90,  0, 0, -96.0},
		{-2694.6, 1215.6, 55.1,  0, 0, -62.0},
		{-1569.4, 1014.7, 6.90,  0, 0, 42.10},
		{-1645.1, 1304.7, 6.90,  0, 0, 134.0},
		{-1714.9, 1191.4, 24.8,  0, 0, 88.00},
		{-1581.6, 652.00, 7.00,  0, 0, 2.000},
		{-1602.9, 1008.1, 6.90,  0, 0,  -160},
		{-1580.7, 817.00, 6.70,  0, 0, -48.0},
		{-1621.6, 660.40, -5.4,  0, 0,  2.00},
		{-1935.4, 585.10, 35.0,  0, 0,  0.00},
		{-1822.2, 581.80, 35.0,  0, 0,  2.00},
		{-1932.4, 585.00, 35.0,  0, 0,  0.00},
		{-1929.4, 585.10, 35.0,  0, 0,  0.00},
		{-2064.1, 569.80, 34.9,  0, 0, 90.00},
		{-2126.5, 650.60, 52.2,  0, 0, 90.00},
		{-2125.2, 733.00, 69.3,  0, 0, 90.00},
		{-2219.9, 733.80, 49.1,  0, 0, 90.00},
		{-2567.8, 626.30, 27.7,  0, 0, 180.0},
		{-2433.9, 740.90, 34.9,  0, 0, 180.0},
		{-2665.1, 583.50, 14.3,  0, 0, 180.0},
		{-2571.1, 236.70, 9.40,  0, 0, 124.0},
		{-2609.0, 506.80, 14.3,  0, 0, 180.0},
		{-2525.9, 348.80, 20.2,  0, 0, 170.0},
		{-2559.3, 133.70, 15.7,  0, 0, 144.1},
		{-2266.0, 141.20, 35.0,  0, 0, 90.00},
		{-2266.0, 145.10, 35.0,  0, 0, 90.00},
		{-1993.6, 135.90, 27.4,  0, 0,  0.00},
		{-2026.2, 133.10, 28.7,  0, 0,  0.00},
		{-1993.6, 142.40, 27.4,  0, 0,  0.00},
		{-1900.4, 253.30, 40.9,  0, 0,  0.00},
		{-1993.6, 149.90, 27.4,  0, 0,  0.00},
		{-1650.8, 442.20, 7.00,  0, 0,  -160},
		{-1957.5, 294.60, 35.3,  0, 0, 120.0},
		{-1947.4, 258.60, 40.9,  0, 0, 40.00},
		{-1488.6, 668.40, 7.00,  0, 0, 40.00},
		{-1530.0, 487.30, 7.00,  0, 0, 40.00},
		{-1744.6, 37.900, 3.20,  0, 0,  0.00},
		{-1656.0, -512.6, 11.2,  0, 0, 158.0},
		{-1765.5, -103.1, 3.80,  0, 0, 180.0},
		{-1851.2, -174.1, 9.20,  0, 0, -90.0},
		{-1812.7, -238.5, 18.1,  0, 0, -90.0},
		{-1760.0, -597.2, 16.1,  0, 0,  0.00},
		{-1413.8, -304.6, 13.8,  0, 0, 42.00},
		{-1418.0, -300.1, 13.8,  0, 0, 46.00},
		{-2140.2, -438.8, 35.2,  0, 0, -2.00},
		{-2164.5, -118.1, 35.0,  0, 0, -2.00},
		{-2085.7, -83.50, 35.0,  0, 0, -2.00} -- 67
	},
	{ -- Las Venturas
		{2541.5, 1195.7, 10.5, 0, 0,   90}, -- 1
		{2817.5, 940.30, 10.6, 0, 0,    0},
		{2636.2, 1108.8, 10.7, 0, 0,   90},
		{2620.9, 1175.7, 10.7, 0, 0,   90},
		{2494.2, 1241.5, 10.7, 0, 0,   90},
		{2425.1, 1338.4, 10.5, 0, 0, -180},
		{2455.2, 1336.4, 10.7, 0, 0,  180},
		{2482.9, 1408.8, 10.7, 0, 0,  180},
		{2155.4, 2774.6, 10.6, 0, 0,   90},
		{2425.0, 1485.9, 10.5, 0, 0,  180},
		{2583.1, 1471.2, 10.5, 0, 0,  -90},
		{2729.7, 1666.0, 6.60, 0, 0,    0},
		{2509.4, 1941.4, 10.5, 0, 0,    0},
		{2529.4, 2077.9, 10.5, 0, 0,    0},
		{2582.2, 2267.6, 10.7, 0, 0,   90},
		{2490.6, 2772.9, 10.6, 0, 0,   90},
		{2166.8, 2710.7, 10.7, 0, 0,   90},
		{1475.5, 2575.4, 10.5, 0, 0, -180},
		{1922.1, 2744.2, 10.5, 0, 0,   90},
		{1502.3, 2257.9, 10.7, 0, 0, -180},
		{1612.6, 2213.6, 10.7, 0, 0,   90},
		{1459.7, 2055.6, 10.5, 0, 0,   90},
		{1384.9, 2017.0, 10.5, 0, 0, -180},
		{1325.2, 1856.6, 10.5, 0, 0,  180},
		{1565.3, 1728.9, 10.5, 0, 0, -180},
		{1593.7, 1839.6, 10.7, 0, 0,  180},
		{1720.0, 1486.8, 10.5, 0, 0,  164},
		{1718.2, 1480.0, 10.5, 0, 0,  164},
		{1695.6, 1306.7, 10.7, 0, 0,  180},
		{2039.4, 943.80, 9.70, 0, 0,  180},
		{1785.5, 1223.0, 6.60, 0, 0,  180},
		{1865.2, 1119.8, 10.5, 0, 0,  180},
		{1906.5, 945.40, 10.7, 0, 0,  180},
		{2286.1, 1389.9, 10.7, 0, 0,    0},
		{2115.1, 929.50, 10.7, 0, 0,  -90},
		{2274.0, 970.70, 10.6, 0, 0,  -90},
		{2460.7, 1011.0, 10.5, 0, 0,  -90},
		{1949.7, 1308.0, 9.00, 0, 0,    0},
		{2210.8, 1285.9, 10.7, 0, 0,    0},
		{2021.9, 1544.5, 10.7, 0, 0,  -90},
		{2178.3, 1676.8, 10.9, 0, 0,    0},
		{2213.4, 1512.8, 10.7, 0, 0,  -90},
		{2033.6, 1903.8, 12.0, 0, 0,    0},
		{2172.5, 1787.7, 10.7, 0, 0,    0},
		{2033.3, 1918.3, 12.0, 0, 0,    0},
		{2388.8, 2136.7, 10.5, 0, 0,  -90},
		{2103.7, 2072.8, 10.7, 0, 0,   90},
		{1912.5, 2159.6, 10.7, 0, 0,   90},
		{1899.5, 2275.0, 10.5, 0, 0,   90},
		{1742.0, 2175.5, 10.6, 0, 0,   90},
		{1724.7, 2286.9, 10.5, 0, 0,  180},
		{2165.9, 2136.4, 10.5, 0, 0,  -90},
		{2311.4, 2448.3, 10.7, 0, 0,  150},
		{2284.9, 2322.7, 10.5, 0, 0,  180},
		{2307.9, 2431.1, -7.6, 0, 0, -180},
		{1827.2, 2488.1, 6.70, 0, 0,  -74},
		{2143.3, 1985.7, 10.5, 0, 0,    0},
		{1777.3, 2142.5, 10.7, 0, 0, -151},
		{1863.7, 1921.3, 7.70, 0, 0,    3},
		{2074.7, 1611.0, 10.5, 0, 0,    1},
		{2419.2, 1116.8, 10.7, 0, 0, -160},
		{2162.7, 1446.2, 10.7, 0, 0,   90},
		{2003.6, 1240.0, 10.7, 0, 0,   90},
		{2408.5, 1375.5, 10.5, 0, 0,   90} -- 64
	}
};
	
pedSounds = {
	{2, 227}, -- 1
	{2, 226},
	{2, 228},
	{2, 232},
	{5, 196},
	{5, 197},
	{14, 182},
	{22, 215},
	{22, 214},
	{22, 213},
	{31, 188},
	{31, 192},
	{31, 201},
	{31, 207},
	{31, 208},
	{32, 202},
	{32, 205},
	{32, 209},
	{51, 168},
	{51, 165},
	{51, 161},
	{71, 207},
	{71, 208},
	{71, 214},
	{70, 213},
	{74, 126},
	{77, 218},
	{77, 222},
	{79, 105},
	{88, 221} -- 30
};

destinationCoords = {
	{ -- Los Santos
		{2468.1455, -1736.1840, 12.3828}, -- Food Place
		{2794.0000, -1828.0000, 10.0000}, -- Stadium
		{1884.1929, -1257.5214, 12.3984}, -- Glen Park
		{2317.4805, -1386.6042, 22.8784}, -- Sculpture Park
		{2237.7595, -1304.1653, 22.8488}, -- Church
		{2221.0874, -1137.3323, 24.6250}, -- Motel
		{2146.7366, -1179.7950, 22.8278}, -- Pic 'n'Go market
		{2075.5579, -1202.7931, 22.7571}, -- Leon Diamonds
		{2320.0000, -1655.0000, 14.0000}, -- Ten Green Bottles
		{2455.0000, -1502.0000, 24.0000}, -- Mama's Cinema
		{2181.0000, -1771.0000, 13.0000}, -- 24 Hour Motel
		{2084.7307, -1800.8602, 12.3828}, -- Well Stacked Pizza Co.
		{2078.0149, -1791.5895, 12.3828}, -- Reece's Barber Shop
		{2081.2869, -1779.4996, 12.3828}, -- Tattoo Shop
		{2418.5422, -2085.1187, 12.2928}, -- Truck Park
		{1742.6893, -1858.6967, 12.4185}, -- Unity Station
		{1668.0000, -2253.0000, 13.0000}, -- Airport
		{1432.1981, -2274.6477, 12.3906}, -- Cool Circular Building at airport
		{1256.0000, -2028.0000, 60.0000}, -- Observatory
		{1532.7894, -1675.4420, 12.3828}, -- Police Station
		{1472.3503, -1729.7062, 12.3828}, -- Pershing Square
		{1855.4191, -1383.2733, 12.3984}, -- Skate Park
		{2025.0000, -1413.0000, 17.0000}, -- County General Hospital
		{1361.2184, -1277.9036, 12.3828}, -- Ammunation
		{1192.0000, -1324.0000, 13.0000}, -- All Saints General Hospital
		{1031.0656, -1329.7043, 12.3861}, -- Donut Shop
		{814.00000, -1330.0000, 13.0000}, -- Market Station
		{667.76370, -1265.6902, 12.4687}, -- Country Club
		{368.19920, -2042.5366, 6.65820}, -- Brown Starfish bar and grill
		{152.58060, -1754.8307, 3.95180}, -- Playa del Seville
		{508.27970, -1358.5979, 14.9532}, -- Pro Lapse Store
		{1199.8457, -933.06580, 41.7332}, -- Burger Shot
		{816.28690, -1630.7621, 12.3906}, -- Burger Shot
		{1311.9703, -1712.2892, 12.3906}  -- Regal Cinema
	},
	{ -- San Fierro
		{-1974.7,  487.0, 28.0}, -- Skyscraper
		{-2044.3,  500.6, 34.0}, -- Skyscraper
		{-2150.0,  250.4, 34.2}, -- Mall
		{-1988.5,  138.2, 26.5}, -- Cranberry Station
		{-2216.4, -297.4, 34.5}, -- Stadium
		{-2726.3, -310.6, 6.00}, -- Country Club
		{-2704.6, -3.500, 3.20}, -- Modern Cathedral
		{-2709.0,  127.6, 3.20}, -- Library
		{-2751.9,  376.8, 3.10}, -- City Hall
		{-2415.1,  330.8, 34.0}, -- Vank Hoff in the Park Hotel
		{-2455.0,  138.9, 34.0}, -- Biffin Bridge Hotel
		{-2499.2, -16.70, 24.6}, -- Central Hashbury
		{-2431.8, -199.2, 34.2}, -- Missionary Hill Viewpoint
		{-1815.2,  598.2, 34.2}, -- Skyscraper
		{-1530.8,  487.6, 6.20}, -- Easter Basin Naval Station
		{-1745.2,  28.10, 2.60}, -- Easter Basin Docks
		{-1414.6, -301.2, 13.1}, -- Airport
		{-2618.5, 1432.7, 6.10}, -- Under Gant Bridge
		{-1904.8,  882.7, 34.0}, -- Downtown Square
		{-2134.8,  919.3, 78.9}, -- Twisty Hill
		{-2361.6,  993.8, 49.7}, -- Burger Shot
		{-2753.8,  780.1, 53.2}, -- Tuff Nut Donuts
		{-1714.8, 1332.5, 6.00}, -- Pier 69
		{-2251.2,  717.8, 48.3}, -- Chinatown Gates
		{-1808.0,  935.9, 23.7}, -- Well Stacked Pizza Co
		{-1969.3, 1115.3, 52.7}, -- Church
		{-2540.7, 1222.4, 36.4}  -- Bridge Walkway
	},
	{ -- Las Venturas
		{2491.378, 2773.608, 9.764}, -- Oil Refinery
		{2899.211, 2435.624, 9.764}, -- Shopping Mall
		{2220.495, 1838.497, 9.764}, -- Ring Master Casino (circus Circus)
		{2246.202, 1896.591, 9.764}, -- The Starfish Casino
		{2127.307, 2355.785, 9.764}, -- The Emerald Isle
		{2289.588, 2415.939, 9.777}, -- Police Station
		{2636.223, 2344.803, 9.764}, -- VRock Casino
		{1439.000, 754.0000, 9.764}, -- Blackfield Chapel
		{1095.618, 1375.292, 9.797}, -- Vegas Stadium
		{1162.076, 1124.440, 9.812}, -- Greenglass College
		{1710.624, 1448.153, 9.664}, -- Vegas Airport
		{2490.384, 2771.702, 9.796}, -- Military Fuel Depot
		{1465.186, 2773.964, 9.687}, -- Golf Clubhouse
		{1436.144, 2670.384, 9.679}, -- Train Station
		{1486.471, 2257.945, 9.812}, -- Baseball Stadium
		{1694.187, 2200.377, 9.820}, -- Steakhouse
		{1744.656, 2055.810, 9.730}, -- Fire Station
		{1840.554, 2169.654, 9.801}, -- Hotel
		{1928.357, 2434.310, 9.813}, -- Souvenier Shop
		{2424.122, 2315.745, 9.679}, -- Art Gallery
		{2431.153, 2375.061, 9.679}, -- Bank
		{2370.298, 2467.924, 9.679}, -- Courthouse
		{2272.042, 2286.755, 9.679}, -- Estate Agents
		{2324.512, 2155.099, 9.679}, -- Freement St. Casino
		{2508.472, 2131.204, 9.812}, -- Strip Club
		{2530.913, 2083.355, 9.679}, -- Ammunation
		{2546.510, 1968.607, 9.812}, -- Drive Thru Pharmacy
		{2530.780, 1821.227, 9.812}, -- Chinese Mall
		{2360.312, 2071.996, 9.679}, -- Burger Shot
		{2035.456, 1912.279, 11.17}, -- Visage Casino
		{2078.413, 2041.116, 9.820}, -- Tourist Information
		{2159.090, 1678.112, 9.695}, -- Caligulas Casino
		{2028.496, 1711.743, 9.679}, -- Treasure Island Casino
		{2076.406, 1519.037, 9.687}, -- Royal Casino
		{2040.251, 1342.890, 9.679}, -- High Roller Casino
		{2230.469, 1284.890, 9.679}, -- Camel's Toe Casino
		{2074.510, 1162.832, 9.687}, -- Come-a-lot Casino
		{2039.256, 1174.172, 9.679}, -- Pink Swan Casino
		{2040.284, 1005.618, 9.664}, -- The Four Dragons Casino
		{1608.521, 1827.752, 9.828}, -- Hospital
		{2483.513, 922.5383, 9.820}, -- Church
		{2544.668, 1016.168, 9.759}, -- Strip Club
		{2491.764, 1533.687, 9.687}, -- Tiki Hotel
		{2828.648, 1292.268, 9.828}, -- Train Station
		{2524.492, 2297.584, 9.679}  -- Sex Shop
	}
};

destinationTexts = {
	{ -- Los Santos
		"Liquor Mart", -- 1
		"The Stadium",
		"Glen Park",
		"Sculpture Park",
		"Church",
		"Jefferson Motel",
		"The Pik 'n' Go market",
		"Leon Diamonds",
		"Ten Green Bottles",
		"Mama's Cinema",
		"A 24 hour motel",
		"The Well Stacked Pizza Co",
		"Reece's Barber Shop",
		"The tattoo shop",
		"The truck park",
		"Unity Station",
		"The Airport",
		"The Airport",
		"The Observatory",
		"The police station",
		"Pershing Square",
		"Skate Park",
		"County General Hospital",
		"Ammu-Nation",
		"All Saints General Hospital",
		"The Donut Shop",
		"Market Station",
		"The Country Club",
		"Brown Starfish bar and grill",
		"Santa Maria Beach",
		"Pro Laps store",
		"Burger Shot",
		"Burger Shot",
		"The Legal Cinema" -- 34
	},
	{ -- San Fierro
		"Downtown skyscraper", -- 1
		"Skyscraper in King's",
		"Mall",
		"Cranberry Station",
		"Stadium",
		"Country Club",
		"Cathedral",
		"Library",
		"City Hall",
		"Vank Hoff in the Park Hotel",
		"Biffin Bridge Hotel",
		"Central Hashbury",
		"Missionary Hill Viewpoint",
		"Downtown Skyscraper",
		"Easter Basin Naval Station",
		"Easter Basin Docks",
		"Airport",
		"Under Gant Bridge",
		"Downtown Square",
		"Top of the twisty path",
		"Burger Shot",
		"Tuff Nut Donuts",
		"Pier 69",
		"Chinatown Gates",
		"Well Stacked Pizza Co",
		"Church",
		"The bridge" -- 27
	},
	{ -- Las Venturas
		"The oil refinery",
		"The shopping mall",
		"Clown's Pocket Casino",
		"The Starfish Casino",
		"The Emerald Isle",
		"Police station",
		"VRock Casino",
		"Blackfield Chapel",
		"Blackfield Stadium",
		"Greenglass College",
		"Las Venturas Airport",
		"Military fuel depot",
		"Golf Clubhouse",
		"Yellow Bell train station",
		"Baseball Stadium",
		"The Steakhouse",
		"Redsands West fire station",
		"Hotel",
		"Souvenier Shop",
		"Art Gallery",
		"Bank",
		"The courthouse",
		"Estate Agents",
		"Freement St. Casino",
		"Topless Girls of Bush County",
		"Ammu-Nation",
		"24/7",
		"Chinese Mall",
		"Burger Shot",
		"Visage Casino",
		"Tourist Information",
		"Caligula's Casino",
		"Pirates in Men's Pants Casino",
		"Royal Casino",
		"High Roller Casino",
		"Camel's Toe Casino",
		"Come-a-lot Casino",
		"Pink Swan Casino",
		"The Four Dragons Casino",
		"Hospital",
		"Church",
		"24Hrs Men's club",
		"Tiki Hotel",
		"Linden Station",
		"Sex Shop"
	}
};

waterRespawns = {
	{2595.4, -2202.6, -1.2}, -- 1 (LS)
	{2567.0, -2202.4, -1.2},
	{2803.2, -2243.2, 2.0},
	{2846.9, -2215.9, 0.9},
	{2902.4, -2138.3, 1.5},
	{2908.6, -2079.2, 0.4},
	{2908.3, -2020.5, 0.9},
	{2907.7, -1951.4, 0.8},
	{2903.1, -1894.1, 1.1},
	{2891.3, -1855.0, 1.8},
	{2895.5, -1639.5, 10.1},
	{2932.4, -1498.1, 10.1},
	{2898.5, -1141.5, 10.3},
	{2911.6, -0852.3, 10.1},
	{2122.5, -2746.9, 3.2},
	{1323.1, -2708.8, 3.7},
	{1284.2, -2389.2, 12.6},
	{1216.8, -2412.9, 9.9},
	{1210.6, -2341.7, 13.3},
	{1246.0, -2332.1, 13.1},
	{1065.0, -2361.7, 11.9},
	{0836.6, -2060.2, 11.9},
	{0970.4, -2089.9, 1.2},
	{0976.3, -2015.6, 1.2},
	{0979.1, -1946.7, 3.2},
	{0954.7, -1891.2, 3.1},
	{0907.8, -1885.4, 3.0},
	{0807.4, -1883.3, 2.1},
	{0685.4, -1906.8, 1.9},
	{0594.0, -1902.9, 2.0},
	{0461.2, -1881.8, 1.8},
	{0305.9, -1883.6, 1.1},
	{0209.3, -1879.1, 1.0},
	{0125.3, -1756.0, 5.2},
	{0098.7, -1674.4, 9.6},
	{0095.5, -1572.4, 8.5},
	{0724.3, -1586.5, 13.3},
	{0722.9, -1814.2, 11.5},
	{0745.0, -1638.2, 5.6},
	{0757.7, -1457.7, 11.4},
	{1921.6, -1199.8, 19.1},
	{2018.4, -1202.9, 19.4},
	{1970.0, -1202.1, 24.6},
	{-951.0, -228.50, 37.9}, -- SF
	{-964.0, -302.90, 35.5},
	{-999.8, -423.60001, 35.3},
	{-1104.7, -489.70001, 31.8},
	{-1166.8, -604.29999, 36.7},
	{-1273.5, -747.59998, 65.7},
	{-1518.2, -818.09998, 57.3},
	{-1751, -695, 25.7},
	{-1756.1, -637.70001, 17.3},
	{-1730.1, -616, 13.2},
	{-1622.5, -688, 13.2},
	{-1506.4, -691.90002, 13.2},
	{-1377.3, -692.29999, 13.2},
	{-1237.8, -690.5, 13.2},
	{-1231.8, -557.90002, 13.2},
	{-1130, -408.79999, 13.2},
	{-1133.3, -271.89999, 13.2},
	{-1089.8, -219.5, 13.2},
	{-1111.7, -159.89999, 13.2},
	{-1167.5, -79.8, 13.2},
	{-1166.6, 34.4, 13.2},
	{-1240.7, 110.8, 13.2},
	{-1196.1, 176.3, 13.2},
	{-1212.2, 257.10001, 13.2},
	{-1012.4, 450.89999, 13.6},
	{-1042.7, 482.10001, 13.6},
	{-1173.8, 350.60001, 13.6},
	{-1424.1, 99.9, 13.6},
	{-1701.2, -178.89999, 13.6},
	{-1728.6, -317.89999, 13.6},
	{-1731.3, -511.20001, 13.2},
	{-1756.6, -577.09998, 15.4},
	{-1786, -538.70001, 14.2},
	{-1781.9, -469.29999, 13.9},
	{-1786.6, -354.10001, 17.9},
	{-1782.8, -183.60001, 11.1},
	{-1757.9, -183.39999, 2.6},
	{-1704.1, -133.60001, 2.6},
	{-1625.2, -55.5, 2.6},
	{-1659.8, -15.7, 2.6},
	{-1653.8, 8.2, 2.6},
	{-1517.2, 145.89999, 2.6},
	{-1572.5, 129.8, 2.6},
	{-1612.6, 161.10001, 2.6},
	{-1697.1, 103.2, 2.6},
	{-1719, 131.2, 2.6},
	{-1722.1, 214.60001, 2.6},
	{-1747.7, 217.10001, 2.6},
	{-1801.7, 240.60001, 14},
	{-1757.9, 294.79999, 6.4},
	{-1692.4, 264.20001, 6.2},
	{-1462.2, 265.29999, 6.2},
	{-1345.3, 299.29999, 12.9},
	{-1227.8, 453.10001, 6.2},
	{-1498.2, 475.39999, 6.2},
	{-1521.7, 500.39999, 6.2},
	{-1523.5, 565.09998, 6.2},
	{-1490.3, 715.09998, 6.2},
	{-1487.2, 1010.3, 6.2},
	{-1491.9, 1077.7, 6.2},
	{-1545.2, 1272.7, 6.2},
	{-1731.1, 1460.8, 6.2},
	{-1919.9, 1385.3, 6.2},
	{-2108, 1334, 6.1},
	{-2202.7, 1332, 6.1},
	{-2327.2, 1369.2, 6.1},
	{-2490.3, 1377.2, 6.1},
	{-2617.8999, 1433.8, 6.2},
	{-2697.6001, 1477.2, 6.2},
	{-2705.3999, 1415.9, 6.1},
	{-2715.7, 1316.7, 6.1},
	{-2780.3, 1309.9, 6.5},
	{-2884.5, 1235.7, 6.1},
	{-2946.8, 1162.3, 5.3},
	{-2915.7, 937.79999, 7.1},
	{-2935.6001, 745.40002, 5.2},
	{-2832.7, 533.29999, 4.1},
	{-2960.5, 471, 4},
	{-2952.7, 418.60001, 2.2},
	{-2910.7, 277, 1.5},
	{-2911.1001, -5.9, 2.3},
	{-2918.8999, -431.39999, 7.1},
	{-2927.8999, -620.20001, 1.4},
	{-2957.3999, -803.59998, 3},
	{-2901.8999, -884.09998, 3.3},
	{-2879.8, -979.5, 8.5},
	{-2786.3999, -904.79999, 16.9},
	{-2498.8999, -709.79999, 138.39999},
	{-2221.3, -926.5, 44.3},
	{-2110.3, -1093, 29.2},
	{-1899.6, -1378.9, 39},
	{-2024.6, -859.79999, 31.2},
	{-2482.3, -284.60001, 39.6},
	{-2770.6001, -498.20001, 6.2},
	{-2676.5, -453.10001, 28},
	{2767.3999, 617.5, 7.4}, -- LV
	{2649, 606.29999, 7.9},
	{2537.3, 580.09998, 8.9},
	{2360, 530.09998, 0.8},
	{2408.1001, 558.09998, 7.1},
	{2294, 526.79999, 0.8},
	{2211.2, 566.70001, 9.1},
	{2050.8999, 582.90002, 9.9},
	{1937.4, 573.20001, 9.9},
	{1795.3, 593.90002, 9.9},
	{1696.3, 600.5, 11},
	{1629.4, 582.29999, 0.8},
	{1567.6, 628.20001, 9.9},
	{1433.4, 651, 9.7},
	{1289.7, 665.29999, 8.7},
	{1126.5, 679.79999, 8.9},
	{984.70001, 706.40002, 11.1},
	{880, 691.70001, 10.6},
	{785, 645.09998, 9.1},
	{568.90002, 651.20001, 3.6},
	{424.79999, 612.20001, 18},
	{828.20001, 2906.6001, 2.1},
	{1089.9, 2906.1001, 40},
	{1227.8, 2935.2, 26.8},
	{1535.8, 2979.6001, 17.7},
	{1875.8, 2957.8999, 38.3},
	{2106.8, 2965.6001, 29.5},
	{2295.1001, 2959.8999, 27.9},
	{2547.1001, 2973, 30.5},
	{2767, 2942.3, 26.9},
	{2897.3999, 2919.8999, 31.3},
	{2950.2, 2755.3, 35},
	{2971.3, 2607.1001, 28.7},
	{2973.5, 2446, 31.9},
	{2967.5, 2286.8, 23.6},
	{2965.8999, 1881.8, 16.5},
	{2965, 1645, 30.4},
	{2958.3, 1241.4, 42.2},
	{2956.3999, 971.90002, 30.2},
	{2927.5, 782.70001, 31.3},
	{2842.3, 645.5, 31.2},
	{2096.5, 1257.4, 9.9},
	{2106.1001, 1318.9, 9.9},
	{2141.5, 1176.7, 9.9},
	{2112, 1107, 9.9},
	{1909.7, 1514.4, 13.1},
	{2016.2, 1508.6, 9.9},
	{1966.6, 1460.9, 9.9},
	{1837.6, 1516.2, 9.9},
	{1862.9, 1579.8, 9.9},
	{2024.7, 1560, 9.9},
	{2003.7, 1543.8, 12.6},
	{2022.9, 1712.4, 9.7},
	{1977, 1713.1, 9.7},
	{1894.4, 1703.4, 9.9},
	{1886.9, 1675.5, 9.7},
	{2118.2, 1895.7, 9.7},
	{2117.6001, 1948.2, 9.7},
	{2093.2, 1966.7, 9.9},
	{1766.1, 2765.3999, 9.9},
	{2551.3999, 1596, 9.9},
	{2553.8999, 1542.3, 9.9},
	{2483.8, 1554.4, 9.7},
	{1929.9, 1562, 9.9} -- 202
};

-- Vars
intro = 0 
playerFares = 0
playersTimer = 0
moneyEarned = 0
tip = 0
rowBonus = 0
fareMoney = 0
taxiHealth = 1000.0
tipHealth = 1000.0
prevPosition = {0.0, 0.0, 0.0}
deadPosition = {-4500.0, 5000.0, 0.0, 0.0, 0.0, 0.0}
weirdPool = nil
taxiHandling = nil -- stopping feature
playersCheck = 1

-- Markers and blips
fareMarkerID = 0
currentFareMarker = nil
currentFareMarkerBlip = nil
paynsprayBlips = {}

-- States
introHappened = false
onMission = false
missionStarted = false
tipEnabled = false
tipWasEnabled = false
skipAfterCarIsFixed = false
playerState = "not ready"
raceFinished = false
alreadyAdvertised = false
carAdvertised = 0
carUnlocked = 0 -- 1: Cabbie
				-- 2: Zebra Cab
				-- 3: Sultan
				-- 4: Crazy Taxi

-- Timers
updateTimer = nil
tipTimer = nil
textTimer = nil
oneSecondTimer = nil
resetCarTimer = nil
triggerIntroTimer = nil
antiBtimer = nil
controlTimer = nil

-- Intro timers
introPosTimer = nil
introTextTimer1 = nil
introTextTimer2 = nil

-- Collect All Fares
faresTable = {}
-- 1000 Fares
oldCity = "cock"

-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- GUI 
	offsets = {0.8, 0.92} 
	messageSize = 3
	introTextSize = 1.2
	
	-- Info for start a mission
	b_offsets = {0.012, 0.163, 0.165, 0.07} -- X-left, Y-top, width, height for a box
	t_offsets = {0.014, 0.168, 0.200, 2.3} -- X-left, Y1, Y2, textsize
	
 -- 4:3 and others screens
else 
	-- GUI
	offsets = {0.72, 0.9}
	messageSize = 2
	introTextSize = 0.8
	
	-- Info for start a mission
	b_offsets = {0.020, 0.190, 0.23, 0.07} -- X-left, Y-top, width, height for a box
	t_offsets = {0.022, 0.195, 0.225, 2} -- X-left, Y1, Y2, textsize
end 					  

textMode = 0 -- 1:  Destination
			 -- 2:  Your car is trashed
			 -- 3:  You're out of time!
			 -- 4:  Taxi mission over
			 -- 5:  There are no fares nearby, keep looking
			 -- 6:  Taxi Mission Finished
			 -- 7:  'Taxi Driver'
			 -- 8:  reserved
			 -- 9:  reserved
introText = 0
fareCompleteText = false
			 
function resetCar()
	local taxi = getPedOccupiedVehicle(localPlayer)
	if taxi then 
		if deadPosition[1] ~= -4500.0 and deadPosition[2] ~= 5000.0 then
			-- Restore taxi's position
			setElementPosition(taxi, deadPosition[1], deadPosition[2], deadPosition[3])
			setElementRotation(taxi, 0.0, 0.0, deadPosition[6])
			
			-- Water detection
			if isElementInWater(taxi) or isElementWithinColShape(localPlayer, weirdPool) or deadPosition[1] > 2960.0 then
				outputDebugString("water spawn detected")
				-- Find closed respawn location near water
				local l_a, l_d = 1000000.0
				local closest_index = 1
				for w = 1, 202 do
					l_d = getDistanceBetweenPoints3D(waterRespawns[w][1], waterRespawns[w][2], waterRespawns[w][3], deadPosition[1], deadPosition[2], deadPosition[3])
					if l_d < l_a then 
						l_a = l_d
						closest_index = w
					end
				end
				setElementPosition(taxi, waterRespawns[closest_index][1], waterRespawns[closest_index][2], waterRespawns[closest_index][3]+1.5)
			end
		end
		
		-- Restore taxi's health
		if isTimer(resetCarTimer) then killTimer(resetCarTimer) end
		resetCarTimer = setTimer(function() setElementHealth(taxi, taxiHealth) end, 2500, 1)
	end
	
	-- upd cps
	if getElementData(localPlayer, "race.checkpoint") ~= nil and getElementData(localPlayer, "race.checkpoint") ~= false then
		if playersCheck > getElementData(localPlayer, "race.checkpoint") and not isTimer(antiBtimer) and getElementData(source, "state") ~= "spectating" then 
			local difference = playersCheck - getElementData(localPlayer, "race.checkpoint")
			antiBtimer = setTimer(triggerRaceCheckpoint, 2500, 1, difference)
		end
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	-- Load cars
	engineImportTXD(engineLoadTXD("models/savanna.txd"), 567)
	engineReplaceModel(engineLoadDFF("models/savanna.dff"), 567)
	
	engineImportTXD(engineLoadTXD("models/sultan.txd"), 560)
	engineReplaceModel(engineLoadDFF("models/sultan.dff"), 560)
	
	engineImportTXD(engineLoadTXD("models/zebra.txd"), 474)
	engineReplaceModel(engineLoadDFF("models/zebra.dff"), 474)
	
	-- Load textures
	engineImportTXD(engineLoadTXD("models/melrose08_lawn.txd"), 5733)
	engineImportTXD(engineLoadTXD("models/melrosetr_lawn.txd"), 5789)
	engineImportTXD(engineLoadTXD("models/cj_base5.txd"), 2691)
	
	setElementData(localPlayer, "Money", 0, true)
	setElementData(localPlayer, "Fares", 0, true)
	setElementData(localPlayer, "Car", "None", true)
	setElementData(localPlayer, "Destination", "Off duty", true)
	
	if not isTimer(updateTimer) then updateTimer = setTimer(updateStuff, 10, 0) end

	onMission = false
	missionStarted = false
	weirdPool = createColSphere(1766.4, 2824.8999, 8.5, 25.0)
end )

addEvent("postVoteStuff", true)
addEventHandler("postVoteStuff", getRootElement(), function(serverFares, serverCity)
	FARES_FOR_FINISH = serverFares
	CITY = serverCity
	
	if CITY == 0 then CITY = math.random(3) end
	
	-- All Fares% Mode
	if FARES_FOR_FINISH ~= 50 and FARES_FOR_FINISH ~= 25 and FARES_FOR_FINISH ~= 1000 then
		COLLECT_ALL_FARES = true
		setElementData(localPlayer, "Car", "Zebra Cab")
		carAdvertised = 2 
		
		-- Initialize Table
		for i = 1, LOCATIONS_COUNT[CITY] do
			table.insert(faresTable, i)
		end
	end
	
	-- Prices for short version
	if FARES_FOR_FINISH == 25 then 
		CABBIE_PRICE = 2500
		ZEBRA_PRICE = 7500
		SULTAN_PRICE = 25000
		CRAZY_PRICE = 42000
		
	-- Prices for full version
	elseif FARES_FOR_FINISH == 50 then
		CABBIE_PRICE = 5000
		ZEBRA_PRICE = 15000
		SULTAN_PRICE = 40000
		CRAZY_PRICE = 100000
		
	-- All Fares mode	
	elseif COLLECT_ALL_FARES then
		SULTAN_PRICE = 20000
		CRAZY_PRICE = 50000
	
	-- 1000 fares challenge
	elseif FARES_FOR_FINISH == 1000 then
		CABBIE_PRICE = 5000
		ZEBRA_PRICE = 150000
		SULTAN_PRICE = 400000
		CRAZY_PRICE = 1000000
	end
	
	-- Select random spawn location in current city
	math.randomseed(getTickCount())
	local s = 0
	if CITY == 1 then s = math.random(63) end
	if CITY == 2 then s = math.random(67) end
	if CITY == 3 then s = math.random(64) end
	
	-- Spawn vehicle
	setTimer(function() 
		setElementVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
		setElementPosition(getPedOccupiedVehicle(localPlayer), taxiSpawns[CITY][s][1], taxiSpawns[CITY][s][2], taxiSpawns[CITY][s][3])
		setElementRotation(getPedOccupiedVehicle(localPlayer), taxiSpawns[CITY][s][4], taxiSpawns[CITY][s][5], taxiSpawns[CITY][s][6])
		
		-- Spectating fixes 
		deadPosition[1] = taxiSpawns[CITY][s][1]
		deadPosition[2] = taxiSpawns[CITY][s][2]
		deadPosition[3] = taxiSpawns[CITY][s][3]
		
		deadPosition[4] = taxiSpawns[CITY][s][4]
		deadPosition[5] = taxiSpawns[CITY][s][5]
		deadPosition[6] = taxiSpawns[CITY][s][6]
	end, 1000, 1)
	
	-- Message and fade in
	setTimer(function() fadeCamera(true) end, 2000, 1)
	if COLLECT_ALL_FARES then outputChatBox("#00CBFFSunnyside Taxis: You need to do #FF0048" ..FARES_FOR_FINISH.. " #00CBFFfares to finish the #FF0048'Collecting All Fares' #00CBFFrace!", 0, 246, 255, true)
	else outputChatBox("#00CBFFSunnyside Taxis: You need to do #FF0048" ..FARES_FOR_FINISH.. " #00CBFFfares to finish the race!", 0, 246, 255, true) end
end )

function triggerRaceCheckpoint(amount)
	if not getPedOccupiedVehicle(localPlayer) then return end
	playerVehicle = getPedOccupiedVehicle(localPlayer)
	
	local i = 0
	while i ~= amount do
		local posX, posY, posZ = getElementPosition(playerVehicle)
		local velX, velY, velZ = getElementVelocity(playerVehicle)
		local trnX, trnY, trnZ = getElementAngularVelocity(playerVehicle)
		
		-- trigger the actual "race" checkpoint
		setElementPosition(playerVehicle, -4700+getElementData(localPlayer, "race.checkpoint")*100, 5000, 9990)

		-- return original position and velocity of player's vehicleHealth
		setElementPosition(playerVehicle, posX, posY, posZ)
		setElementVelocity(playerVehicle, velX, velY, velZ)
		setElementAngularVelocity(playerVehicle, trnX, trnY, trnZ)
	
		i = i + 1
	end
end

function storeTaxiData()
	if getPedOccupiedVehicle(localPlayer) then 
		-- Save taxi's health
		taxiHealth = getElementHealth(getPedOccupiedVehicle(localPlayer))
		if taxiHealth < 251 then taxiHealth = 251 end
		
		-- Save taxi's position
		local pX, pY, pZ = getElementPosition(localPlayer)
		if pX ~= deadPosition[1] and pY ~= deadPosition[2] and pZ ~= deadPosition[3] then -- spec fixes
			deadPosition[1], deadPosition[2], deadPosition[3] = getElementPosition(localPlayer)
			deadPosition[4], deadPosition[5], deadPosition[6] = getElementRotation(getPedOccupiedVehicle(localPlayer))
			deadPosition[3] = getGroundPosition(deadPosition[1], deadPosition[2], deadPosition[3]) + 1.5
		end
	end
	
	-- Fail the mission
	onMission = false
end
addEventHandler("onClientPlayerWasted", getLocalPlayer(), storeTaxiData)

function introPos()
	if intro == 1 then -- show company Building
		introText = 1
		introTextTimer1 = setTimer(function() introText = 2 end, 10000, 1)
		introTextTimer2 = setTimer(function() introText = 3 end, 20000, 1)
		
		intro = 2
		introPosTimer = setTimer(introPos, 20000, 1)
	elseif intro == 2 then -- show cars
		if isElement(introCars[1]) then
			destroyElement(introCars[1])
			destroyElement(introCars[2])
			destroyElement(introCars[3])
			destroyElement(introCars[4])
		end
		
		-- reCreate Cars
		introCars[1] = createVehicle(438, 1105.7, -1234.9, 16.0, 0.0, 0.0, 50.00) -- Cabbie
		introCars[2] = createVehicle(474, 1102.9, -1237.4, 16.0, 0.0, 0.0, 35.75) -- Zebra Cab
		introCars[3] = createVehicle(560, 1099.5, -1239.3, 15.6, 0.0, 0.0, 18.00) -- Sultan
		introCars[4] = createVehicle(567, 1095.2, -1240.0, 15.8, 0.0, 0.0, -2.00) -- Crazy Taxi
		
		setVehicleColor(introCars[1], 215, 142, 16,  165, 138, 65)  -- color #6
		setVehicleColor(introCars[2], 255, 255, 255, 255, 255, 255) -- white
		setVehicleColor(introCars[3], 255, 255, 255, 255, 255, 255) -- white
		setVehicleColor(introCars[4], 215, 142, 16,  165, 138, 65)  -- color #6
		
		intro = 0
		introPosTimer = setTimer(introPos, 9000, 1)
	elseif intro == 0 then
		introText = 0
		introHappened = true
		fadeCamera(false)
		
		destroyElement(introCars[1])
		destroyElement(introCars[2])
		destroyElement(introCars[3])
		destroyElement(introCars[4])
		
		if isTimer(introPosTimer) then killTimer(introPosTimer) end
		if isTimer(introTextTimer1) then killTimer(introTextTimer1) end
		if isTimer(introTextTimer2) then killTimer(introTextTimer2) end
		
		toggleControl("accelerate", true)
		toggleControl("brake_reverse", true)
		
		setTimer(function() setCameraTarget(localPlayer) end, 1000, 1) -- Reset Camera
		setPlayerHudComponentVisible("radar", true)
		
		triggerServerEvent("isRaceStarted", getLocalPlayer())
	end
end

function triggerIntro()
	local x, y, z = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" then return end
	
	intro = 1
	introHappened = false
	
	if isTimer(introPosTimer) then killTimer(introPosTimer) end
	if isTimer(introTextTimer1) then killTimer(introTextTimer1) end
	if isTimer(introTextTimer2) then killTimer(introTextTimer2) end
	
	introPos()
end

function randomizeNewLocation()
	-- Function randomizes new location for current gamemode and 
	-- puts choosen fare localtion in fareMarkerID var.
	
	-- Randomize destination that not the same and further 200 meters
	local fX, fY, fZ = getElementPosition(getPedOccupiedVehicle(localPlayer))
	
	if COLLECT_ALL_FARES then -- All Fares%
		-- Selecting closest fare location
		local closestDistance = 50000
		local selectedFare = nil
		
		for i = 1, #faresTable do
			local currentDistanceCabToLocation = getDistanceBetweenPoints3D(fX, fY, fZ, destinationCoords[CITY][faresTable[i]][1], destinationCoords[CITY][faresTable[i]][2], destinationCoords[CITY][faresTable[i]][3])
			if currentDistanceCabToLocation < closestDistance then
				selectedFare = faresTable[i]
				closestDistance = currentDistanceCabToLocation
			end
		end
		fareMarkerID = selectedFare
	else -- Normal modes
		-- Choose max distance for early vehicles
		local model = getElementData(localPlayer, "Car")
		if model == "Taxi" or model == "Cabbie" then maxD = MAX_DISTANCE_TAXI_CABBIE
		else maxD = MAX_DISTANCE end
			
		repeat
			repeat 
				i = math.randomDiff(1, LOCATIONS_COUNT[CITY]) 
			until i ~= fareMarkerID or fareMarkerID == 0
			j = i
			d = getDistanceBetweenPoints3D(fX, fY, fZ, destinationCoords[CITY][j][1], destinationCoords[CITY][j][2], destinationCoords[CITY][j][3])
		until d > MIN_DISTANCE and d < maxD
		fareMarkerID = j
	end
end

function updateStuff()
	-- Player State Checks
	local newPlayerState = getElementData(localPlayer, "state")
	if isLocalPlayerSpectating() then newPlayerState = "spectating" end
	
	if newPlayerState ~= playerState then -- Player race state changed
		if playerState == "dead" and newPlayerState == "alive" then
			resetCar()
			if not introHappened then -- If player died in cutscene
				triggerIntro()
			end
		elseif playerState == "alive" and isLocalPlayerSpectating() then
			playerState = "spectating"
			unbindKey("b", "down", storeTaxiData)
		elseif playerState == "spectating" and newPlayerState == "alive" and not isLocalPlayerSpectating() then
			resetCar()
			bindKey("b", "down", storeTaxiData)
		end
		playerState = newPlayerState
		if isLocalPlayerSpectating() then playerState = "spectating" end
	end
	
	-- Spectate Check
	local x, y, z = getElementPosition(localPlayer)
	local taxi = getPedOccupiedVehicle(localPlayer)
	if z > MAX_Z_VALUE or getElementData(localPlayer, "state") == "spectating" or not taxi then 
		onMission = false
		missionStarted = false
		skipAfterCarIsFixed = false
		
		if isElement(currentFareMarker) then
			destroyElement(currentFareMarker)
			destroyElement(currentFareMarkerBlip)
		end	
		return 
	end
	
	if getElementData(localPlayer, "Car") == "None" then
		-- First spawn
		setElementData(localPlayer, "Car", "Taxi")
		
		local randomMoney = math.randomDiff(200, 600) -- money fixes
		setElementData(localPlayer, "Money", randomMoney)
		
		if isTimer(triggerIntroTimer) then killTimer(triggerIntroTimer) end
		triggerIntroTimer = setTimer(triggerIntro, 8000, 1)
		setPlayerHudComponentVisible("radar", false)
		
		paynsprayBlips[1] = createBlip(2064.40, -1831.6, 0, 63)
		paynsprayBlips[2] = createBlip(1024.90, -1023.9, 0, 63)
		paynsprayBlips[3] = createBlip(487.210, -1740.9, 0, 63)
		paynsprayBlips[4] = createBlip(-1904.5,   277.7, 0, 63)
		paynsprayBlips[5] = createBlip(-2425.5,  1028.1, 0, 63)
		paynsprayBlips[6] = createBlip(2393.80,  1483.4, 0, 63)
		paynsprayBlips[7] = createBlip(1968.50,  2162.5, 0, 63)
		
		for b = 1, 7 do
			setBlipVisibleDistance(paynsprayBlips[b], 0.0)
		end
	end
	
	if not introHappened then 
		setElementHealth(taxi, 1000.0)
		toggleControl("accelerate", false)
		toggleControl("brake_reverse", false)
		return
	end
	
	if getElementHealth(taxi) < 400.0 then
		if onMission then
			textMode = 2 -- Your car is trashed
			skipAfterCarIsFixed = false
			
			if CITY == 1 then
				setBlipVisibleDistance(paynsprayBlips[1], 16000.0)
				setBlipVisibleDistance(paynsprayBlips[2], 16000.0)
				setBlipVisibleDistance(paynsprayBlips[3], 16000.0)
			elseif CITY == 2 then
				setBlipVisibleDistance(paynsprayBlips[4], 16000.0)
				setBlipVisibleDistance(paynsprayBlips[5], 16000.0)
			elseif CITY == 3 then
				setBlipVisibleDistance(paynsprayBlips[6], 16000.0)
				setBlipVisibleDistance(paynsprayBlips[7], 16000.0)
			end
		end
	elseif getElementHealth(taxi) > 400.0 then
		if textMode == 2 then -- car was trashed
			textMode = 0 -- disable trashed text 
			
			if onMission then
				-- if Fare marker already hitted and its was a actual marker
				if not isElement(currentFareMarker) and fareMarkerID ~= 0 then 
					skipAfterCarIsFixed = true -- randomize new location
				end
			end
		end 
		
		for b = 1, 7 do
			setBlipVisibleDistance(paynsprayBlips[b], 0.0)
		end
	end
	
	-- City change detector for 1000 fares
	if FARES_FOR_FINISH == 1000 then
		local x, y, z = getElementPosition(taxi)
		local newCity = getZoneName(x, y, z, true)
		
		if newCity ~= oldCity and (newCity == "Los Santos" or newCity == "San Fierro" or newCity == "Las Venturas") then
			-- city has changed
			oldCity = newCity
			
			-- Select city
			if oldCity == "Los Santos" then CITY = 1 
			elseif oldCity == "San Fierro" then CITY = 2
			elseif oldCity == "Las Venturas" then CITY = 3 end
			
			-- make new fare
			if onMission then
				-- Destroying old destination marker
				destroyElement(currentFareMarker)
				destroyElement(currentFareMarkerBlip)
				
				-- Max distance for fares (closer fares for slow rides)
				local model = getElementData(localPlayer, "Car")
				if model == "Taxi" or model == "Cabbie" then maxD = MAX_DISTANCE_TAXI_CABBIE
				else maxD = MAX_DISTANCE end
				
				-- Get new location
				randomizeNewLocation()
				
				-- Setup tips based of distance to the location
				local x, y, z = getElementPosition(taxi)
				local distance = getDistanceBetweenPoints3D(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], x, y, z)
				setupTips(distance)

				-- Marker and blips stuff
				currentFareMarker = createMarker(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], "cylinder", 4.0, 255, 0, 0, 200)
				currentFareMarkerBlip = createBlip(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], 0, 2, 204, 171, 92, 255)
				
				setElementData(localPlayer, "Destination", destinationTexts[CITY][fareMarkerID], true)
				
				-- Text Stuff
				if isTimer(textTimer) then killTimer(textTimer) end
				setTimer(function() textMode = 1 end, 3000, 1) -- Change text to fare text
				textTimer = setTimer(function() textMode = 0 end, 6500, 1) -- Disable text message
				
				-- Position for calculating earnings
				prevPosition[1], prevPosition[2], prevPosition[3] = getElementPosition(taxi)
			end
		end
	end
	
	if onMission then
		if missionStarted then 
			if not skipAfterCarIsFixed then
				-- Hit over or under marker fix
				local x, y, z = getElementPosition(taxi)
				if not isElement(currentFareMarker) then return end
				if not isElementWithinMarker(taxi, currentFareMarker) then return end
				if math.abs(z-destinationCoords[CITY][fareMarkerID][3]) > 2 then return end
				
				-- Destroying old destination marker
				destroyElement(currentFareMarker)
				destroyElement(currentFareMarkerBlip)
				
				-- All Fares%
				if COLLECT_ALL_FARES then 
					for i = 1, #faresTable do
						if faresTable[i] == fareMarkerID then
							table.remove(faresTable, i)
							break
						end
					end
				end
				
				-- CP manipulations
				if FARES_FOR_FINISH == 25 then 
					setTimer(triggerRaceCheckpoint, 200, 1, 2)
					playersCheck = playersCheck + 2
				elseif FARES_FOR_FINISH < 100 and FARES_FOR_FINISH > 25 then
					setTimer(triggerRaceCheckpoint, 200, 1, 1)
					playersCheck = playersCheck + 1
				elseif FARES_FOR_FINISH == 1000 then
					if (tonumber(getElementData(localPlayer, "Fares"))+1) % 20 == 0 and tonumber(getElementData(localPlayer, "Fares")) > 0 then 
						setTimer(triggerRaceCheckpoint, 200, 1, 1)
						playersCheck = playersCheck + 1
					end
				end
				
				-- Stop taxi
				if not COLLECT_ALL_FARES then
					local x, y, z = getElementVelocity(taxi)
					setElementVelocity(taxi, x*0.1, y*0.1, z*0.1)
					
					toggleControl("brake_reverse", false)
					toggleControl("accelerate", false)
					toggleControl("vehicle_left", false)
					toggleControl("vehicle_right", false)
					
					if isTimer(controlTimer) then killTimer(controlTimer) end
					controlTimer = setTimer(function() 
						toggleControl("brake_reverse", true)
						toggleControl("accelerate", true)
						toggleControl("vehicle_left", true)
						toggleControl("vehicle_right", true)
					end, 1500, 1)
				end
				
				-- Stats
				playerFares = playerFares + 1
				setElementData(localPlayer, "Fares", getElementData(localPlayer, "Fares")+1, true)
				
				-- Money
				local distance = getDistanceBetweenPoints2D(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], prevPosition[1], prevPosition[2])
				if tipEnabled then 
					fareMoney = math.floor(distance/10)
					tipWasEnabled = true
				else 
					fareMoney = math.floor(distance/40) 
					tipWasEnabled = false
				end
				fareCompleteText = true
				setTimer(function() fareCompleteText = false end, 3000, 1)
				
				-- Sounds
				if fareMoney ~= 23 then
					local r = math.randomDiff(1, 30)
					playSFX("spc_ga", pedSounds[r][1], pedSounds[r][2], false)
					playSFX("spc_ga", pedSounds[r][1], pedSounds[r][2], false)
					playSFX("spc_ga", pedSounds[r][1], pedSounds[r][2], false)
					playSFX("spc_ga", pedSounds[r][1], pedSounds[r][2], false)
					playSFX("spc_ga", pedSounds[r][1], pedSounds[r][2], false)
				else 
					playSFX("script", 196, 47, false) -- 23!
					playSFX("script", 196, 47, false) -- 23!
					playSFX("script", 196, 47, false) -- 23!
					playSFX("script", 196, 47, false) -- 23!
					playSFX("script", 196, 47, false) -- 23!
				end
				
				if playerFares > 4 then 
					-- bonus 5*N times in a row
					if playerFares - 5*math.floor(playerFares/5) == 0 then rowBonus = 5000*math.floor(playerFares/5)
					else rowBonus = 0 end
				end
				setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")+fareMoney+rowBonus, true)
				moneyEarned = moneyEarned + fareMoney + rowBonus
					
				-- Timer stuff
				if     playerFares == 0 then distance = distance*0.1	
				elseif playerFares == 1 then distance = distance*0.095
				elseif playerFares == 2 then distance = distance*0.08
				elseif playerFares == 3 then distance = distance*0.079
				elseif playerFares == 4 then distance = distance*0.078
				elseif playerFares == 5 then distance = distance*0.076
					
				elseif playerFares >  5 and playerFares < 11 then distance = distance*0.075
				elseif playerFares > 10 and playerFares < 21 then distance = distance*0.070
				elseif playerFares > 20 and playerFares < 51 then distance = distance*0.065 end
				playersTimer = playersTimer + math.floor(distance)
				
				if getElementData(localPlayer, "Fares") >= FARES_FOR_FINISH then -- finish race checks
					textMode = 6 -- Taxi Mission Finished
					setTimer(function() textMode = 0 end, 6000, 1)
					
					setElementData(localPlayer, "Money", moneyEarned)
					
					if COLLECT_ALL_FARES then
						triggerRaceCheckpoint(100)
					end
					
					raceFinished = true
					onMission = false
					return
				end
			end
			
			skipAfterCarIsFixed = false
			if textMode == 2 then return end
			
			-- not finished yet
			-- Max distance for fares (closer fares for slow rides)
			local model = getElementData(localPlayer, "Car")
			if model == "Taxi" or model == "Cabbie" then maxD = MAX_DISTANCE_TAXI_CABBIE
			else maxD = MAX_DISTANCE end
			
			-- Get new location
			randomizeNewLocation()
			
			-- Setup tips based of distance to the location
			local x, y, z = getElementPosition(taxi)
			local distance = getDistanceBetweenPoints3D(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], x, y, z)
			setupTips(distance)

			-- Marker and blips stuff
			currentFareMarker = createMarker(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], "cylinder", 4.0, 255, 0, 0, 200)
			currentFareMarkerBlip = createBlip(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], 0, 2, 204, 171, 92, 255)
			
			setElementData(localPlayer, "Destination", destinationTexts[CITY][fareMarkerID], true)
			
			-- Text Stuff
			if isTimer(textTimer) then killTimer(textTimer) end
			setTimer(function() textMode = 1 end, 3000, 1) -- Change text to fare text
			textTimer = setTimer(function() textMode = 0 end, 6500, 1) -- Disable text message
			
			-- Unlock new cars
			local money = getElementData(localPlayer, "Money") 
			
			-- Cabbie
			if money > CABBIE_PRICE and money < ZEBRA_PRICE then 
				if model == "Taxi" then carUnlocked = 1 end
			-- Zebra Cab
			elseif money > ZEBRA_PRICE  and money < SULTAN_PRICE then 
				if model == "Taxi" or model == "Cabbie" then carUnlocked = 2 end
			-- Sultan
			elseif money > SULTAN_PRICE and money < CRAZY_PRICE then 
				if model == "Taxi" or model == "Cabbie" or model == "Zebra Cab" then carUnlocked = 3 end
			-- Crazy taxi
			elseif money > CRAZY_PRICE then 
				if model == "Taxi" or model == "Cabbie" or model == "Zebra Cab" or model == "Sultan" then carUnlocked = 4 end
			end
			if carAdvertised == carUnlocked then
				alreadyAdvertised = true
			elseif carAdvertised ~= carUnlocked then 
				carAdvertised = carUnlocked 
				alreadyAdvertised = false
			end
			
			-- Position for calculating earnings
			prevPosition[1], prevPosition[2], prevPosition[3] = getElementPosition(taxi)
			return
		end 
		
		-- Mission start begins
		-- Setup vars
		playerFares = 0
		rowBonus = 0
		
		-- Checkpoint stuff
		if isElement(currentFareMarker) then destroyElement(currentFareMarker) end 
		if isElement(currentFareMarkerBlip) then destroyElement(currentFareMarkerBlip) end
		
		randomizeNewLocation()
		
		currentFareMarker = createMarker(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], "cylinder", 4.0, 255, 0, 0, 200)
		currentFareMarkerBlip = createBlip(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], 0, 2, 204, 171, 92, 255)
		
		setElementData(localPlayer, "Destination", destinationTexts[CITY][fareMarkerID], true)
		
		-- Position for calculating earnings
		prevPosition[1], prevPosition[2], prevPosition[3] = getElementPosition(taxi)
		
		-- Timer stuff
		if isTimer(oneSecondTimer) then killTimer(oneSecondTimer) end
		oneSecondTimer = setTimer(oneSecondUpdates, 1000, 0)
		
		local distance = getDistanceBetweenPoints3D(destinationCoords[CITY][fareMarkerID][1], destinationCoords[CITY][fareMarkerID][2], destinationCoords[CITY][fareMarkerID][3], prevPosition[1], prevPosition[2], prevPosition[3])
		playersTimer = math.floor(distance*0.1) + 60
		
		-- Tip
		setupTips(distance)
		
		-- Fare text
		textMode = 7 -- 'Taxi Driver'
		if isTimer(textTimer) then killTimer(textTimer) end
		setTimer(function() textMode = 1 end, 3000, 1) 
		textTimer = setTimer(function() textMode = 0 end, 8000, 1)
		
		missionStarted = true
		-- Mission start ends
	elseif not onMission and missionStarted then 
		missionStarted = false
		if isElement(currentFareMarker) then
			destroyElement(currentFareMarker)
			destroyElement(currentFareMarkerBlip)
		end	
		
		setElementData(localPlayer, "Destination", "Off duty", true)
	end
end

function setupTips(l_distance)
	tip = 100.0
	tipEnabled = true
	tipHealth = getElementHealth(getPedOccupiedVehicle(localPlayer))
	
	if l_distance < 500 then tipDecrease = 0.9 
	elseif l_distance >= 500 and l_distance < 800 then tipDecrease = 0.7
	elseif l_distance >= 800 and l_distance < 1200 then tipDecrease = 0.48
	elseif l_distance >= 1200 then tipDecrease = 0.25 end
	
	if isTimer(tipTimer) then killTimer(tipTimer) end
	tipTimer = setTimer(tipUpdate, 250, 0)
end

function tipUpdate()
	tip = tip - tipDecrease
	
	local taxi = getPedOccupiedVehicle(localPlayer)
	if not taxi then 
		if isTimer(tipTimer) then killTimer(tipTimer) end
		return
	end
	
	if tipHealth > getElementHealth(taxi) then -- Taxi gets damaged
		tip = tip - (tipHealth - getElementHealth(taxi))*0.17
		tipHealth = getElementHealth(taxi)
	end
	
	if tip <= 0 then 
		tipEnabled = false
		tip = 0
		killTimer(tipTimer)
	end
end

function getDistanceBetweenElements(arg1, arg2)
	if not isElement(arg1) or not isElement(arg2) then return 0 end
	
	local distance = getDistanceBetweenPoints3D(Vector3(getElementPosition(arg1)), Vector3(getElementPosition(arg2)))
	return distance
end

messageY = 0.35
messageY2 = 0.50 -- messageY + 0.15
addEventHandler("onClientRender", getRootElement(), function()
	-- Spectate check
	local x, y, z = getElementPosition(localPlayer)
	if z > MAX_Z_VALUE or getElementData(localPlayer, "state") == "spectating" then return end
	
	-- create light for localPlayer
	if getPedOccupiedVehicle(localPlayer) and not isElement(taxiLight[localPlayer]) and getElementData(source, "Car") == "Crazy Taxi" then
		taxiLight[localPlayer] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 229, 249, 5, 103)
		attachElements(taxiLight[localPlayer], getPedOccupiedVehicle(localPlayer), 0.0, 0.7, 0.7)
	end
	
	if onMission then
		if textMode == 7 then -- 'Taxi Driver'
			dxDrawBorderedText(1, "'Taxi Driver'", 0, 0, screenX, screenY*messageY, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
		elseif textMode == 1 then -- Destination text
			dxDrawText("DESTINATION " ..destinationTexts[CITY][fareMarkerID].. ".", screenX / 2 - screenX / 5 + 3, screenY * 0.7 + 3, 800, screenY, tocolor(0, 0, 0, 255), 3, "default-bold")
			dxDrawText("#C8C7C3DESTINATION #CAAB59" ..destinationTexts[CITY][fareMarkerID].. ".", screenX / 2 - screenX / 5, screenY * 0.7, 800, screenY, tocolor(210, 210, 210, 255), 3, "default-bold", center, top, true, true, false, true)
			
			-- Unlocked cars messages
			-- Cabbie unlocked
			if not alreadyAdvertised then 
				if carUnlocked == 1 and getElementData(localPlayer, "Car") ~= "Cabbie" then 
					dxDrawBorderedText(1, "New vehicle unlocked! Cabbie", 0, 0, screenX, screenY*messageY, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
					dxDrawBorderedText(1, "$" ..CABBIE_PRICE.." - Press RMB to BUY!", 0, 0, screenX, screenY*messageY2, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
				-- Zebra Cab unlocked
				elseif carUnlocked == 2 and getElementData(localPlayer, "Car") ~= "Zebra Cab" then 
					dxDrawBorderedText(1, "New vehicle unlocked! Zebra Cab", 0, 0, screenX, screenY*messageY, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
					dxDrawBorderedText(1, "$" ..ZEBRA_PRICE.." - Press RMB to BUY!", 0, 0, screenX, screenY*messageY2, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
				-- Sultan unlocked
				elseif carUnlocked == 3 and getElementData(localPlayer, "Car") ~= "Sultan" then 
					dxDrawBorderedText(1, "New vehicle unlocked! Sultan Taxi Ed.", 0, 0, screenX, screenY*messageY, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
					dxDrawBorderedText(1, "$" ..SULTAN_PRICE.." - Press RMB to BUY!", 0, 0, screenX, screenY*messageY2, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
				-- Crazy Taxi unlocked
				elseif carUnlocked == 4 and getElementData(localPlayer, "Car") ~= "Crazy Taxi" then 
					dxDrawBorderedText(1, "New vehicle unlocked! Crazy Taxi", 0, 0, screenX, screenY*messageY, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
					dxDrawBorderedText(1, "$" ..CRAZY_PRICE.." - Press RMB to BUY!", 0, 0, screenX, screenY*messageY2, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
				end
			end
		end
		
		if fareCompleteText then -- Fare complete
			if tipWasEnabled then
				dxDrawBorderedText(1, "SPEED BONUS!", 0, 0, screenX, screenY*0.25, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
			else 
				dxDrawBorderedText(1, "FARE COMPLETE!", 0, 0, screenX, screenY*0.25, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
			end
			dxDrawBorderedText(1, "$" ..fareMoney, 0, 0, screenX, screenY*0.40, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
			
			if rowBonus > 0 then
				local b = rowBonus/1000
				dxDrawBorderedText(1, b.." IN A ROW bonus! $" ..rowBonus, 0, 0, screenX, screenY*0.55, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
			end
		end
		
		local m = math.floor(playersTimer / 60)
		local s = playersTimer - m*60
		
		-- timer
		dxDrawBorderedText(2,"TIME", screenX * offsets[1], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic")
		if s < 10 then dxDrawBorderedText(2, m.. ":0" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic")	
		else dxDrawBorderedText(2, m.. ":" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic") end
		
		-- fares
		dxDrawBorderedText(2,"FARES", screenX * offsets[1], screenY * 0.25, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		dxDrawBorderedText(2, "" ..playerFares, screenX * offsets[2], screenY * 0.25, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		
		-- bonus
		if tipEnabled then
			dxDrawBorderedText(2,"TIP", screenX * offsets[1], screenY * 0.40, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		
			dxDrawRectangle(screenX*offsets[2]-3.0, (screenY * 0.4103)-3.0, 106.0, 18.0, tocolor(0, 0, 0, 255)) -- border
			dxDrawRectangle(screenX*offsets[2], screenY*0.4103, 100.0, 12.0, tocolor(86, 101, 120, 255)) -- inside
			dxDrawRectangle(screenX*offsets[2], screenY*0.4103, 1.0*tip, 12.0, tocolor(171, 203, 241, 255)) -- progress
		end
	elseif not onMission and textMode == 0 and introHappened and not isTimer(resetCarTimer) then
		-- Draw box
		dxDrawRectangle(screenX*b_offsets[1], screenY*b_offsets[2], screenX*b_offsets[3], screenY*b_offsets[4], tocolor(0, 0, 0, 175)) -- border 0.012, 0.163
		
		dxDrawText("Press 2 to toggle taxi", screenX*t_offsets[1], screenY*t_offsets[2], 800, screenY, tocolor(155, 155, 155, 255), 2, "default-bold")
		dxDrawText("missions on or off.", screenX*t_offsets[1], screenY*t_offsets[3], 800, screenY, tocolor(155, 155, 155, 255), 2, "default-bold")
	end
	
	 -- Your car is trashed text
	if textMode == 2 then
		dxDrawBorderedText(1, "Your car is trashed. It needs to be repaired.", 0, 0, screenX, screenY*0.70, tocolor (166, 27, 34, 255), messageSize, "default-bold", "center", "bottom", true, false)
		
	-- You're out of time!
	elseif textMode == 3 then 
		dxDrawText("You're out of time!", screenX / 2 - screenX / 5 + 3, screenY * 0.7 + 3, 800, screenY, tocolor(0, 0, 0, 255), messageSize, "default-bold")
		dxDrawText("#A61B22You're out of time!", screenX / 2 - screenX / 5, screenY * 0.70, 800, screenY, tocolor(210, 210, 210, 255), messageSize, "default-bold", center, top, true, true, false, true)
		
	-- Taxi mission over
	elseif textMode == 4 then 
		dxDrawBorderedText(1, "Taxi mission over", 0, 0, screenX, screenY*0.25, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
		
	-- There are no fares nearby, keep looking	
	elseif textMode == 5 then 
		dxDrawBorderedText(1, "There are no fares nearby. Keep looking.", 0, 0, screenX, screenY*0.70, tocolor (145, 103, 21, 255), messageSize, "default-bold", "center", "bottom", true, false)
	
	-- Taxi Missions Complete!
	elseif textMode == 6 then 
		dxDrawBorderedText(1, "Taxi Missions Complete!", 0, 0, screenX, screenY*0.8, tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "$" ..moneyEarned, 0, 0, screenX, screenY*0.95, tocolor (225, 225, 225, 255), messageSize, "pricedown", "center", "center", true, false)
	end
	
	if introText == 0 and not introHappened then
		setCameraMatrix(1051.2, -1245.1, 38.7, 1075.3, -1222, 25.8)
	end
	
	if introText == 1 then
		setCameraMatrix(1051.2, -1245.1, 38.7, 1075.3, -1222, 25.8)
		
		dxDrawBorderedText(2, "You are now working for Sunnyside Taxis.", 0, 0, screenX, screenY*0.7, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
		dxDrawBorderedText(2, "Complete fares to finish your shift!", 0, 0, screenX, screenY*0.8, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
		dxDrawBorderedText(2, "You don't have to do them all in a row.", 0, 0, screenX, screenY*0.9, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
	elseif introText == 2 then 
		setCameraMatrix(1051.2, -1245.1, 38.7, 1075.3, -1222, 25.8)
		
		dxDrawBorderedText(2, "You get some extra bonus for", 0, 0, screenX, screenY*0.7, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
		dxDrawBorderedText(2, "every 5 fares completed in a row.", 0, 0, screenX, screenY*0.8, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
		dxDrawBorderedText(2, "You can take a break, but you ain't getting those sweet bonuses then.", 0, 0, screenX, screenY*0.9, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "center", true, false)
	elseif introText == 3 then
		setCameraMatrix(1097.1, -1228.8, 24.3, 1100.2, -1236.6, 15.5)
		
		dxDrawBorderedText(2, "Nobody wants to ride in a trashed taxi so keep it fresh.", 0, 0, screenX, screenY*0.85, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "bottom", true, false)
		dxDrawBorderedText(2, "You can purchase better taxis. Company won't cover the cost,", 0, 0, screenX, screenY*0.9, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "bottom", true, false)
		dxDrawBorderedText(2, "but it's a good investment that will make us more money!", 0, 0, screenX, screenY*0.95, tocolor (240, 240, 240, 255), introTextSize, "bankgothic", "center", "bottom", true, false)
	end
end )

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) then
			if getElementData(source, "Car") == "Crazy Taxi" then
				if isElement(taxiLight[source]) then destroyElement(taxiLight[source]) end

				taxiLight[source] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 229, 249, 5, 103)
				attachElements(taxiLight[source], getPedOccupiedVehicle(source), 0.0, 0.7, 0.7)
			end
		end
	end
end )

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) and isElement(taxiLight[source]) then 
			destroyElement(taxiLight[source]) 
		end
	end
end )

function oneSecondUpdates()
	playersTimer = playersTimer - 1
	if playersTimer == 0 and onMission then -- mission failed
		textMode = 3
		if isTimer(textTimer) then killTimer(textTimer) end
		textTimer = setTimer(function() textMode = 0 end, 5000, 1)
		
		onMission = false
		killTimer(oneSecondTimer)
	end
end

function math.randomDiff (start, finish)
	math.randomseed(getTickCount())
    if (start and finish) then
        if (math.floor(start) ~= start) or (math.floor(finish) ~= finish) then return false end
        if (start >= finish) then return false end
    end
    if not start then
        local rand = math.random()
        while (rand == lastRand) do
            rand = math.random()
        end
        lastRand = rand
        return rand
    end
    
    if not finish then
        finish = start
        start = 1
    end
    
    local rand = math.random(start, finish)
    while (rand == lastRand) do
        rand = math.random(start, finish)
    end
    lastRand = rand
    return rand
end

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" then
        scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
    end
    local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
    local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end -- if chatbox is opened
	
	-- Spectate checks
	local x, y, z = getElementPosition(localPlayer)
	local taxi = getPedOccupiedVehicle(localPlayer)
	if z > MAX_Z_VALUE or getElementData(localPlayer, "state") == "spectating" or not taxi then return end
	
	if press then
		-- Submission key
		local keys = getBoundKeys("sub_mission")
		for keyName, state in pairs(keys) do
			if button == keyName then
				if not introHappened or isTimer(resetCarTimer) then break end
				
				-- Starting a mission
				if not onMission then
					if not raceFinished then
						
						-- Check for taxi health
						if getElementHealth(taxi) < 400.0 then 
							textMode = 2 -- Your car is trashed
							
							if CITY == 1 then 
								setBlipVisibleDistance(paynsprayBlips[1], 16000.0)
								setBlipVisibleDistance(paynsprayBlips[2], 16000.0)
								setBlipVisibleDistance(paynsprayBlips[3], 16000.0)
							elseif CITY == 2 then
								setBlipVisibleDistance(paynsprayBlips[4], 16000.0)
								setBlipVisibleDistance(paynsprayBlips[5], 16000.0)
								
							elseif CITY == 3 then
								setBlipVisibleDistance(paynsprayBlips[6], 16000.0)
								setBlipVisibleDistance(paynsprayBlips[7], 16000.0)
							end
						end
						
						-- check for city area
						local x, y, z = getElementPosition(localPlayer)
						local zone = getZoneName(x, y, z, true)
						
						if (CITY == 1 and zone ~= "Los Santos") or (CITY == 2 and zone ~= "San Fierro") or (CITY == 3 and zone ~= "Las Venturas") then
							textMode = 5 -- There are no fares nearby
							
								if isTimer(textTimer) then killTimer(textTimer) end
								textTimer = setTimer(function() textMode = 0 end, 5000, 1)
						end
						
						if textMode == 0 then onMission = true end
					end
					
				-- Ending a mission
				elseif onMission then 
					
					-- Change states
					onMission = false
					missionStarted = false

					-- Destroying marker and blip
					if isElement(currentFareMarker) then 
						destroyElement(currentFareMarker)
						destroyElement(currentFareMarkerBlip)
					end
					
					textMode = 4 -- Taxi mission over
					if isTimer(textTimer) then killTimer(textTimer) end
					textTimer = setTimer(function() textMode = 0 end, 5000, 1)
					
					setElementData(localPlayer, "Destination", "Off duty", true)
					
					-- Disable repair blips
					for b = 1, 7 do
						setBlipVisibleDistance(paynsprayBlips[b], 0.0)
					end
				end
				
				break
			end
		end
		
		-- Vehicle Fire for buying cars
		if button == "mouse2" then
			if carUnlocked == 1 then -- Cabbie
				setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")-CABBIE_PRICE)
				setElementData(localPlayer, "Car", "Cabbie")
			elseif carUnlocked == 2 then -- Zebra Cab
				setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")-ZEBRA_PRICE)
				setElementData(localPlayer, "Car", "Zebra Cab")
				
				local zebraSound = playSound("music/zebra.mp3", false)
				setSoundVolume(zebraSound, 1.5) -- set the sound volume to 50%
			elseif carUnlocked == 3 then -- Sultan
				setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")-SULTAN_PRICE)
				setElementData(localPlayer, "Car", "Sultan")
				
				local sultanSound = playSound("music/sultan.mp3", false)
				setSoundVolume(sultanSound, 0.8) -- set the sound volume to 50%
			elseif carUnlocked == 4 then -- Crazy Taxi
				setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")-CRAZY_PRICE)
				setElementData(localPlayer, "Car", "Crazy Taxi")
				
				local crazySound = playSound("music/crazy.mp3", false)
				setSoundVolume(crazySound, 0.7) -- set the sound volume to 50%
			end
			
			if carUnlocked == 1 or carUnlocked == 2 or carUnlocked == 3 or carUnlocked == 4 then
				carUnlocked = 0
				if textMode ~= 0 then textMode = 0 end
			end
		end
	end
end )

addEvent("playClientSFX", true)
addEventHandler("playClientSFX", getRootElement(), function(container, bank, sound, looped)
	if source ~= localPlayer then return end -- idk lol
	
	if looped then
		clientSound = playSFX(container, bank, sound, looped)
		setTimer(function() stopSound(clientSound) end, 750, 1)
	else 
		playSFX(container, bank, sound, looped)
	end
end )

-- Function checks if player is spectating
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > MAX_Z_VALUE then return true	
	else return false end
end