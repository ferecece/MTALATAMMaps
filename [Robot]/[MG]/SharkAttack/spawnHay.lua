---- im literally not going to place that much hay one by one
currentHay = 0

objects = {}

hayRows = 25
rowLenght = 14

function createHay()
	if currentHay < hayRows then
		currentInRow = 0
			while currentInRow < rowLenght do
				object = createObject(3374,3482+currentInRow*4,-1702+currentHay*4,-5.3,math.random(-5,5),math.random(-5,5),math.random(-5,5))
				local x,y,z = getElementPosition(object)
				local rx,ry,rz = getElementRotation(object)
				local randomN = math.random(1,20) --- 1,10 chance of my sound to playSound
				if randomN == 1 then
					local sound = playSound3D("doorclose.ogg",x,y,z+5)
					setSoundMaxDistance(sound,200)
				end		
				local moveTime = math.random(2000,5000)
				moveObject(object,moveTime,x,y,z+4.3,-rx,-ry,-rz,"OutElastic")
				--setObjectBreakable(object,false)
				table.insert(objects,object)
				if currentInRow == 0 or currentInRow == rowLenght-1 then --- lampposts
					if currentInRow == rowLenght-1 then
					object = createObject(1223,3482+currentInRow*4,-1702+currentHay*4,-4.3,0,0,180)
					else
					object = createObject(1223,3482+currentInRow*4,-1702+currentHay*4,-4.3,0,0,0)
					end
					local x,y,z = getElementPosition(object)
					moveObject(object,moveTime+4000,x,y,z+4,0,0,0,"OutElastic")
				end
				
				if currentHay == 0 or currentHay == hayRows - 1 then --- haysides
					local object = createObject(3374,3482+currentInRow*4,-1702+currentHay*4,-4.3,0,0,0)
					local x,y,z = getElementPosition(object)
					moveObject(object,moveTime+6000,x,y,z+4,0,0,0,"OutElastic")
				end
				
				currentInRow = currentInRow+1
			end
		currentHay = currentHay+1
		currentInRow = 0
		setTimer(createHay,100,1)
	end
end
setTimer(createHay,5000,1)
