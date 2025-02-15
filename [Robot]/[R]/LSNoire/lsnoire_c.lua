function Finish()
    local finishjingle = playSound("finishjingle.mp3")
    setSoundVolume(finishjingle,1.5)
end
addEvent("PlayFinishJingle", true)
addEventHandler("PlayFinishJingle", getRootElement(), Finish)    

function TimesUp()
    local timesupjingle = playSound("timesupjingle.mp3")
    setSoundVolume(finishjingle,1.5)
end
addEvent("onClientPlayerOutOfTime")
addEventHandler("onClientPlayerOutOfTime", root, TimesUp)    