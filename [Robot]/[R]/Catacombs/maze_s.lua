function skin ( thePlayer, seat, jacked )
    setElementModel(thePlayer,1)
end
addEventHandler ( "onVehicleEnter", getRootElement(), skin )


-- Grid consists of indices 1,2,3 where the odd digits (1,3, etc) are nodes and the even digits are walls.
-- A path from 1->3 will cut the wall at position 2 open.
-- A cell will either be open 1, or closed 0. When closed a square box will be placed on that node.
-- When open only the floor will be placed.
-- All nodes will be connected to other nodes, seperated by walls depending on how the connection is made.
-- Therefore at the end there will always be a path from 1 node to all other nodes
-- and the start and end points of the maze can be set arbitrarily.

-- Translated to LUA from:
-- https://artofproblemsolving.com/community/c3090h2221709_wilsons_maze_generator_implementation

-- Wilson's Algorithm is an algorithm to generate a
-- uniform spanning tree using a loop erased random walk.
-- Algorithm:
-- 1. Choose a random cell and add it to the visited list
-- 2. Choose another random cell (Don’t add to visited list).
--    This is the current cell.
-- 3. Choose a random cell that is adjacent to the current cell
--    (Don’t add to visited list). This is your new current cell.
-- 4. Save the direction that you traveled on the previous cell.
-- 5. If the current cell is not in the visited cells list:
--    a. Go to 3
-- 6. Else:
--    a. Starting at the cell selected in step 2, follow the arrows
--       and remove the walls that are crossed.
--    b. Add all cells that are passed into the visited list
-- 7. If all cells have not been visited
--    a. Go to 2


local width = 21   -- needs to be odd
local height = 21  -- needs to be odd

local maze_start = {0,0}
local maze_end   = {width,height}

-- Valid directions in random walk
local directions = {{0,1}, {1,0}, {0,-1}, {-1,0}}

-- Generate starting grid and visited cells
local grid = {}
local visited = {}
local path = {}
for i=1,width do
	grid[i] = {}
	visited[i] = {}
	path[i]={}
	for j=1,height do
		grid[i][j] 		= 0  -- 0 wall, 1 open
		visited[i][j] 	= 0	 -- 0 not visited, 1 visited
		path[i][j] 		= 0  -- random walk path, will contain (1,4) to indicate direction to next cell
	end
end

local function cut(index)
	grid[index[1]][index[2]] = 1
end

local function get_next_cell(cell, dirNum, fact)
	local dir_x, dir_y = unpack(directions[dirNum])
	local out = {cell[1] + fact*dir_x, cell[2] + fact*dir_y}
	return out
end

local function is_valid_direction(cell, dirNum)
	--	Checks if the adjacent cell in the direction specified by dirNum is within the grid
	local newCell = get_next_cell(cell, dirNum, 2)
	return not ((newCell[1] < 1) or (newCell[2] < 1) or (newCell[1] > width) or (newCell[2] > height))
end


-- Fill up unvisited cells
local unvisited = {}
for i=1,width do
	for j=1,height do
		if i%2==1 and j%2==1 then  -- skip walls
			table.insert(unvisited, {i,j})
		end
	end
end

