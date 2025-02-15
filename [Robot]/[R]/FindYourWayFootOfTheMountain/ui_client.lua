function drawBorderedTextScreenRelative(text, borderSize, left, top, right, bottom, color, size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	SCREENWIDTH, SCREENHEIGHT = guiGetScreenSize()
	drawBorderedText(text, 2, SCREENWIDTH*left, SCREENHEIGHT*top, SCREENWIDTH*right, SCREENHEIGHT*bottom, color, size, font, horizAlign, vertiAlignclip, wordBreak, postGui, colorCoded)
end

function drawBorderedText(text, borderSize, left, top, right, bottom, color, size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	text2 = string.gsub(text, "#%x%x%x%x%x%x", "")

	dxDrawText(text2, left+borderSize, top, right+borderSize, bottom, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left, top+borderSize, right, bottom+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left, top-borderSize, right, bottom-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left-borderSize, top, right-borderSize, bottom, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left+borderSize, top+borderSize, right+borderSize, bottom+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left-borderSize, top-borderSize, right-borderSize, bottom-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left+borderSize, top-borderSize, right+borderSize, bottom-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text2, left-borderSize, top+borderSize, right-borderSize, bottom+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
	dxDrawText(text, left, top, right, bottom, color, size, font, horizAlign, vertiAlign, clip, wordBreak, postGui, colorCoded)
end