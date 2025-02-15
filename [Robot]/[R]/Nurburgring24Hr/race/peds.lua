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
	{"[SKC]Sputs|uk",260},
	{"[SKC]Sputs|uk",260}
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
			-- nametags[ped] = tostring(members[i][1])
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