--function WarpHomies()

--end
--addEventHandler("onClientVehicleEnter", getRootElement(), WarpHomies)

function SweetAdmiralDialogue()
    AdmiralDialogue = playSFX("script", 182, 68, false)
    setSoundVolume(AdmiralDialogue, 1)
end
addEvent("PlayAdmiralDialogue", true)
addEventHandler("PlayAdmiralDialogue", getRootElement(), SweetAdmiralDialogue)

function FinishDialogue()
    SweetLine1 = playSFX("script", 182, 69, false)
    setSoundVolume(SweetLine1, 1)
    setTimer(function()
            SweetLine2 = playSFX("script", 182, 70, false)
            setSoundVolume(SweetLine2, 1)
    end, 1900, 1)
    setTimer(function()
        SweetLine3 = playSFX("script", 182, 71, false)
        setSoundVolume(SweetLine3, 1)
    end, 5500, 1)
end
addEvent("PlayFinishDialogue", true)
addEventHandler("PlayFinishDialogue", getRootElement(), FinishDialogue) 

function StartDialogue()
    setTimer(function()
        startLine1 = playSFX("script", 182, 22, false)
        setSoundVolume(startLine1, 1)
    end, 500, 1)    
    setTimer(function()
        startLine2 = playSFX("script", 182, 34, false)
        setSoundVolume(startLine2, 1)
    end, 3500, 1)
    setTimer(function()
        startLine3 = playSFX("script", 182, 35, false)
        setSoundVolume(startLine3, 1)
    end, 6500, 1)
end
addEvent("PlayStartDialogue", true)
addEventHandler("PlayStartDialogue", getRootElement(), StartDialogue)     