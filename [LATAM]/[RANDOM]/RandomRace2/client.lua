notPlayed = true

function playSound()
    if(notPlayed) then 
        notPlayed = false
        local sound = playSound("aaa.mp3")
    end
end
addEvent("onSomeoneWon", true) 
addEventHandler("onSomeoneWon", localPlayer, playSound)