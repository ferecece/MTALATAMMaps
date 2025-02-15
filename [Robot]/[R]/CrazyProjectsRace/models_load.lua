lastcar = 0
SHOW_CAR = false

addEventHandler("onClientResourceStart", resourceRoot, 
function()
	engineImportTXD(engineLoadTXD("models/virgo.txd"), 491)
	engineReplaceModel(engineLoadDFF("models/virgo.dff"), 491)
	
	engineImportTXD(engineLoadTXD("models/blistac.txd"), 496)
	engineReplaceModel(engineLoadDFF("models/blistac.dff"), 496)
	
	engineImportTXD(engineLoadTXD("models/tahoma.txd"), 566)
	engineReplaceModel(engineLoadDFF("models/tahoma.dff"), 566)	
	
	engineImportTXD(engineLoadTXD("models/stretch.txd"), 409)
	engineReplaceModel(engineLoadDFF("models/stretch.dff"), 409)	
	
	engineImportTXD(engineLoadTXD("models/blade.txd"), 536)
	engineReplaceModel(engineLoadDFF("models/blade.dff"), 536)	
	
	engineImportTXD(engineLoadTXD("models/dinghy.txd"), 473)
	engineReplaceModel(engineLoadDFF("models/dinghy.dff"), 473)	
	
	engineImportTXD(engineLoadTXD("models/vortex.txd"), 539)
	engineReplaceModel(engineLoadDFF("models/vortex.dff"), 539)	
	
	engineImportTXD(engineLoadTXD("models/vincent.txd"), 540)
	engineReplaceModel(engineLoadDFF("models/vincent.dff"), 540)	
	
	engineImportTXD(engineLoadTXD("models/enforcer.txd"), 427)
	engineReplaceModel(engineLoadDFF("models/enforcer.dff"), 427)	
	
	engineImportTXD(engineLoadTXD("models/willard.txd"), 529)
	engineReplaceModel(engineLoadDFF("models/willard.dff"), 529)	
	
	engineImportTXD(engineLoadTXD("models/merit.txd"), 551)
	engineReplaceModel(engineLoadDFF("models/merit.dff"), 551)	
	
	engineImportTXD(engineLoadTXD("models/emperor.txd"), 585)
	engineReplaceModel(engineLoadDFF("models/emperor.dff"), 585)	
	
	engineImportTXD(engineLoadTXD("models/monster.txd"), 444)
	engineReplaceModel(engineLoadDFF("models/monster.dff"), 444)	
	
	engineImportTXD(engineLoadTXD("models/hotknife.txd"), 434)
	engineReplaceModel(engineLoadDFF("models/hotknife.dff"), 434)	
	
	engineImportTXD(engineLoadTXD("models/bfinject.txd"), 424)
	engineReplaceModel(engineLoadDFF("models/bfinject.dff"), 424)	
	
	engineImportTXD(engineLoadTXD("models/taxi.txd"), 420)
	engineReplaceModel(engineLoadDFF("models/taxi.dff"), 420)		
	
	engineImportTXD(engineLoadTXD("models/bloodra.txd"), 504)
	engineReplaceModel(engineLoadDFF("models/bloodra.dff"), 504)
	
	setTimer(carText, 1000, 1)
end
)

function carText()
	setTimer(carText, 1000, 1)
	
	if not getPedOccupiedVehicle(localPlayer) then
		return 
	end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if lastcar == getElementModel(vehicle) then
		return
	else	
		lastcar = getElementModel(vehicle)
		CAR_BLURB = VEHICLE_NAMES[lastcar]
		SHOW_CAR = true
		setTimer(function() SHOW_CAR = false end, 6500, 1)
	end
end

VEHICLE_NAMES = {    
    [491] =	"Virgo Cabrio",
    [496] =	"Blista 3-Wheeler",
    [566] =	"Glenoma",
    [409] =	"Manananananana",
    [536] =	"Blade-Boat",
    [473] =	"Feltzer Amphibia",
    [539] =	"Rumpo Hovercraft",
    [540] =	"Vincent Cabrio",
    [427] =	"Hotpig Van",
    [529] =	"Herard",
    [551] =	"Crashed Merit",
    [585] =	"Bobster",
    [444] =	"Oceanic Monster",
    [434] =	"Perennial Hotrod",
    [424] =	"Rustlet",
    [420] =	"Taxi 6-Wheeler",
    [501] =	"News Heli on top",
    [488] =	"Goodluck with packages",
    [504] =	"Club+Clover"
}

SCREENWIDTH, SCREENHEIGHT = guiGetScreenSize()
function drawHudOverlay()
	if SHOW_CAR then
		drawBorderedText(CAR_BLURB, 2, SCREENWIDTH*0.2, SCREENHEIGHT*0.88, SCREENWIDTH*0.98, SCREENHEIGHT, tocolor(54, 104, 44, 255), 3, "bankgothic", "left", "top", false, false, true, true)
	end
end
addEventHandler("onClientRender", root, drawHudOverlay)

function drawBorderedText(text, borderSize, width, height, width2, height2, color, size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	text2 = string.gsub(text, "#%x%x%x%x%x%x", "")

	dxDrawText(text2, width+borderSize, height, width2+borderSize, height2, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height+borderSize, width2, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width, height-borderSize, width2, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height, width2-borderSize, height2, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height+borderSize, width2+borderSize, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height-borderSize, width2-borderSize, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width+borderSize, height-borderSize, width2+borderSize, height2-borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text2, width-borderSize, height+borderSize, width2-borderSize, height2+borderSize, tocolor(5, 17, 26, 255), size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
	dxDrawText(text, width, height, width2, height2, color, size, font, horizAlign, vertiAlign, bool1, bool2, bool3, bool4)
end