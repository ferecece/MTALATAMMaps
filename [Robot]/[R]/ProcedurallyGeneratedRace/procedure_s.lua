local raceCreated = false
local mapStarted = false
local DATABASE = dbConnect("sqlite", ":/procedurallyGeneratedRaceRecords.db")
local MAPSBASE = dbConnect("sqlite", ":/procedurallyGeneratedRaceMaps.db")

-- Nodes
local extraNodes = {}
local nodesData = {}
local boatNodes = {}
local trainNodes = {}

-- Skip marker mechanics
local skipEnabled = false
local voteEnabled = false
local votePlayer = nil
local votedPlayers = {}
local markerToSkip = 30

-- Generator
local oldDistance = 0
local maxDistance = 0
local checkpointPointer = 1
local raceDistance = 0
local bendsDone = 0
local autoBendsDone = 0
local offset = 5000

local environment = {}
local vehicle = {}
local race = {}
local markers = {}
for i = 0, 25 do
	markers[i] = {}
	markers[i][1] = 5000
	markers[i][2] = 5000
	markers[i][3] = 5000
end

-- Data table for cars
local vehiclesXml = Xml:new("vehicles.xml", "vehicles")
local vehicleRadius = {3, 3.2, 3.2, 5.2, 3.2, 3.3, 6.6, 4.8, 5.9, 4.3, 2.8, 3.1, 3.9, 3.3, 3.9, 3, 4.4, 12, 3.3, 3.4, 3.3, 3.5, 3.1, 3.6, 2.4, 9.8, 3.2, 4.4, 3.7, 2.9, 6.5, 6.6, 5.1, 5.5, 2.6, 7.3, 3.1, 6.3, 3.3, 3, 3.2, 2, 3.7, 10.3, 3.8, 3.2, 6.7, 7.5, 1.3, 5.2, 7.1, 3, 5.9, 6, 8.3, 5.3, 5.1, 2, 3.4, 3.2, 8.9, 1.4, 1.3, 1.4, 1.2, 0.9, 3.4, 3.5, 1.3, 7.5, 3.2, 1.4, 4.5, 2.6, 3.3, 3.2, 8.1, 3.3, 3.2, 3.3, 2.9, 1.1, 3.3, 3.4, 9.9, 2.3, 4.6, 7.7, 6.5, 3.3, 3.9, 3.4, 3.4, 6.7, 3.5, 3.2, 2.7, 7.7, 4.1, 3.9, 2.9, 0.9, 3.3, 3.4, 3.3, 3.3, 2.9, 3.6, 4.5, 1.2, 1.1, 15, 6.5, 6.5, 5.5, 5.6, 3.4, 3.5, 3.3, 14.1, 8.6, 1.4, 1.4, 1.4, 5, 3.9, 2.9, 3.2, 3.2, 3.1, 2.6, 2.3, 7.3, 3, 3.3, 3.1, 3.5, 11, 8.2, 2.6, 3.4, 2.7, 3.5, 3.2, 6.7, 2.7, 3.3, 3.2, 12.7, 3.1, 3.3, 3.7, 4, 18.9, 3.5, 2.8, 3.8, 3.8, 2.9, 3, 3, 3.2, 2.9, 9.6, 0.9, 2.7, 3.5, 3.7, 2.7, 9.4, 10.6, 1.6, 1.7, 4.1, 2.4, 3.2, 3.4, 45.7, 6.3, 3.5, 3.3, 1.4, 3.9, 2.5, 8.199999999999999, 3.5, 1.5, 3.2, 5.5, 2.9, 9.6, 7.3, 36.4, 9.3, 0.5, 6.3, 3.2, 3.3, 3.2, 3.5, 3.3, 4.5, 3.1, 3.3, 3.4, 3.2, 2.4, 2.4, 4, 4.1, 1.5, 2.1 }

