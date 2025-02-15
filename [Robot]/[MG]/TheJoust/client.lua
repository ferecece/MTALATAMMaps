local screenW, screenH = guiGetScreenSize()

local tournament_data = {}
local number_of_rounds = 1
local can_draw = false
local box_height,box_width

setTimer(function()
	tournament_data = getElementData(resourceRoot, "tournament_data")
	if tournament_data[1] then
		number_of_rounds = math.log (#tournament_data[1]) / math.log (2) + 1
		box_width  = math.min(screenW/number_of_rounds, 300)
		box_height = math.min(screenH/#tournament_data[1], 100)
		can_draw = true
	end
end,1000,0)

local show_bracket, force_show

function showBracket( _, state )
	if state == "1" then
		show_bracket = true
	else
		show_bracket = false
	end
end
addCommandHandler("showBracket", showBracket )
bindKey( "tab", "down", "showBracket", "1")
bindKey( "tab", "up", "showBracket", "0" )

function forceShow(duration)
	-- either force on/of or on with duration.
	if duration==0 then
		force_show = false
	elseif duration==1 then
		force_show = true
	else
		force_show = true
		setTimer(function()
			force_show = false
		end, duration, 1)
	end
end
addEvent( "forceShow", true )
addEventHandler( "forceShow", root, forceShow)

function renderBracket ()
	if not can_draw then
		return
	end
	if not (show_bracket or force_show) then
		return
	end

	dxDrawRectangle (0,0,screenW,screenH, tocolor(0,0,0,100), true)

	local number_of_matches = 0

	for i=1,number_of_rounds do
		if tournament_data[i] then
			number_of_matches = #tournament_data[i]
		else
			number_of_matches = number_of_matches/2
		end

		local y_offset = 0 
		if i==1 then
			y_offset = 0
		else
			y_offset = 2^(i-2)*box_height - box_height/2
		end
		for j=1,number_of_matches do

			local x = (i-1)*box_width
			local y = y_offset + (2^(i-1))*(j-1)*box_height

			local name1 = ""
			local name2 = ""
			if tournament_data[i] and tournament_data[i][j] and tournament_data[i][j]['player1'] ~= nil then
				if type(tournament_data[i][j]['player1']['element']) ~= 'string' then
					name1=tournament_data[i][j]['player1']['name']
				else
					name1=tournament_data[i][j]['player1']['element'] --fake player for testing
				end
				name1 = name1 .. " #FFFFFF(" .. tournament_data[i][j]['player1']['score'] .. ")"
			end

			if tournament_data[i] and tournament_data[i][j] and tournament_data[i][j]['player2'] ~= nil then
				if type(tournament_data[i][j]['player2']['element']) ~= 'string' then
					name2=tournament_data[i][j]['player2']['name']
				else
					name2=tournament_data[i][j]['player2']['element'] --fake player for testing
				end
				name2 = name2 .. " #FFFFFF(" .. tournament_data[i][j]['player2']['score'] .. ")"
			end
			
			dxDrawRectangle (x, y, 			      box_width, box_height/2, tocolor(0,0,0,150), true)
			dxDrawRectangle (x, y + box_height/2, box_width, box_height/2, tocolor(0,0,0,150), true)
			dxDrawText ("  "..i.."-"..j..": " .. name1, x, y,                x+box_width, y+box_height/2, tocolor ( 255, 255, 255, 255 ), 1, "default", "left", "center", true, false, true, true)
			dxDrawText ("  "..i.."-"..j..": " .. name2, x, y + box_height/2, x+box_width, y+box_height,   tocolor ( 255, 255, 255, 255 ), 1, "default", "left", "center", true, false, true, true)

		end

	end

end
addEventHandler ( "onClientRender", root, renderBracket )