-- Choose the first cell to put in the visited list
-- See Step 1 of the algorithm.
local current = table.remove(unvisited, math.random(1, #unvisited))
visited[current[1]][current[2]] = 1
cut(current)


-- Loop until all cells have been visited
while #unvisited > 0 do

	-- Choose a random cell to start the walk (Step 2)
	local first = unvisited[math.random(1, #unvisited)]
	current = first
	
	-- Loop until the random walk reaches a visited cell
    while true do

    	-- Choose direction to walk (Step 3)
    	local dirNum = math.random(1,4)
    	while not is_valid_direction(current, dirNum) do -- note: can step back in the direction we just came from
    		dirNum = math.random(1,4)
    	end

    	-- Save the cell and direction in the path. 
    	-- If the random path returns on itself, this will overwrite to loop-erase
    	path[current[1]][current[2]] = dirNum

    	-- Get the next cell in that direction
    	current = get_next_cell(current, dirNum, 2)
    	if visited[current[1]][current[2]] == 1 then
    		break
    	end
    end
    -- We now have a path that started in an unvisited cell and ends in a visited one, with loops removed.

    current = first

    -- Walk the path and mark cells
    while true do
    	
    	-- current cell
    	visited[current[1]][current[2]] = 1 -- mark visited
    	cut(current) --cut node

    	for i=#unvisited,1,-1 do
    		if (current[1] == unvisited[i][1]) and (current[2] == unvisited[i][2]) then
    			table.remove(unvisited, i) -- remove from unvisited list
    			break
    		end
    	end

    	-- Go to the next cell on the path, first cut the wall
    	local dirNum = path[current[1]][current[2]] 
    	local crossed = get_next_cell(current, dirNum, 1)
    	cut(crossed) --cut wall

    	-- Then repeat the loop with the next cell
    	current = get_next_cell(current, dirNum, 2)
    	
    	if visited[current[1]][current[2]] == 1 then --hit a visited cell
    		
    		path = {} -- reset path
    		for i=1,width do
				path[i]={}
				for j=1,height do
					path[i][j] = 0  
				end
			end

			break -- end, and start with a new unvisited node until all nodes are finished.

    	end
    end

end


-- -- Print Maze
-- print('MAZE:')
-- for j=height,1,-1 do
-- 	local text = ""
-- 	for i=1,width do
-- 		if grid[i][j] == 1 then
-- 			text = text .. "1"
-- 		else
-- 			text = text .. "0"	
-- 		end
-- 	end
-- 	outputDebugString(text)
-- end


-- Build Maze
local x,y,z = unpack({0,0,100})
for i=0,width+1 do -- add padding around the edges
	for j=0,height+1 do

		local x_offset = x + (i-1)*9
		local y_offset = y + (j-1)*9
		local z_offset = z

		createObject(3095, x_offset,     y_offset,     z_offset+9,   0, 0, 0) -- lid
		if grid[i] and grid[i][j] and grid[i][j] == 1 then
			createObject(3095, x_offset, y_offset, z_offset, 0 , 0, 0) --base

			-- if math.random(1,10) == 1 then
			-- 	createObject(3576, x_offset + math.random(-1,1) * 2.25, y_offset + math.random(-1,1) * 2.82, z_offset+2.05, 0 , 0, 0) --crates
			-- end


		elseif not ( (i==1 and j==0) or (i==width and j == (height+1)) ) then
			createObject(3095, x_offset, y_offset, z_offset, 0 , 0, 0) --base
			createObject(3095, x_offset-4.5, y_offset,     z_offset+4.5, 0, 90,  0) -- left
			createObject(3095, x_offset+4.5, y_offset,     z_offset+4.5, 0, -90, 0) -- right
			createObject(3095, x_offset,     y_offset+4.5, z_offset+4.5, 0, 90,  -90) -- north
			createObject(3095, x_offset,     y_offset-4.5, z_offset+4.5, 0, 90,  90) -- south
		end

		if i~=1 and j==1 then
			createObject(3525, x_offset,          y_offset-4.35, z_offset+4.5, 0, 0,  180) -- torch
		end
		if i~=width and j==height then
			createObject(3525, x_offset,          y_offset+4.35, z_offset+4.5, 0, 0,  0) -- torch
		end
		if i==1 then
			createObject(3525, x_offset-4.35,     y_offset,      z_offset+4.5, 0, 0,  90) -- torch
		end
		if i==width then
			createObject(3525, x_offset+4.35,     y_offset,      z_offset+4.5, 0, 0,  -90) -- torch
		end

	end
end

-- alcove checker
-- alcove needs 3 walls in either north, east, south, west
for i=1,width do 
	for j=1,height do
		local counter = 0
		for k=1,4 do
			local cell = get_next_cell({i,j}, k, 1)
			if (cell[1] == 0) or (cell[1]==width+1) or (cell[2]==0) or (cell[2]==height+1) then  --maze edges always count
				counter = counter + 1
			elseif grid[cell[1]][cell[2]] == 0 then
				counter = counter + 1
			end
		end

		if counter >= 3 and not ((i==1 and j==1) or (i==width and j==height)) then

			local x_offset = x + (i-1)*9
			local y_offset = y + (j-1)*9
			local z_offset = z
			createObject(3576, x_offset + math.random(-1,1) * 2.25, y_offset + math.random(-1,1) * 2.82, z_offset+2.05, 0 , 0, 0) --crates

		end

	end
end

-- T-section checker
-- needs exactly 1 wall adjecent
--local directions = {{0,1}, {1,0}, {0,-1}, {-1,0}}
local steerskull_rotation = {45,-45,-135,135}
for i=2,width-1 do 
	for j=2,height-1 do
		local counter = 0
		local found_k
		for k=1,4 do
			local cell = get_next_cell({i,j}, k, 1)
			if grid[cell[1]][cell[2]] == 0 then
				counter = counter + 1
				found_k = k
			end
		end

		if counter == 1 and math.random(0,100)<10 then

			local x_dir, y_dir = unpack(directions[found_k])

			local x_offset = x + (i-1)*9 + x_dir*4.2
			local y_offset = y + (j-1)*9 + y_dir*4.2
			local z_offset = z + 2.58
			createObject(6865, x_offset, y_offset, z_offset, 0 , 0, steerskull_rotation[found_k]) --steerskull

		end

	end
end

-- Corner checker
local corner_objects = {3576,}
for i=2,width-1 do 
	for j=2,height-1 do

		local counter = 0
		local found
		local rotation
		-- west and north
		local north = get_next_cell({i,j}, 1, 1)
		local east  = get_next_cell({i,j}, 2, 1)
		local south = get_next_cell({i,j}, 3, 1)
		local west  = get_next_cell({i,j}, 4, 1)
		if grid[north[1]][north[2]] == 0 and grid[east[1]][east[2]] == 0 then
			--NE corner
			found = {1,1}
			counter = counter + 1
			rotation = 135
		end
		if grid[south[1]][south[2]] == 0 and grid[east[1]][east[2]] == 0  then
			--SE corner
			found = {1,-1}
			counter = counter + 1
			rotation = 45
		end
		if grid[south[1]][south[2]] == 0 and grid[west[1]][west[2]] == 0 then
			--SW corner
			found = {-1,-1}
			counter = counter + 1
			rotation = -45
		end
		if grid[north[1]][north[2]] == 0 and grid[west[1]][west[2]] == 0  then
			--NW corner
			found = {-1,1}
			counter = counter + 1
			rotation = -135
		end

		if counter == 1 then

			if math.random(0,100) < 10 then
				local x_offset = x + (i-1)*9 + found[1]*3.4
				local y_offset = y + (j-1)*9 + found[2]*3.4
				local z_offset = z + 1.76
				createObject(2745, x_offset, y_offset, z_offset, 0 , 0, rotation) --CJ_STAT
			else
				local x_offset = x + (i-1)*9 + found[1]*2.25
				local y_offset = y + (j-1)*9 + found[2]*2.25
				local z_offset = z + 2.05
				createObject(3576, x_offset, y_offset, z_offset, 0 , 0, 0) --crates
			end
		end

	end
end