local vehicleUpgrades = {
	[418] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1006},  {1020, 1021 }}, 
	[517] = {{1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1019, 1020 }}, 
	[421] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1018, 1019, 1020, 1021 }}, 
	[422] = {{1007, 1017},  {1019, 1020, 1021 }}, 
	[527] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1020, 1021 }}, 
	[489] = {{1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1013, 1024},  {1006},  {1018, 1019, 1020 }}, 
	[490] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[491] = {{1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1019, 1020, 1021 }}, 
	[492] = {{1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1006 }}, 
	[600] = {{1004, 1005},  {1007, 1017},  {1013},  {1006},  {1018, 1020, 1022 }}, 
	[496] = {{1011, 1142, 1143},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1006},  {1019, 1020 }}, 
	[605] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[547] = {{1142, 1143},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1018, 1019, 1020, 1021 }}, 
	[436] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013},  {1006},  {1019, 1020, 1021, 1022 }}, 
	[500] = {{1019, 1020, 1021 }}, 
	[603] = {{1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1006},  {1018, 1019, 1020 }}, 
	[439] = {{1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013 }}, 
	[599] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[559] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1069, 1070, 1071, 1072},  {1067, 1068},  {1065, 1066},  {1160, 1173},  {1159, 1161 }}, 
	[505] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[560] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1026, 1027, 1030, 1031},  {1032, 1033},  {1028, 1029},  {1169, 1170},  {1140, 1141 }}, 
	[565] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1047, 1048, 1051, 1052},  {1053, 1054},  {1045, 1046},  {1152, 1153},  {1150, 1151 }}, 
	[567] = {{1102, 1133},  {1130, 1131},  {1129, 1132},  {1188, 1189},  {1186, 1187 }}, 
	[561] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1056, 1057, 1062, 1063},  {1055, 1061},  {1059, 1064},  {1155, 1157},  {1154, 1156 }}, 
	[426] = {{1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1006},  {1019, 1021 }}, 
	[580] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1006},  {1018, 1020 }}, 
	[575] = {{1042, 1099},  {1043, 1044},  {1174, 1175},  {1176, 1177 }}, 
	[579] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[516] = {{1004},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1019, 1020, 1021 }}, 
	[518] = {{1142, 1143, 1144, 1145},  {1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013},  {1006},  {1018, 1020 }}, 
	[576] = {{1134, 1137},  {1135, 1136},  {1190, 1191},  {1192, 1193 }}, 
	[585] = {{1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013},  {1006},  {1018, 1019, 1020 }}, 
	[587] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[589] = {{1144, 1145},  {1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1006},  {1018, 1020 }}, 
	[540] = {{1142, 1143, 1144, 1145},  {1004},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1024},  {1006},  {1018, 1019, 1020 }}, 
	[458] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[551] = {{1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1006},  {1018, 1019, 1020, 1021 }}, 
	[534] = {{1101, 1106, 1122, 1124},  {1126, 1127},  {1179, 1185},  {1178, 1180},  {1100, 1123, 1125 }}, 
	[536] = {{1107, 1108},  {1103, 1128},  {1104, 1105},  {1181, 1182},  {1183, 1184 }}, 
	[550] = {{1142, 1143, 1144, 1145},  {1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1006},  {1018, 1019, 1020 }}, 
	[400] = {{1013, 1024},  {1018, 1019, 1020, 1021 }}, 
	[401] = {{1142, 1143, 1144},  {1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013},  {1006},  {1019, 1020 }}, 
	[549] = {{1011, 1012, 1142, 1143, 1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1019, 1020 }}, 
	[546] = {{1142, 1143, 1144, 1145},  {1004},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1024},  {1006},  {1018, 1019 }}, 
	[404] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013},  {1019, 1020, 1021 }}, 
	[405] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1018, 1019, 1020, 1021 }}, 
	[543] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164 }}, 
	[542] = {{1144, 1145},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1018, 1019, 1020, 1021 }}, 
	[535] = {{1118, 1119, 1120, 1121},  {1115, 1116},  {1109, 1110},  {1113, 1114},  {1117 }}, 
	[558] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1090, 1093, 1094, 1095},  {1088, 1091},  {1089, 1092},  {1165, 1166},  {1167, 1168 }}, 
	[410] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1013, 1024},  {1019, 1020, 1021 }}, 
	[562] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1036, 1039, 1040, 1041},  {1035, 1038},  {1034, 1037},  {1171, 1172},  {1148, 1149 }}, 
	[529] = {{1011, 1012},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1006},  {1018, 1019, 1020 }}, 
	[420] = {{1004, 1005},  {1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1019, 1021 }}, 
	[477] = {{1007, 1017},  {1006},  {1018, 1019, 1020, 1021 }}, 
	[415] = {{1000, 1001, 1002, 1003, 1014, 1015, 1016, 1023, 1049, 1050, 1058, 1060, 1138, 1139, 1146, 1147, 1158, 1162, 1163, 1164},  {1007, 1017},  {1018, 1019 }}, 
	[478] = {{1012},  {1004, 1005},  {1020, 1021, 1022 } }
}

-- Z
local maxZData = {
	["Paradiso"] = 30,
	["Juniper Hollow"] = 30, 
	["Juniper Hill"] = 30,
	["Calton Heights"] = 30,
	["Downtown"] = 12,
	["Garber Bridge"] = 5,
	["Easter Basin"] = 12,
	["Chinatown"] = 30,
	["Santa Flora"] = 30,
	["Hashbury"] = 30, 
	["Shady Creeks"] = 40,
	["Back o Beyond"] = 40, 
	["The Panopticon"] = 30,
	["Fern Ridge"] = 20,
	["Mulholland"] = 35,
	["Verdant Bluffs"] = 20,
	["Rodeo"] = 20,
	["East Los Santos"] = 20,
	["Los Flores"] = 30,
	--["Mullholland Intersection"] = 15,
	["North Rock"] = 40,
	["Montgomery Intersection"] = 20,
	["The Mako Span"] = 25,
	["Hunter Quarry"] = 30,
	["Verdant Meadows"] = 30,
	["El Castillo Del Diablo"] = 20, 
	["Las Colinas"] = 20, 
	["The Big Ear"] = 20,
	["Arco Del Oeste"] = 20,
	["Bayside"] = 25,
	["Tierra Robada"] = 30,
	["Mount Chiliad"] = 80,
	["Flint Intersection"] = 10,
	["Foster Valley"] = 5,
	["Commerce"] = 5,
	["Downtown Los Santos"] = 5,
	["Los Santos International"] = 5,
	["Whetstone"] = 10,
	["Easter Bay Airport"] = 15,
	["The Farm"] = 5,
	["Richman"] = 37,
	["Ocean Flats"] = 22
}

-- Nodes
local nodesData = {}
local trainNodes = {}
local learnedNodes = {}
local extraNodes = {}

-- Saving maps feature
local savingEnabled = false
local savePlayer = nil
local savedPlayers = {}

-- Trailers lol
local trailers = {}
local trailerTimers = {}
local cartsTimer = {}

