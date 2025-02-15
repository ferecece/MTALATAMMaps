fired = false
hired = false
screenX, screenY = guiGetScreenSize()

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	if type(scaleY) == "string" then
		scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
	end
	local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
	local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

addEvent("displayFiredText", true)
addEventHandler("displayFiredText", getRootElement(), function()
	fired = true
	setTimer(function() fired = false end, 6000, 1)
end )

addEvent("displayHiredText", true)
addEventHandler("displayHiredText", getRootElement(), function()
	hired = true
	setTimer(function() hired = false end, 6000, 1)
end )

addEventHandler("onClientRender", getRootElement(), function()
	if fired then
		dxDrawBorderedText(1, "you're fired!", 0, 0, screenX, screenY*0.75, tocolor (200, 0, 0, 255), 3, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "You were supposed to be here in 2 minutes.", 0, 0, screenX, screenY*0.98, tocolor (200, 0, 0, 255), 1, "bankgothic", "center", "bottom", true, false)
	end 

	if hired then
		dxDrawBorderedText(1, "good job!", 0, 0, screenX, screenY*0.75, tocolor (150, 123, 35, 255), 3, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "Fix your car already.", 0, 0, screenX, screenY*0.98, tocolor (245, 245, 245, 255), 1, "bankgothic", "center", "bottom", true, false)
	end 
end )
