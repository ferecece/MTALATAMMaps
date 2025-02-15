Player = {}

local criminalNames = {
	"Forelli Family",
	"Leone Family",
	"Ancelotti Family",
	"Pegorino Crime Family",
	"Pecorinos",
	"Gambetti Family",
	"Messina Family",
	"McRearys",
	"Mendez Cartel",
	"Albanian Mob",
	"Bulgarin Crime Syndicate",
	"Red Gecko Tong",
	"Mountain Cloud Boys",
	"Da Nang Boys",
	"Yakuza",
	"Yardies",
	"Varrios Los Aztecas",
	"Grove Street Families",
	"Vagos",
	"Colombian Cartel",
	"Lost MC",
	"Angels of Death",
	"Uptown Riders",
	"Ballas",
	"Bloodhound Gang",
	"Anti-Fleischberg Group",
	"Tunnel Snakes",
	"Los Pollos Hermanos",
	"Trailer Park Mafia",
	"Hillside Posse",
	"Jingweon Mafia",
	"Midtown Gangsters",
	"Wonsu Nodong",
	"Dharma Initiative",
	"E-Corp",
	"Serious Individuals",
	"Jax Trust",
	"Kiketsu Family",
	"Scavengers",
	"Tyger Claws",
	"Voodoo Boys",
	"Rifa",
	"Loco Syndicate",
	"Stetchkov Syndicate",
	"Blood Feather Triad",
	"Snake Farmers",
	"Team Rocket",
	"Cerberus",
	"Discord Mods United",
	"Package Hunters Collective",
	"Team SKC",
	"GTA Community Rebellion",
	"Streetwannabes"
}

