
local story = {["checkpoint (Coach) (1)"] = "On a moonlit night, when the whispers of ghostly tales mingle with the salty breeze...",
               ["checkpoint (Coach) (2)"] = "There sails a formidable vessel called The Phantom's Fury...",
               ["checkpoint (Coach) (3)"] = "Captained by the enigmatic Morgan de La Fayette...",
               ["checkpoint (Coach) (5)"] = "A man with a shadowy past and a quest for vengeance that transcends even death.",
               ["checkpoint (Coach) (8)"] = "Legend had it that Captain La Fayette and his trusted ship...",
               ["checkpoint (Coach) (9)"] = "had met a cruel fate at the hands of a treacherous foe.",
               ["checkpoint (Coach) (10)"] = "Their spirits, restless and aggrieved, returned to the mortal realm seeking retribution for the injustices done unto them.",
               ["checkpoint (Coach) (11)"] = "As the fog rolls in, obscuring the moon in a veil of mystery...",
               ["checkpoint (Coach) (12)"] = "The Phantom's Fury emerges from the mist like a specter from the depths.",
               ["checkpoint (Coach) (13)"] = "Its tattered sails billow in the ghostly wind...",
               ["checkpoint (Coach) (14)"] = "and its hull groans with the weight of a centuries-old grudge.",
               ["checkpoint (Coach) (15)"] = "But not all is lost...",
               ["checkpoint (Coach) (16)"] = "For even on the highest peak of Mt. Chilliad, where the souls of the damned roam free...",
               ["checkpoint (Coach) (17)"] = "The light of forgiveness shines brightest.",
               ["checkpoint (Coach) (22)"] = "And as time passes, you will find...",
               ["checkpoint (Coach) (24)"] = "A chance at redemption...",
               ["checkpoint (Coach) (25)"] = "A chance for forgiveness...",
               ["checkpoint (Coach) (27)"] = "Is to face the specters that haunt us...",
               ["checkpoint (Coach) (32)"] = "Or forever be cursed to wander the ghostly waters of regret.",
               ["checkpoint (Coach) (34)"] = "With a thunderous crash, the Phantom's Fury ascends like a wrathful tempest.",
               ["checkpoint (Coach) (35)"] = "And with a ferocity born of righteous fury...",
               ["checkpoint (Coach) (36)"] = "Captain Morgan stands fast.",
               ["checkpoint (Coach) (38)"] = "To be free of the curse, enact your vengeance...",
               ["checkpoint (Coach) (39)"] = "And allow the waters to cleanse the world and guide you to salvation.",
}

local screenWidth,screenHeight = guiGetScreenSize() 
function drawing()	
    local cameraPosX, cameraPosY, cameraPosZ = getElementPosition(getCamera())

    for id, text in pairs(story) do
    	local clientPositionX, clientPositionY, clientPositionZ = getElementPosition(getElementByID(id))
        clientPositionZ = clientPositionZ + 10
        local dist = getDistanceBetweenPoints3D(clientPositionX, clientPositionY, clientPositionZ, cameraPosX, cameraPosY, cameraPosZ)
        if  dist < 255 then
            
            local textSize = (screenHeight / 1080) * math.max(10/getDistanceBetweenPoints3D(clientPositionX, clientPositionY,
                        clientPositionZ, cameraPosX, cameraPosY, cameraPosZ), 2)

            local posX, posY = getScreenFromWorldPosition(clientPositionX, clientPositionY, clientPositionZ)

            if not (posX == false or posY == false) then
                width = dxGetTextWidth(text, textSize, "beckett")
                dxDrawBorderedText (1, dist, text, posX - 300, posY, posX + 300, posY+1000, tocolor ( 18, 107, 87, dist), textSize, "beckett", "left", "top", false, true )
                --dxDrawText (text, posX - 300, posY, posX + 300, posY+1000, tocolor ( 18, 107, 87, dist), textSize, "beckett", "left", "top", false, true )
            end
        end
    end		
end
addEventHandler ( "onClientRender", root, drawing ) -- keep the text visible with onClientRender.

function dxDrawBorderedText (outline, alpha, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top - outline, right - outline, bottom - outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top - outline, right + outline, bottom - outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top + outline, right - outline, bottom + outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top + outline, right + outline, bottom + outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top, right - outline, bottom, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top, right + outline, bottom, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outline, right, bottom - outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outline, right, bottom + outline, tocolor (0, 0, 0, alpha/4), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end