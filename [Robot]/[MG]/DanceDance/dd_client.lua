local screenX,screenY = guiGetScreenSize()

speed = 2000
elementDataKey = "dance.score"
onScreenKeys = {}
possibleKeys = {[1]="arrowUp.png",[2]="arrowDown.png",[3]="arrowLeft.png",[4]="arrowRight.png"}

playerScore = 0
setElementData (localPlayer,elementDataKey,0,true)
r,g,b = 255,255,255

text = "Good Luck"

function onClientRender()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local _,_,z = getElementPosition(veh)
		if x then
			if zFinish then
				if not letitgo then
					setElementPosition(veh,x,y,zFinish)
				end
			else
				setElementPosition(veh,x,y,z)
			end
		end
	end
	
	dxDrawImage(screenX*0.3,screenY*0.5,100,100,"pressPoint.png",0,0,0,tocolor(r,g,b,255))
	--dxDrawLine(screenX*0.3,0,screenX*0.3,screenY,tocolor(0,255,0,255))
	
	for i,key in ipairs (onScreenKeys) do
		local timeDifference = getTickCount()- key[2]
		local progress = timeDifference/speed
		if progress > 1.10 then
			table.remove(onScreenKeys,i)
			text = "Missed!"
			r,g,b = 255,0,0
			playerScore = playerScore - 1000
			setElementData (localPlayer,elementDataKey,playerScore,true)
		end
	end
	
	for i,key in ipairs (onScreenKeys) do
		local picture = key[1]
		local timeDifference = getTickCount()- key[2]
		local progress = timeDifference/speed
		if progress > 1.10 then
			progress = 1.10
			
		end
		local alpha = 255
		if progress > 1 then
			alpha = 255 - (progress-1)*255/0.1
		end
		dxDrawImage(screenX*0.3+(0.7*screenX*(1-progress)),screenY*0.5,100,100,possibleKeys[key[1]],0,0,0,tocolor(255,0,0,alpha))
		--dxDrawLine(screenX*0.3+(0.7*screenX*(1-progress)),0,screenX*0.3+(0.7*screenX*(1-progress)),screenY,tocolor(255,0,0,255))
	end
	dxDrawText(text,screenX*0.3-30,screenY*0.5-40,_,_,tocolor(r,g,b,255),1.5,"pricedown")
	dxDrawText(playerScore,screenX*0.3-30,screenY*0.5+100,_,_,tocolor(r,g,b,255),1.5,"pricedown")
	
	-- add a new key to the screen
	if indexCount and (indexCount < #g_Sequence)then
		if (g_Sequence[indexCount+1][2] < (getTickCount() - g_startTime)) then
			indexCount = indexCount+1
			table.insert(onScreenKeys,{g_Sequence[indexCount][1],getTickCount()})	
		end
	end
	
	if g_Sequence then
		if (indexCount == #g_Sequence) and not finish and veh then
			finish = true
			setTimer(finishPlayer,5000,1)
		end
	end
	
	--score
	local players = getElementsByType("player")
	table.sort(players,comp)
	for i,player in ipairs(players) do
		if (i<11) then
			local score = getElementData(player,elementDataKey)
			if not score then return end
			if (score)then
				dxDrawText(i .. ". " .. getPlayerName(player) .. "#FFFFFF     ",screenX*2/3,screenY/4+i*30,screenX*2/3,screenY/4+i*30,tocolor(255,255,255,255),1,"pricedown","left","center",false,false,false,true)
				dxDrawText(score,screenX*2/3+350,screenY/4+i*30,screenX*2/3+350,screenY/4+i*30,tocolor(255,0,0,255),1,"pricedown","center","center",false,false,false,true)
			end
		end
	end
	
	
	
end
addEventHandler("onClientRender",root,onClientRender)

function finishPlayer()
	zFinish = (#g_Sequence*1000 - playerScore)/100
	x,y = 2490.4,-1668.2
	setTimer(release,2000,1)
end

function release()
	letitgo = true
end

function comp(a,b)
	if not getElementData(a,elementDataKey) then return false end
	if not getElementData(b,elementDataKey) then return true end
	
	if (getElementData(a,elementDataKey)) > (getElementData(b,elementDataKey)) then
		return true
	else
		return false
	end
end

function addAction()
	table.insert(onScreenKeys,{math.random(1,4),getTickCount()})
end

function processSequence(sequence)
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		x,y,_ = getElementPosition(veh)
	end
	g_Sequence = sequence
	g_startTime = getTickCount()
	indexCount = 1
	table.insert(onScreenKeys,{g_Sequence[indexCount][1],g_startTime})
end
addEvent("sendSequence",true)
addEventHandler("sendSequence",root,processSequence)

hKeys = {["arrow_l"]="special_control_left",["arrow_r"]="special_control_right",["arrow_u"]="special_control_up",["arrow_d"]="special_control_down"}

function checkHit(key,keyState,nr)
	if (keyState == "down") and hKeys[key] then
		setPedControlState(hKeys[key],true)
	elseif (keyState == "up") and hKeys[key] then
		setPedControlState(hKeys[key],false)
	end
	
	if onScreenKeys[1] and (keyState == "down") then
		if onScreenKeys[1][1] == nr then
			local timeDifference = getTickCount()- onScreenKeys[1][2]
			local progress = timeDifference/speed
			if progress > 1.02 then
				text = "Late!"
				playerScore = playerScore +500
				setElementData (localPlayer,elementDataKey,playerScore,true)
				r,g,b = 255,125,0
			elseif progress >0.98 then
				text = "Perfect!"
				playerScore = playerScore + 1000
				setElementData (localPlayer,elementDataKey,playerScore,true)
				r,g,b = 0,255,0
			elseif progress > 0.8 then
				text = "Early!"
				playerScore = playerScore +500
				setElementData (localPlayer,elementDataKey,playerScore,true)
				r,g,b = 255,125,0
			else
				text = "Wrong!"
				playerScore = playerScore - 500
				setElementData (localPlayer,elementDataKey,playerScore,true)
				r,g,b = 255,0,0
				return
			end
			table.remove(onScreenKeys,1)
		else
			text = "wrong!"
			playerScore = playerScore - 500
			setElementData (localPlayer,elementDataKey,playerScore,true)
			r,g,b = 255,0,0
		end
	end
	
	
end
bindKey("arrow_l","both",checkHit,3)
bindKey("arrow_u","both",checkHit,1)
bindKey("arrow_r","both",checkHit,4)
bindKey("arrow_d","both",checkHit,2)
bindKey("special_control_left","both",checkHit,3)
bindKey("special_control_up","both",checkHit,1)
bindKey("special_control_right","both",checkHit,4)
bindKey("special_control_down","both",checkHit,2)