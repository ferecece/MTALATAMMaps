local rerolls = 3
function outputClick(button, press)
    if button == "mouse2" and press == true and rerolls > 0 then
        if (isPedDead(getLocalPlayer())) then
            outputChatBox("The deceased cannot reroll!", 255, 0, 0)
        else
            rerolls = rerolls - 1
            local rerollText = rerolls > 1 and "rerolls left" or (rerolls == 1 and "reroll left" or "rerolls left")
            outputChatBox("Rerolled your vehicle! " .. rerolls .. " " .. rerollText .. ".", 0, 255, 0)
            triggerServerEvent("playerClientClick", resourceRoot, getLocalPlayer())
        end
    end
end
addEventHandler("onClientKey", root, outputClick)

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
        outputChatBox( "Unlucky checkpoint? You can reroll your vehicle up to 3 times with right-click. Use them wisely!", 0, 255, 0 )
    end
);
