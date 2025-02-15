Animations = {
 cheering = {
  { 'ON_LOOKERS', 'panic_shout' },
  { 'ON_LOOKERS', 'point_loop' },
  { 'ON_LOOKERS', 'shout_01' },
  { 'ON_LOOKERS', 'shout_02' },
  { 'ON_LOOKERS', 'wave_loop' },
  { 'OTB', 'wtchrace_win' },
  { 'ped', 'FIGHTIDLE' },
  { 'ped', 'endchat_03' },
  { 'RIOT', 'RIOT_ANGRY_B' },
  { 'RIOT', 'RIOT_CHANT' },
  { 'RIOT', 'RIOT_challenge' },
  { 'RIOT', 'RIOT_shout' },
  { 'STRIP', 'PUN_CASH' },
  { 'STRIP', 'PUN_HOLLER' }
 }
}

local members = {
	{"[SKC]Whiskey",93},
	{"[SKC]SyS",155},
	{"[SKC]Hitman",108},
	{"[SKC]Bagpuss",239},
	{"[SKC]Plodders",249},
	{"[SKC]Wiltsu",36},
	{"[SKC]Obelix",2},
	{"[SKC]AdiBoy",176},
	{"[SKC]SAW",247},
	{"[SKC]Yoda",11},
	{"[SKC]TD_Mystic",260},
	{"[SKC]Sensless",10},
	{"[SKC]Cortez",40},
	{"[SKC]JrMan",241},
	{"[SKC]Obsolete",203},
	{"[SKC]Matt88",212},
	{"[SKC]Acid_Rain",191},
	{"[SKC]PYGsteriK",168},
	{"[SKC]Fresh",255},
	{"[SKC]anTe",222},
	{"[SKC]KingBong",79},
	{"[SKC]Ivan_xXx",60},
	{"[SKC]HumanTrafiC",233},
	{"[SKC]Griezel",38},
	{"[SKC]D.C",89},
	{"[SKC]Mars_Army",80},
	{"[SKC]Synergi",145},
	{"[SKC]ZerO",282},
	{"[SKC]Ruuub",285},
	{"[SKC]Sputs|uk",141},
	{"[SKC]Hans_Oberlander",107},
	{"[SKC]Dockinoke",54},
	{"[SKC]Runman",277},
	{"[SKC]ViRuS",172},
	{"[SKC]MCvarial",131},
	{"[SKC]Dop3man83Uk",44},
	{"[SKC]CsenaHUN",278},
	{"[SKC]B!BeR_Do$",43},
	{"[SKC]Trollaize",126},
	{"[SKC]Aiwick7",135},
	{"[SKC]Botn",264},
	{"[SKC]tru_scot",209},
	{"[SKC]terrortje",274},
	{"[SKC]MissTerre",133},
	{"[SKC]Georgije",135},
	{"[SKC]Jamie44",157},
	{"[SKC]Heggy",38},
	{"[SKC]Freaktuning",83},
	{"[SKC]uncollected",156},
	{"[SKC]hipis161",209},
	{"[SKC]WeeD",148},
	{"[SKC]Danboi",27},
	{"[SKC]Servo",35},
	{"[SKC]Ayo",114},
	{"[SKC]SinaPars",228},
	{"[SKC]SlayerX",59},
	{"[SKC]mookster",87},
	{"[SKC]Hi'nk:::",210},
	{"[SKC]Jorge_F",177},
	{"[SKC]Grungy",288},
	{"[SKC]Enok",176},
	{"[SKC]Lorwie[NL]",88},
	{"[SKC]TurkeyHunter",201},
	{"[SKC]iRyanLT",111},
	{"[SKC]Noah",129},
	{"[SKC]LordeTerras",99},
	{"[SKC]Frank",283},
	{"[SKC]Mr_Fear",239},
	{"[SKC]gini",178},
	{"[SKC].St3ve.",255},
	{"[SKC]Puuks",247},
	{"[SKC]WarCry",29},
	{"[SKC]DaRk_AxEl",271},
	{"[SKC]Scanner",11},
	{"[SKC]Mrs.Cortez",126},
	{"[SKC]Malaki",12},
	{"[SKC]Borek",199},
	{"[SKC]Don_Hincha_Ray",69},
	{"[SKC]H5N1[PL]",256},
	{"[SKC]Malaki",60},
	{"[SKC]Accident",147},
	{"[SKC]MrBrown",57},
	{"[SKC]Tabby",212},
	{"[SKC]Nanobot",179},
	{"[SKC]31Check",23},
	{"[SKC]Scoopa",16},
	{"[SKC]LaRento",138},
	{"[SKC]Bezimienny",138},
	{"[SKC]JackDaniels",58},
	{"[SKC]Leavin",226},
	{"[SKC]botder",153},
	{"[SKC]Tulaipo",199}
}

function animatePedRandom(ped, animCategory)
	 local anims = Animations[animCategory]
	 if not anims then return end
	 
	 local anim = anims[math.random(#anims)]
	 
	 setPedAnimation(ped,anim[1],anim[2],nil,true,false,false,false)
end

addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		for _,ped in ipairs(getElementsByType("ped")) do
			local i = math.random(1,#members)
			setElementModel(ped,members[i][2])
			table.remove(members,i)
			animatePedRandom(ped,"cheering")
		end
	end
)

addEventHandler("onClientPedDamage",root,
	function ()
		if source == localPlayer then return end
		setPedAnimation(source)
		setElementHealth(source,0)
	end
)


    addEventHandler("onClientResourceStart",resourceRoot,
       function ()
          for i,vehicle in ipairs (getElementsByType ("vehicle")) do
             if not getVehicleController (vehicle) then
                setVehicleOverrideLights (vehicle, 2)
                setVehicleEngineState (vehicle, true)
                setVehicleSirensOn (vehicle, true)
                setElementData (vehicle, "race.collideothers", 1)
             end
          end
       end
    )