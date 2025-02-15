
GUIEditor = {
    button = {},
    staticimage = {},
    edit = {}
}

--creating the gui
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		
		if (getElementData(root,"racestate")== "Running") then
			wasted() -- destroy signs to players cannot cheat by telling others whilst spectating
		end
		
		--background
		local x,y = guiGetScreenSize()
		GUIEditor.staticimage[1] = guiCreateStaticImage(x/4, y-400, 125, 350, "phone.png", false)  
		
		--buttons
		GUIEditor.button[1] = guiCreateButton(23, 210, 20, 20, "1", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")

        GUIEditor.button[2] = guiCreateButton(53, 210, 20, 20, "2", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")

        GUIEditor.button[3] = guiCreateButton(83, 210, 20, 20, "3", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFAAAAAA")

		GUIEditor.button[4] = guiCreateButton(23, 240, 20, 20, "4", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[5] = guiCreateButton(53, 240, 20, 20, "5", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[6] = guiCreateButton(83, 240, 20, 20, "6", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[7] = guiCreateButton(23, 270, 20, 20, "7", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[7], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[8] = guiCreateButton(53, 270, 20, 20, "8", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[8], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[9] = guiCreateButton(83, 270, 20, 20, "9", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[9], "NormalTextColour", "FFAAAAAA")

		GUIEditor.button[10] = guiCreateButton(23, 300, 20, 20, "0", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[10], "NormalTextColour", "FFAAAAAA")
		
		GUIEditor.button[11] = guiCreateButton(53, 300, 50, 20, "CLEAR", false,GUIEditor.staticimage[1])
        guiSetProperty(GUIEditor.button[11], "NormalTextColour", "FFAAAAAA")
		
		--edit box
        GUIEditor.edit[1] = guiCreateEdit(23, 165, 75, 20, "", false,GUIEditor.staticimage[1])
        guiEditSetReadOnly(GUIEditor.edit[1], true)
		--guiEditSetMaxLength(GUIEditor.edit[1],3) 

		--explain label
		--guiCreateLabel(0,0,125,50,"right-click to enable/disable cursor, or use the keyboard to input numbers",false,GUIEditor.staticimage[1])
		
        addEventHandler ( "onClientGUIClick",root, outputEditBox)
		guiSetAlpha(GUIEditor.staticimage[1],0.9)
		
		
		--key handler
		addEventHandler("onClientKey", root, playerPressedKey)
    end
)


--changing the edit box, triggered by key presses (see below) or clicking
function outputEditBox (button,state,x,y,keyboard)
	if isPedDead(localPlayer) or not (getElementData(root,"racestate")== "Running") then
		--outputChatBox("number input cancelled")
		return
	end
	
	if (keyboard or ((getElementParent(source)==GUIEditor.staticimage[1]) and (button =="left"))) and not lock then
		if source == GUIEditor.button[11] then
			guiSetText(GUIEditor.edit[1],"")
		else
			local addNumber,newNumber
			local oldNumber = tonumber(guiGetText(GUIEditor.edit[1])) or 0
			if keyboard then
				addNumber = keyboard
			else
				addNumber = tonumber(guiGetText(source))
			end
			if oldNumber<10 then
				newNumber = oldNumber*10+addNumber
			elseif oldNumber <100 then
				newNumber = oldNumber*10+addNumber
				newNumber = oldNumber*10+addNumber
				triggerServerEvent ("processNumber", localPlayer, newNumber) 
				lock = true
				setTimer(function()
					lock = false
					guiSetText(GUIEditor.edit[1],"")
				end,500,1)
			end
			guiSetText(GUIEditor.edit[1],newNumber)
		end
	end
end
 
--enable the cursor by right clicking
active = false
function cursor (key,keystate)
	if not active then
		showCursor(true,true)
		guiSetAlpha(GUIEditor.staticimage[1],1)
		active = true
	else
		showCursor(false,true)
		active = false
		guiSetAlpha(GUIEditor.staticimage[1],0.75)
	end
end
bindKey("mouse2","down",cursor)

--also enable inputs with the keyboard, define an array with the keys
numKeys = {}
numKeys["0"]=0
numKeys["1"]=1
numKeys["2"]=2
numKeys["3"]=3
numKeys["4"]=4
numKeys["5"]=5
numKeys["6"]=6
numKeys["7"]=7
numKeys["8"]=8
numKeys["9"]=9
numKeys["num_0"]=0
numKeys["num_1"]=1
numKeys["num_2"]=2
numKeys["num_3"]=3
numKeys["num_4"]=4
numKeys["num_5"]=5
numKeys["num_6"]=6
numKeys["num_7"]=7
numKeys["num_8"]=8
numKeys["num_9"]=9

--when a key is pressed it gets sent to the editbox
function playerPressedKey(button, press)
    if (press) then -- Only output when they press it down
		if (getElementData(root,"racestate")== "Running") then	
			if button == "backspace" then
				guiSetText(GUIEditor.edit[1],"")
			end
			
			if numKeys[tostring(button)] then
				cancelEvent()
				outputEditBox(_,_,_,_,numKeys[tostring(button)])
			end
		end
    end
end


list = {}
list[2666]=true
list[2667]=true
list[2668]=true
list[2695]=true
list[2696]=true
list[2697]=true
list[2719]=true
list[2720]=true
list[2721]=true
list[2722]=true

list2 = {}
list2[0] = 2666
list2[1] = 2667
list2[2] = 2668
list2[3] = 2695
list2[4] = 2696
list2[5] = 2697
list2[6] = 2719
list2[7] = 2720
list2[8] = 2721
list2[9] = 2722

function wasted ( killer, weapon, bodypart )
	for index,theObject in ipairs (getElementsByType("object")) do
		local model = getElementModel(theObject)
		if list[model] then
			setElementModel(theObject,list2[math.random(0,9)])
			--outputChatBox("changed object")
		end
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wasted )