local drunkenness = 0
local drunklvl = 0.07
local initt = 0
local chkpoints = 0
local beersound = 0

function pissed()
	chkpoints = chkpoints + 1
	beersound = chkpoints-(math.floor(chkpoints/2))*2
	if beersound == 1 then
		setTimer ( function ()
			local sound = playSound("openchug.mp3")
			setTimer ( function ()
				local sound2 = playSound(math.random(1,10)..".mp3")
			end, 3000, 1)
		end, math.random(10,3000), 1)
	end
	if chkpoints == 3 then
		local sound3 = playSound3D("screams.mp3", 2130.6, 1402.7, 11, false, true)
		setSoundMaxDistance(sound3, 350)
	end
    drunkenness = drunkenness + 20  
	if drunkenness >= 255 then 
		drunkenness = 255
	end
	drunklvl = drunkenness / 255
	local randTime = math.floor(math.random(500, 3500))
	local randTime2 = math.floor(math.random(700, 2000))
	local randTime3 = randTime * math.random()
	setCameraDrunkLevel( drunkenness )
	setTimer ( function ()
		fadeCamera (false, randTime/1000, 0, 0, 0)
		setTimer ( function ()
			fadeCamera (true, randTime2/1000)
		end, randTime3, 1)
	end, randTime, 1)
end
addEvent( "onHitCheckpoint", true )
addEventHandler( "onHitCheckpoint", localPlayer, pissed )

function renderDisplay ( )
	if initt == 0 then
		fov = getCameraFieldOfView("vehicle")
		fovdiff = (fov-30)/2
		initt = 1
	end
	local seconds = getTickCount() / 1000
	local seconds2 = getTickCount() / 286
	local sin1 = (math.sin(seconds) + 1)
	local sin2 = (((math.sin(seconds2))/3)+1)*drunklvl
	local FM = sin1 * sin2
	local fovsin = fov - FM * (drunklvl * fovdiff)
	setCameraFieldOfView("vehicle",fovsin)
end 
addEventHandler("onClientRender", root, renderDisplay)