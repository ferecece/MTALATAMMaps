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

function animatePedRandom(ped, animCategory)
 local anims = Animations[animCategory];
 if not anims then return end
 
 local anim = anims[math.random(#anims)]
 
 setPedAnimation(ped, anim[1], anim[2])
end

function onMapStart()
 for _,ped in ipairs(getElementsByType("ped")) do
  animatePedRandom(ped, "cheering")
 end
-- for _,vehicle in ipairs(getElementsByType("vehicle")) do
--  	local state = getVehicleEngineState ( vehicle )
--        setVehicleEngineState ( vehicle, not state )
-- end 
end
addEventHandler("onClientResourceStart", resourceRoot, onMapStart)