function saveMap()
	if not raceCreated then return end 
	savingEnabled = false
	
	-- Make a name for the map
	local randomWords = {
		{"Crazy", "Fast", "Enormous", "Big", "Horny", "Incredible", "Beautiful", "Fabulous", "Steep", "Impossible", "Best", "Slow", "Normal", "Generic", "Beyond Belief", "San Fierro", "Side", "Unthinkable", "Anecdotic", "Dream", "Joy", "Frustrated", "Coffee", "Energy", "Joshimuz"},
		{"Course", "Race", "Drive", "Run-around", "Challenge", "%", "Track", "Ride", "Drag", "Trip", "Escape", "Journey", "Route", "Scenic Route", "Pursuit", "Annihilation", "Jump", "Shit", "Time", "Racetrack", "Thread", "Run", "Lane", "Path", "Secret", "Turf", "Dog", "Revenge", "Comeback", "Return", "Scare", "Overdose", "Cock", "Roof"}
	}
	local randoms = {math.random(#randomWords[1]), math.random(#randomWords[2])}
	
	local mapname, mapFriendlyName
	if vehicle["trailer"] == nil then
		mapname = vehicle["name"].. "" ..randomWords[1][randoms[1]].. "" ..randomWords[2][randoms[2]].. "" ..math.random(0, 50000)
		mapFriendlyName = vehicle["name"].. "'s " ..randomWords[1][randoms[1]].. " " ..randomWords[2][randoms[2]]
	else
		mapname = vehicle["trailerName"].. "" ..randomWords[1][randoms[1]].. "" ..randomWords[2][randoms[2]].. "" ..math.random(0, 50000)
		mapFriendlyName = vehicle["trailerName"].. "'s " ..randomWords[1][randoms[1]].. " " ..randomWords[2][randoms[2]]
	end
	
	local markersConverted = {}
	for i = 1, race["maxCP"] do table.insert(markersConverted, markers[i]) end
	
	if MAPSBASE then
		-- Create table
		dbExec(MAPSBASE, "CREATE TABLE IF NOT EXISTS MapsTable(id INTEGER, mapname TEXT, friendlyname TEXT, playername TEXT, checkpoints TEXT, vehicle TEXT, race TEXT, enviroment TEXT, timestamp INTEGER, ratings INTEGER, timesplayed INTEGER)")
		
		-- Count how many maps already stored
		outputResults = dbPoll(dbQuery(MAPSBASE, "SELECT COUNT(*) as mapscount FROM MapsTable"), -1)
		
		-- Save
		dbExec(MAPSBASE, "INSERT INTO MapsTable(id, mapname, friendlyname, playername, checkpoints, vehicle, race, enviroment, timestamp, ratings, timesplayed) VALUES (?,?,?,?,?,?,?,?,?,?,?)", tonumber(outputResults[1]["mapscount"]) + 1, mapname:gsub(" ", ""), mapFriendlyName, race["generator"], toJSON(markersConverted), toJSON(vehicle), toJSON(race), toJSON(environment), timeGenerated, -1, 0)
	end
	
	outputChatBox("#E7D9B0Saving map: #00FF00" ..mapFriendlyName.. " #E7D9B0by #00FF00" ..race["generator"], root, 0, 0, 0, true)
	outputDebugString("Saving: " ..mapname)
end

function setUpPlayersVehicle()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then			
			if getElementModel(players) ~= race["pedID"] and race["pedID"] ~= nil then
				setElementModel(players, race["pedID"])
			end
			
			if vehicle["hydraulics"] == 1 and getVehicleUpgradeOnSlot(getPedOccupiedVehicle(players), 9) == 0 then
				addVehicleUpgrade(getPedOccupiedVehicle(players), 1087)
			end
			
			setVehiclePaintjob(getPedOccupiedVehicle(players), vehicle["paintjob"])
			setVehicleHeadLightColor(getPedOccupiedVehicle(players), vehicle["lightsColorR"], vehicle["lightsColorG"], vehicle["lightsColorB"])
			if vehicle["wheels"] ~= nil then addVehicleUpgrade(getPedOccupiedVehicle(players), vehicle["wheels"]) end
			
			if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(players), 8) ~= 1008 and vehicle["nitros"] == 3 then
				addVehicleUpgrade(getPedOccupiedVehicle(players), 1008) 
			end
			
			for i = 1, #vehicle["upgrades"] do
				addVehicleUpgrade(getPedOccupiedVehicle(players), vehicle["upgrades"][i])
			end
			
			if vehicle["type"] == "Train" then
				-- Derailability Randomizer
				if vehicle["trainDerailable"] == 0 then setTrainDerailable(getPedOccupiedVehicle(players), false) end 
				
				-- Direction Randomizer
				if vehicle["trainDirection"] == 0 then setTrainDirection(getPedOccupiedVehicle(players), true)
				elseif vehicle["trainDirection"] == 1 then setTrainDirection(getPedOccupiedVehicle(players), false) end
				
				-- Train Carts
				if vehicle["trainCarts"] and trailers[players] == nil and not isTimer(cartsTimer[players]) then
					cartsTimer[players] = setTimer(function()
						-- Create carts
						trailers[players] = {}
						trailerTimers[players] = {}
						
						for t = 1, #vehicle["trainCarts"] do
							trailers[players][t] = createVehicle(vehicle["trainCarts"][t], vehicle["spawnX"], vehicle["spawnY"], vehicle["spawnZ"])
							if vehicle["trainDirection"] == 0 then setTrainDirection(trailers[players][t], true)
							else setTrainDirection(trailers[players][t], false) end
							
							if vehicle["trainDerailable"] == 0 then setTrainDerailable(trailers[players][t], false) end
							
							if t == 1 then trailerTimers[players][t] = setTimer(attachCartsToTrain, 250, 0, getPedOccupiedVehicle(players), trailers[players][t])
							else trailerTimers[players][t] = setTimer(attachCartsToTrain, 250, 0, trailers[players][t-1], trailers[players][t]) end
							
							setVehicleColor(trailers[players][t], math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
						end
					end, 300, 1)
				end
			end
			
			if vehicle["trailer"] ~= nil and vehicle["type"] ~= "Train" and mapStarted then
				if trailers[players] == nil then
					local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
					local closeToSomebody = false
					
					for _, ps in ipairs(getElementsByType("player")) do
						if players ~= ps and getPedOccupiedVehicle(ps) then
							local u, w, v = getElementPosition(getPedOccupiedVehicle(ps))
							if getDistanceBetweenPoints3D(x, y, z, u, w, v) < 0.3 then
								closeToSomebody = true
								break
							end
						end
					end
					
					if not closeToSomebody then
						local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
						trailers[players] = createVehicle(vehicle["trailer"], x, y, z, 0, 0, vehicle["trailerRot"])
						trailerTimers[players] = setTimer(attachTrailerToVehicle, 250, 1, getPedOccupiedVehicle(players), trailers[players])
						setElementVelocity(getPedOccupiedVehicle(players), 0, 0, 0)
						if vehicle["wheels"] ~= nil then addVehicleUpgrade(trailers[players], vehicle["wheels"]) end
						setVehicleColor(trailers[players], math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
					end
				else
					setElementHealth(trailers[players], 1000)
				end
			end
		end
	end
end

function attachCartsToTrain(train, cart)
	if not isTrainDerailed(train) then
		-- Make sure that cart is not derailed
		setTrainDerailed(cart, false)
		
		-- Attach cart to the train
		attachTrailerToVehicle(train, cart)
		
	-- Otherwise derail all carts
	else setTrainDerailed(cart, true) end
end

function update()
	-- Update player's vehicle
	setUpPlayersVehicle()
				
	-- Send data and skip
	if raceCreated then
		for _, players in ipairs(getElementsByType("player")) do
			if getElementData(players, "gotdata") ~= 1 then
				votedPlayers[players] = false
				triggerClientEvent(players, "recieveMarkers", players, {markers, vehicle, race, environment})
			end
			
			if skipEnabled and getElementData(players, "skipped") ~= 1 then
				triggerClientEvent(players, "setSkip", players, markerToSkip)
			end
		end
	end
end

-- GENERATOR STUFF -- 
function createRace()
	-- Check if somebody already made a Race
	if dataReceived or raceCreated then return end
	
	-- Random Vehicle
	math.randomseed(math.floor(os.time()/getTickCount()*math.random(1, getTickCount())))
	--repeat
		vehicle["model"] = math.random(400, 611)
		vehicle["name"] = tostring(vehiclesXml:getAttribute({tag = "vehicle", attribute = {id = vehicle["model"]}}, "name"))
	--until getVehicleType(vehicle["model"]) == "Train"
	
	if vehicle["model"] == 539 or vehicle["model"] == 607 or vehicle["model"] == 606 then vehicle["type"] = "Automobile" 
	else vehicle["type"] = getVehicleType(vehicle["model"]) end
	
	if vehicle["type"] == "Trailer" then
		vehicle["trailer"] = vehicle["model"]
		vehicle["trailerRot"] = math.random(0, 360)
		vehicle["trailerName"] = tostring(vehiclesXml:getAttribute({tag = "vehicle", attribute = {id = vehicle["trailer"]}}, "name"))
		
		-- "Trucking" trailers
		if vehicle["trailer"] == 435 or vehicle["trailer"] == 584 or vehicle["trailer"] == 450 or vehicle["trailer"] == 591 then
			local trucks = {403, 515, 514}
			vehicle["model"] = trucks[math.random(#trucks)]
		-- Farm Trailer
		elseif vehicle["trailer"] == 610 then
			vehicle["model"] = 531 -- Tractor
		-- Fucking Stairs
		elseif vehicle["trailer"] == 608 then
			local trucks = {583, 485}
			vehicle["model"] = trucks[math.random(#trucks)]
		-- Weird trailer for Utility Van
		elseif vehicle["trailer"] == 611 then
			vehicle["model"] = 552
		end
		
		vehicle["name"] = tostring(vehiclesXml:getAttribute({tag = "vehicle", attribute = {id = vehicle["model"]}}, "name"))
	end 
	
	-- Car delivery with Towtruck
	if vehicle["model"] == 525 then
		local towingChance = math.random(5)
		if towingChance == 4 then
			vehicle["type"] = "Trailer"
			
			local trailers = {602, 496, 401, 518, 527, 589, 587, 533, 526, 474, 545, 600, 491, 405, 467, 516, 445, 604, 438, 420, 496, 585}
			vehicle["trailer"] = trailers[math.random(#trailers)]
			vehicle["trailerRot"] = math.random(0, 360)
			vehicle["trailerName"] = tostring(vehiclesXml:getAttribute({tag = "vehicle", attribute = {id = vehicle["trailer"]}}, "name"))
		end
	end
	
	vehiclesXml:open()
		maxVelocity = tonumber(vehiclesXml:getAttribute({tag = "vehicle", attribute = {id = vehicle["model"]}}, "maxspeed"))
	vehiclesXml:unload()
	
	-- Vehicle's type specific nodes list
	-- Trains
	if vehicle["type"] == "Train" then
		local list = math.random(1, 2)
		nodesData = trainNodes[list]
	-- Boats
	elseif vehicle["type"] == "Boat" then
		nodesData = boatNodes
	end
	
	defineRace()
	
	-- Checkpoints
	local startingTime = getTickCount()
	checkpointPointer = 1
	while true do
		if not createCheckpoint() then 
			-- Redefine the race if it is shit
			if autoBendsDone > race["bends"] then defineRace()
			else
				-- Adjustment for trains 
				if vehicle["type"] == "Train" then maxDistance = maxDistance * 2 end
					
				-- New comparator reference (a bend made here)
				compX = markers[checkpointPointer-1][1]
				compY = markers[checkpointPointer-1][2]
				compZ = markers[checkpointPointer-1][3]
				autoBendsDone = autoBendsDone + 1
				oldDistance = 0
			end
		end
		
		-- Finish checkpoints generation
		if checkpointPointer > race["maxCP"] then break end
	end
	
	-- Increasing height of cps for air vehicles	
	if vehicle["type"] == "Helicopter" or vehicle["type"] == "Plane" then
		local baseHeight 
		if vehicle["type"] == "Plane" then baseHeight = markers[0][3] + math.random(50, 100)
		else baseHeight = markers[0][3] + math.random(20, 90) end
		
		for i = 0, race["maxCP"] do
			markers[i][3] = markers[i][3] + baseHeight + math.random(-20, 30)
		end
		
		vehicle["spawnX"] = markers[0][1]
		vehicle["spawnY"] = markers[0][2]
		vehicle["spawnZ"] = markers[0][3] + 30
	end
	
	race["raceDistance"] = math.floor(raceDistance)
	race["timems"] = getTickCount() - startingTime
	race["bends"] = bendsDone.. "." ..autoBendsDone
	race["usednodes"] = #nodesData.. " (" ..#extraNodes.. ")"
	race["generator"] = getPlayerName(getRandomPlayer())
	
	raceCreated = true
	
	setUpPlayersVehicle()
	
	setTimer(update, 500, 0)
	savingEnabled = true
	timeGenerated = os.time()
	
	if vehicle["trailer"] ~= nil then
		addEventHandler("onTrailerDetach", getRootElement(), function(truck)
			setTimer(properlyAttachTrailer, 10, 1, truck, source)
		end )
	end
end

function properlyAttachTrailer(truck, trailer)
	setElementVelocity(truck, 0, 0, 0)
	attachTrailerToVehicle(truck, trailer)
end

function defineRace()
	-- Data Initializing
	local availableWheels = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1098}
	
	-- Vehicle Type Specific Stuff
	-- Trains
	if vehicle["type"] == "Train" then
		vehicle["trainDirection"] = math.random(0, 1)
		vehicle["trainDerailable"] = math.random(0, 1)
		local specialTrain = math.random(4)
		
		-- Tram
		if vehicle["model"] == 449 and math.random(2) == 1 then
			vehicle["trainCarts"] = {449}
		
		-- Other train carts
		elseif vehicle["model"] == 590 or vehicle["model"] == 569 or vehicle["model"] == 570 then
			vehicle["trainCarts"] = {}
			
			for j = 1, math.random(2) do table.insert(vehicle["trainCarts"], vehicle["model"]) end
			
			vehicle["trailer"] = vehicle["model"]
			vehicle["trailerName"] = vehicle["name"]
			
			-- Streak
			if math.random(2) == 1 then 
				vehicle["model"] = 538 
				vehicle["name"] = "Brown Streak"
			-- Freight 	
			else 
				vehicle["model"] = 537 
				vehicle["name"] = "Freight"
			end 
		
		-- Special trains
		elseif (vehicle["model"] == 538 or vehicle["model"] == 569) and specialTrain == 3 then
			local availableCarts = {590, 569, 570, 449}
			vehicle["trainCarts"] = {}
			
			for j = 1, math.random(2) do
				local cart = math.random(#availableCarts)
				table.insert(vehicle["trainCarts"], availableCarts[cart])
			end
		end
	end
	
	-- Boats
	if vehicle["type"] == "Boat" then
		environment["waveHeight"] = math.random(0, 35) / 10
		environment["waterColorR"] = math.random(0, 255)
		environment["waterColorG"] = math.random(0, 255)
		environment["waterColorB"] = math.random(0, 255)
		environment["waterColorA"] = math.random(20, 255)
	end
	
	-- Planes and Helis
	if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then
		environment["clipDistance"] = math.random(1000, 2500)
	end
	
	-- Race Start
	local randomNode
	
	if not (vehicle["type"] == "Train" and #nodesData > 690 and #nodesData < 900) then randomNode = math.random(#nodesData)
	else randomNode = math.random(#nodesData - 41) end
	
	vehicle["spawnX"] = nodesData[randomNode][1]
	vehicle["spawnY"] = nodesData[randomNode][2]
	
	-- Disable Z+2 for boats to prevent them to spawn in the air
	if vehicle["type"] ~= "Boat" then vehicle["spawnZ"] = nodesData[randomNode][3] + 2
	else vehicle["spawnZ"] = nodesData[randomNode][3] end
	
	-- Set Random Vehicle Properties
	vehicle["spawnRot"] = math.random(0, 360)
	vehicle["wheels"] = availableWheels[math.random(#availableWheels)]
	vehicle["paintjob"] = math.random(0, 3)
	vehicle["hydraulics"] = 0
	vehicle["nitros"] = math.random(3)
	
	-- Vehicle's Lights Random Color
	vehicle["lightsColorR"] = math.random(0, 255)
	vehicle["lightsColorG"] = math.random(0, 255)
	vehicle["lightsColorB"] = math.random(0, 255)
	
	-- Vehicles Upgrades
	vehicle["upgrades"] = {}
	if vehicleUpgrades[vehicle["model"]] ~= nil then
		local upgrageList = vehicleUpgrades[vehicle["model"]]
		for slot = 1, #vehicleUpgrades[vehicle["model"]] do 
			if math.random(2) == 1 then
				table.insert(vehicle["upgrades"], upgrageList[slot][math.random(#upgrageList[slot])])
			end
		end
	end

	-- Checkpoints Random Color
	race["cpColorR"] = math.random(0, 255)
	race["cpColorG"] = math.random(0, 255)
	race["cpColorB"] = math.random(0, 255)
	
	-- Misc
	race["pedID"] = math.random(0, 312)
	race["bends"] = math.random(0, 2)
	
	if vehicle["type"] == "Train" and #nodesData == 300 then race["bends"] = 10 end
	
	-- Random Hydraulics
	if vehicle["type"] == "Automobile" then vehicle["hydraulics"] = math.random(0, 2)
	else vehicle["hydraulics"] = 0 end
	
	-- Maximum checkpoints for selected vehicle
	if maxVelocity > 130 then race["maxCP"] = math.random(20, 25)
	elseif maxVelocity < 131 and maxVelocity > 65 then race["maxCP"] = math.random(15, 20)
	elseif maxVelocity < 66 then race["maxCP"] = math.random(5, 15) end
	
	-- Checkpoint type
	if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then 
		race["markerType"] = "ring"	
	else 
		local types = {"ring", "corona", "checkpoint", "checkpoint", "checkpoint", "checkpoint", "checkpoint"}
		race["markerType"] = types[math.random(#types)]
	end
	
	if race["markerType"] == "ring" then race["markerSize"] = vehicleRadius[vehicle["model"]-399] + 6
	else race["markerSize"] = 10 end
	
	if vehicle["type"] == "Train" then race["markerSize"] = 3 end
	
	-- environment
	environment["hour"] = math.random(0, 23)
	environment["min"] = math.random(59)
	environment["weather"] = math.random(0, 19)
	environment["heat"] = math.random(0, 90)
	
	environment["AmbientColor"] = {
		[1] = math.random(0, 70),
		[2] = math.random(0, 70),
		[3] = math.random(0, 70)
	}
	environment["Illumination"] = math.random(0, 2)
	environment["Moon"] = math.random(0, 8)
	
	-- Data for Generator
	minDistance = maxVelocity / math.random(1.9, 2.2)
	maxDistance = maxVelocity * math.random(15, 17) / 10
	
	oldDistance = 0
	raceDistance = 0
	bendsDone = 0
	checkpointPointer = 1
	compX = vehicle["spawnX"]
	compY = vehicle["spawnY"]
	compZ = vehicle["spawnZ"]
	
	table.insert(markers, 0, {vehicle["spawnX"], vehicle["spawnY"], vehicle["spawnZ"]})
end

function createCheckpoint()
	local zone = getZoneName(markers[checkpointPointer-1][1], markers[checkpointPointer-1][2], markers[checkpointPointer-1][3], false)
	if maxZData[zone] ~= nil then maxZ = maxZData[zone]
	else maxZ = 12 end

	local k = 1.2
	if vehicle["type"] == "Plane" then 
		k = 1.8 
		maxZ = 999
	elseif vehicle["type"] == "Helicopter" or vehicle["type"] == "Boat" then
		k = 1.5
		maxZ = 999
	elseif vehicle["type"] == "Train" then
		maxZ = 999
	end
			
	-- Search points in certain distances from the reference point	
	local goodNodes = {}
	local ranges = {1, #nodesData}
	
	for i = 1, #nodesData do
		if nodesData[i][1] == markers[checkpointPointer-1][1] and nodesData[i][2] == markers[checkpointPointer-1][2] then
			ranges = {i - offset, i + offset}
			
			if i - offset < 1 then ranges[1] = 1 end
			if i + offset > #nodesData then ranges[2] = #nodesData end
			
			break
		end
	end
	
	for i = ranges[1], ranges[2] do
		local newDistance = getDistanceBetweenPoints3D(compX, compY, compZ, nodesData[i][1], nodesData[i][2], nodesData[i][3])
		local distance = getDistanceBetweenPoints3D(nodesData[i][1], nodesData[i][2], nodesData[i][3], markers[checkpointPointer-1][1], markers[checkpointPointer-1][2], markers[checkpointPointer-1][3])
		
		if (newDistance - oldDistance) >= minDistance*k and distance <= maxDistance*k and math.abs(nodesData[i][3] - markers[checkpointPointer-1][3]) < maxZ then
			table.insert(goodNodes, nodesData[i])
		end
	end
	
	if vehicle["type"] ~= "Train" and vehicle["type"] ~= "Boat" then
		for i = 1, #extraNodes do
			local newDistance = getDistanceBetweenPoints3D(compX, compY, compZ, extraNodes[i][1], extraNodes[i][2], extraNodes[i][3])
			local distance = getDistanceBetweenPoints3D(extraNodes[i][1], extraNodes[i][2], extraNodes[i][3], markers[checkpointPointer-1][1], markers[checkpointPointer-1][2], markers[checkpointPointer-1][3])
			
			if (newDistance - oldDistance) >= minDistance*k and distance <= maxDistance*k and math.abs(extraNodes[i][3] - markers[checkpointPointer-1][3]) < maxZ then
				table.insert(goodNodes, extraNodes[i])
			end
		end
	end
	
	if #goodNodes == 0 then return false
	else
		-- Selecting points from good nodes list
		math.randomseed(getTickCount()*math.random(69)*420/69*os.clock())
		local selectedNode = math.random(#goodNodes)
		
		-- Update Generator Parameters
		oldDistance = getDistanceBetweenPoints3D(compX, compY, compZ, goodNodes[selectedNode][1], goodNodes[selectedNode][2], goodNodes[selectedNode][3])
		
		-- Store coords for checkpoints
		markers[checkpointPointer][1] = goodNodes[selectedNode][1]
		markers[checkpointPointer][2] = goodNodes[selectedNode][2]
		markers[checkpointPointer][3] = goodNodes[selectedNode][3]

		distance = getDistanceBetweenPoints3D(markers[checkpointPointer][1], markers[checkpointPointer][2], markers[checkpointPointer][3], markers[checkpointPointer-1][1], markers[checkpointPointer-1][2], markers[checkpointPointer-1][3])
		raceDistance = raceDistance + distance
		
		if bendsDone ~= race["bends"] and math.floor(((race["maxCP"] + 1) / (race["bends"] + 1))*((bendsDone + autoBendsDone + 1))) == checkpointPointer and race["maxCP"] > 4 and vehicle["type"] ~= "Train" then
			compX = goodNodes[selectedNode][1]
			compY = goodNodes[selectedNode][2]
			compZ = goodNodes[selectedNode][3]
			oldDistance = 0
			bendsDone = bendsDone + 1
		end
		
		checkpointPointer = checkpointPointer + 1
	end
	
	return true
end

-- GENERATOR STUFF END --

-- Function converts time in milliseconds into time in format MM:SS.MS
function convertToRaceTime(time)
	if time ~= nil then
		local m = math.floor(time / 1000 / 60)
		local s = math.floor((time / 1000) - m*60)
		local ms = math.floor(time - (m*60+s)*1000)
		
		if m < 1 then m = ""
		else m = m.. ":" end
		if s < 10 and m ~= "" then s = "0" ..s end
		if ms < 10 then ms = "00" ..ms
		elseif ms < 100 and ms > 9 then ms = "0" ..ms end
		
		return m.. "" ..s.. "." ..ms
	end
end

function startSkipVote(playerSource, commandName)
	if voteEnabled and not skipEnabled and not votedPlayers[playerSource] then
		if not getElementData(playerSource, "race.finished") then
			votePlayer = playerSource
			votedPlayers[playerSource] = true
			local checkpointIsAttainable = false
			
			for _, players in ipairs(getElementsByType("player")) do 
				if getElementData(players, "race.checkpoint") ~= nil and getElementData(players, "race.checkpoint") ~= false and players ~= playerSource then
					if getElementData(players, "race.checkpoint") > getElementData(playerSource, "race.checkpoint") then
						checkpointIsAttainable = true
						break
					end
				end
			end
			
			if not checkpointIsAttainable then
				exports.votemanager:stopPoll {}
				poll = exports.votemanager:startPoll 
				{
					title = getPlayerName(playerSource):gsub("#%x%x%x%x%x%x", "").. " found unattainable checkpoint " ..getElementData(playerSource, "race.checkpoint").. ". Skip it?",
					percentage = 100,
					timeout = 15,
					allowchange = true,

					[1] = {"Yes", "pollFinished" , resourceRoot, 80},
					[2] = {"No", "pollFinished" , resourceRoot, 2},		
				}
				
				if not poll then applyPollResult(2) end
			else
				outputChatBox("Voteskip: that's not an unattainable checkpoint", playerSource)
			end
		end
	else
		if skipEnabled then outputChatBox("Voteskip: marker already skipped", playerSource)
		elseif votedPlayers[playerSource] then outputChatBox("Voteskip: you already voted once", playerSource)
		else outputChatBox("Voteskip: command disabled right now", playerSource) end
	end
end
addCommandHandler("voteskip", startSkipVote)

function startSaveVote(playerSource, commandName)
	if savingEnabled and not savedPlayers[playerSource] and raceCreated and getPlayerCount() > 1 then
		savePlayer = playerSource
		savedPlayers[playerSource] = true
		
		exports.votemanager:stopPoll {}
		poll = exports.votemanager:startPoll 
		{
			title = "Save this map?",
			percentage = 100,
			timeout = 15,
			allowchange = true,

			[1] = {"Yes", "pollFinished" , resourceRoot, 69},
			[2] = {"No", "pollFinished" , resourceRoot, 79},		
		}
		
		if not poll then applyPollResult(79) end
	else
		if votedPlayers[playerSource] then outputChatBox("Votesave: you already voted once", playerSource)
		elseif not raceCreated then outputChatBox("Votesave: map isn't generated yet", playerSource) end
	end
end
addCommandHandler("votesave", startSaveVote)

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "PreGridCountdown" then
		-- Set Weather
		setTime(environment["hour"], environment["min"])
		setWeather(environment["weather"])
		setMoonSize(environment["Moon"])
		setHeatHaze(environment["heat"])
		
		if vehicle["type"] == "Boat" then
			setWaveHeight(environment["waveHeight"])
			setWaterColor(environment["waterColorR"], environment["waterColorG"], environment["waterColorB"], environment["waterColorA"])
		end
		
		if vehicle["type"] == "Plane" or vehicle["type"] == "Helicopter" then
			setFarClipDistance(environment["clipDistance"])
		end
	elseif newState == "Running" then
		voteEnabled = true
		mapStarted = true
	elseif newState == "MidMapVote" or newState == "SomeoneWon" or newState == "NextMapVote"
		or newState == "TimesUp" or newState == "EveryoneFinished" or newState == "NextMapSelect" then
		voteEnabled = false
	end
end )

addEventHandler("onResourceStart", resourceRoot, function()
	-- Load Nodes File
	local file = fileOpen("nodes/nodes.json", true)
	local contents = fileRead(file, fileGetSize(file))
	fileClose(file)
	nodesData = fromJSON(contents)
	
	local file = fileOpen("nodes/learnedNodes.json", true)
	local contents = fileRead(file, fileGetSize(file))
	fileClose(file)
	extraNodes = fromJSON(contents) or {}
	
	local file = fileOpen("nodes/boatNodes.json", true)
	local contents = fileRead(file, fileGetSize(file))
	fileClose(file)
	boatNodes = fromJSON(contents)
	
	for i = 1, 3 do 
		local file = fileOpen("nodes/trainNodes" ..i.. ".json", true)
		local contents = fileRead(file, fileGetSize(file))
		fileClose(file)
		trainNodes[i] = fromJSON(contents)
	end
	
	outputDebugString("Loaded " ..#nodesData.. " nodes (" ..#extraNodes.. ")")
	createRace()
end )

-- Client sends its learned nodes to the server
addEvent("saveLearnedNodes", true)
addEventHandler("saveLearnedNodes", getRootElement(), function(nodesList)
	-- Open nodes file
	local file = fileOpen("nodes/learnedNodes.json", false)
	local contents = fileRead(file, fileGetSize(file))
	local extractedNodes = fromJSON(contents)
	
	-- Check received nodes
	local nodesToSave = {}
	for i = 1, #nodesList do
		local savePoint = true
		if extractedNodes ~= nil then 
			for j = 1, #extractedNodes do
				if getDistanceBetweenPoints3D(extractedNodes[j][1], extractedNodes[j][2], extractedNodes[j][3], nodesList[i][1], nodesList[i][2], nodesList[i][3]) < 50 then
					savePoint = false
					break
				end
			end
		else extractedNodes = {} end
		
		if nodesList[i][4] == 1 then -- material check
			for j = 1, #nodesData do
				if getDistanceBetweenPoints2D(nodesData[j][1], nodesData[j][2], nodesList[i][1], nodesList[i][2]) < 60 then
					savePoint = false
					break
				end
			end
		end
		
		if savePoint then
			table.insert(nodesToSave, {nodesList[i][1], nodesList[i][2], nodesList[i][3]})
		end
	end
	
	-- Merge tables
	for i = 1, #nodesToSave do
		table.insert(extractedNodes, nodesToSave[i])
	end
	
	-- Update file
	fileSetPos(file, 0)
	fileWrite(file, toJSON(extractedNodes))
	fileClose(file)
end )

-- Reset Player's Vehicle Model
addEvent("resetVehicleModel", true)
addEventHandler("resetVehicleModel", getRootElement(), function()
	if not raceCreated then return end
	local playersVehicle = getPedOccupiedVehicle(source)
	
	if getElementModel(playersVehicle) ~= vehicle["model"] then
		setElementModel(playersVehicle, vehicle["model"])
	end
end )

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	if (DATABASE) then
		local model, name
		if vehicle["trailer"] == nil then 
			model = vehicle["model"]
			modelName = vehicle["name"]
		else 
			if vehicle["model"] == 525 then
				model = vehicle["trailer"].. "trailer"
				modelName = vehicle["trailerName"].. " (Trailer)"
			else
				model = vehicle["trailer"]
				modelName = vehicle["trailerName"]
			end
		end
		
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..model.. "(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(DATABASE, "SELECT * FROM Table" ..model.. " WHERE playername = ?", getPlayerName(source):gsub("#%x%x%x%x%x%x", ""))
		recordsResults = dbPoll(recordsQuery, -1)		
		
		-- Updating Database
		if (recordsResults and #recordsResults > 0) then
			if (time < recordsResults[1]["score"]) then
				oldScore = recordsResults[1]["score"]
				dbExec(DATABASE, "UPDATE Table" ..model.. " SET score = ? WHERE playername = ?", time, getPlayerName(source):gsub("#%x%x%x%x%x%x", ""))
			end
		else
			oldScore = 0
			dbExec(DATABASE, "INSERT INTO Table" ..model.. "(playername, score) VALUES (?,?)", getPlayerName(source):gsub("#%x%x%x%x%x%x", ""), time)
		end
		
		-- Sort first 10 Records 		
		recordsResults = dbPoll(dbQuery(DATABASE, "SELECT * FROM Table" ..model.. " ORDER BY score"), -1)
		
		-- Check for new top time
		for i, recordsData in pairs(recordsResults) do 
			if recordsData["playername"] == getPlayerName(source):gsub("#%x%x%x%x%x%x", "") and time == recordsData["score"] then
				if oldScore ~= 0 then
					local diff = oldScore - time
					outputChatBox("#00FF00[" ..modelName.. "] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time).. " (-" ..convertToRaceTime(diff).. ")", root, 255, 255, 255, true)
				else
					outputChatBox("#00FF00[" ..modelName.. "] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
				end

				break
			end
			
			if i == 10 then break end
		end
	end
end )

-- Event called from client when player want to see stats, event returns data from database
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function()
	if DATABASE and vehicle ~= nil then
		local model
		if vehicle["trailer"] == nil then model = vehicle["model"] 
		else
			if vehicle["model"] == 525 then model = vehicle["trailer"].. "trailer"
			else model = vehicle["trailer"] end
		end
		
		-- Get first 11 records
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..model.. "(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(DATABASE, "SELECT * FROM Table" ..model.. " ORDER BY score ASC LIMIT 11")
		recordsResults = dbPoll(recordsQuery, -1)
		
		-- Get player's record
		local playerRow = dbPoll(dbQuery(DATABASE, "SELECT *, ROWID AS id FROM Table" ..model.. " WHERE playername = ? ORDER BY score ASC", getPlayerName(source):gsub("#%x%x%x%x%x%x", "")), -1)
		
		if #playerRow > 0 then 
			if playerRow[1]["id"] ~= nil then
				if playerRow[1]["id"] > 11 then 
					table.remove(recordsResults, 11)
					table.insert(recordsResults, 11, playerRow[1])
				end
			end
		end
		
		triggerClientEvent(source, "receiveStats", source, recordsResults)
	end
end )

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult)
	if pollResult == 80 then -- Yes
		markerToSkip = getElementData(votePlayer, "race.checkpoint")
		skipEnabled = true
	end
	
	if pollResult == 69 then saveMap() end -- saving yes
end )