g_PoliceTeam = createTeam(g_POLICE_TEAM_NAME, 30, 190, 240)
g_CriminalTeam = createTeam(criminalNames[math.random(#criminalNames)], 150, 0 , 200)
g_PedTeam = createTeam(g_PED_TEAM_NAME)
g_CopWeaponId = 29 -- mp5

-- idk which skill is right
setWeaponProperty(29, "poor", "damage", 15)
setWeaponProperty(29, "std", "damage", 15)
setWeaponProperty(29, "pro", "damage", 15)

function Player:new(player)
	local o = {}
	setmetatable(o, self)

	self.__index = self
	o.role = nil
	o.player = player
	o.delivering = false
	o.perkId = nil
	o.died = false
	o.wantPolice = false

	o:askForRolePreference()
	return o
end

-- allows players to choose if they want to be cops or not
function Player:askForRolePreference()
	-- brings up some ui with matching effects
	triggerClientEvent(self.player, g_PLAYER_APPLY_FOR_POLICE_EVENT, resourceRoot, role)

	-- check role preference
	function togglePolicePreference()
		self.wantPolice = not self.wantPolice
	end
	bindKey(self.player, "space", "down", togglePolicePreference)
	setTimer(function()
		unbindKey(self.player, "space", "down", togglePolicePreference)
	end, g_POLICE_APPLICATION_DURATION, 1)
end

-- return if role successfully set
-- may not be set if there are no cop cars
function Player:setRole(role)
	if role == g_POLICE_ROLE then
		for _, copCar in pairs(getElementsByType("vehicle", mapRoot)) do
			if getElementModel(copCar) == 596 then
				-- at least 1 cop car to use
				self.role = role
				self.perkId = nil
				setPlayerTeam(self.player, g_PoliceTeam)
				setElementModel(self.player, 285)

				-- change player vehicle and tp to cop vehicle position
				local vehicle = getPedOccupiedVehicle(self.player)
				setElementModel(vehicle, 596) -- police LS
				setElementPosition(vehicle, getElementPosition(copCar))
				setElementRotation(vehicle, getElementRotation(copCar))
				setVehicleHandling(vehicle, "collisionDamageMultiplier", 0)
				setVehicleHandling(vehicle, "acceleration", 27)
				setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255, 0, 0, 0)
				-- harder to flip, 0 and 0.3 from getVehicleHandling, z is originally -0.1
				setVehicleHandling(vehicle, "centerOfMass", { 0, 0.3, -0.5 })
				destroyElement(copCar) -- so players won't spawn on top of each other

				-- give cops a weapon key
				bindKey(self.player, "vehicle_secondary_fire", "down", function()
					takeAllWeapons(self.player)
					giveWeapon(self.player, g_CopWeaponId, 9999, true) -- mp5
					setPedDoingGangDriveby(self.player, not isPedDoingGangDriveby(self.player))
				end)

				-- show role info
				triggerClientEvent(self.player, g_PLAYER_ROLE_SELECTED_EVENT, resourceRoot, role)
				return true
			end
		end

		return false
	elseif role == g_CRIMINAL_ROLE then
		self.role = role
		self.perkId = nil
		setPlayerTeam(self.player, g_CriminalTeam)

		-- brings up role description AND perk UI selection
		triggerClientEvent(self.player, g_PLAYER_ROLE_SELECTED_EVENT, resourceRoot, role)
		-- allow perk selection
		function selectPerk(player, _, _, perkId)
			self:setPerk(perkId)
		end
		bindKey(self.player, "1", "down", selectPerk, g_FUGITIVE_PERK.id)
		bindKey(self.player, "2", "down", selectPerk, g_MECHANIC_PERK.id)
		bindKey(self.player, "3", "down", selectPerk, g_HOTSHOT_PERK.id)
		setTimer(function()
			unbindKey(self.player, "1", "down", selectPerk)
			unbindKey(self.player, "2", "down", selectPerk)
			unbindKey(self.player, "3", "down", selectPerk)
		end, g_PERK_SELECTION_DURATION, 1)

		local clowncar = getPedOccupiedVehicle(self.player)
		setVehicleHandling(clowncar, "collisionDamageMultiplier", 0.2)
	end

	return true
end

function Player:setPerk(perkId)
	self.perkId = perkId
end

function Player:checkPerk()
	if not isElement(self.player) then return end -- in case someone dcs or something idk

	local veh = getPedOccupiedVehicle(self.player)

	if veh then
		if self.perkId == g_MECHANIC_PERK.id then
			local vx, vy, vz = getElementVelocity(veh)
			if vx == 0 and vy == 0 and vz == 0 then
				self:heal(g_MECHANIC_PERK.healRate * g_SERVER_TICK_DELAY / 1000) -- per tick
			end
		elseif self.perkId == g_FUGITIVE_PERK.id then
			if getElementAlpha(self.player) ~= 0  then
				setElementAlpha(self.player, 0)
				setVehicleLightState(veh, 0, 1)
				setVehicleLightState(veh, 1, 1)
				setVehicleLightState(veh, 2, 1)
				setVehicleLightState(veh, 3, 1)
			end
			local vx, vy, vz = getElementVelocity(veh)
			local speed = math.sqrt(vx * vx + vy * vy + vz * vz)
			if speed > g_FUGITIVE_PERK.minSpeed and getControlState(self.player, "handbrake") then
				local rate = (g_FUGITIVE_PERK.maxAlpha - g_FUGITIVE_PERK.minAlpha) / (g_FUGITIVE_PERK.phaseOutTime / g_SERVER_TICK_DELAY)
				setElementAlpha(veh, math.max(getElementAlpha(veh) - rate, g_FUGITIVE_PERK.minAlpha))
			else
				local rate = (g_FUGITIVE_PERK.maxAlpha - g_FUGITIVE_PERK.minAlpha) / (g_FUGITIVE_PERK.phaseInTime / g_SERVER_TICK_DELAY)
				setElementAlpha(veh, math.min(getElementAlpha(veh) + rate, g_FUGITIVE_PERK.maxAlpha))
			end
		elseif self.perkId == g_HOTSHOT_PERK.id then
			setVehicleHandling(veh, "maxVelocity", 200 + (1000 - getElementHealth(veh)) * g_HOTSHOT_PERK.velocityRate) -- 200 is base for vehicle
			setVehicleHandling(veh, "engineAcceleration", 11.2 + (1000 - getElementHealth(veh)) * g_HOTSHOT_PERK.accelRate) -- 11.2 is base for vehicle
		end
	end
end

function Player:heal(amount)
	if not isElement(self.player) then return end -- in case someone dcs or something idk

	local veh = getPedOccupiedVehicle(self.player)

	if veh and getElementHealth(veh) > 1 then
		setElementHealth(veh, math.min(getElementHealth(veh) + amount, 1000))
	end
end
