require( "config" )

local MODNAME = "__Senpais_Pipes__"

data:extend( { { type = "item-group", name = "Senpais-Pipes", icon = MODNAME .. "/graphics/icon.png", icon_size = 32, order = "gg" } } )

local subgroupnumber = 0
local pipe_entitys = {}
local pipe_dir = {}
local pipe_shadow = {}
local pipe_dir_void = {}
local connections = { "straight_vertical_single", "straight_vertical", "straight_vertical_window", "straight_horizontal_window", "straight_horizontal", "corner_up_right",
					  "corner_up_left", "corner_down_right", "corner_down_left", "t_up", "t_down", "t_right", "t_left", "cross", "ending_up", "ending_down", "ending_right",
					  "ending_left" }
local void_icon = { filename = MODNAME .. "/graphics/pipe_indication_void.png", priority = "extra-high", width = 32, height = 32 }

for _, a in pairs { "N", "E", "S", "W" } do
	pipe_dir[a] = { icon = MODNAME .. "/graphics/pipe_indication_" .. a .. ".png" }
	pipe_shadow[a] = { icon = MODNAME .. "/graphics/pipe_indication_shadow_" .. a .. ".png" }
	pipe_dir_void[a] = { icon = MODNAME .. "/graphics/pipe_indication_" .. a .. ".png", tint = { r = 0.6, g = 0, b = 0.6 } }
end

for _, i in pairs( data.raw["pipe"] ) do
	if ( not i.name == "factory-fluid-dummy-connector" or not i.name == "factory-fluid-dummy-connector-south" ) then
		table.insert( pipe_entitys, i )
	end
end

for _, o in pairs( pipe_entitys ) do
	if subgroupnumber < 10 then subpad = "0" else subpad = "" end
	subgroupnumber = subgroupnumber + 1

	data:extend( { { type = "item-subgroup", name = "pipe-subgroup-" .. subpad .. subgroupnumber, group = "Senpais-Pipes", order = subpad .. subgroupnumber } } )

	local ordernumber = 0

	for sides, connec in pairs( Senpais.Pipes.Directions ) do
		if ordernumber < 10 then orderpad = "0" else orderpad = "" end
		ordernumber = ordernumber + 1
		
		local new_pipe = util.table.deepcopy( data.raw["pipe"][o.name] )
		new_pipe.name = o.name .. "-" .. sides
		new_pipe.icon = nil
		new_pipe.icons = { { icon = o.icon } }
		new_pipe_item.subgroup = "pipe-subgroup-" .. subpad .. subgroupnumber
		new_pipe_item.order = "pipe-" .. orderpad .. ordernumber
		new_pipe.fluid_box = { base_area = o.fluid_box.base_area, pipe_connections = connec }

		local texture = {}

		if ( sides == "E-N-S" or sides == "E-N-S-void" ) then texture = o.pictures.t_right end
		if ( sides == "E-S" or sides == "E-S-void" ) then texture = o.pictures.corner_down_right end
		if ( sides == "E-W" or sides == "E-W-void" ) then texture = o.pictures.straight_horizontal end
		if ( sides == "N-E" or sides == "N-E-void" ) then texture = o.pictures.corner_up_right end
		if ( sides == "N-E-W" or sides == "N-E-W-void" ) then texture = o.pictures.t_up end
		if ( sides == "N-S" or sides == "N-S-void" ) then texture = o.pictures.straight_vertical end
		if ( sides == "N-W" or sides == "N-W-void" ) then texture = o.pictures.corner_up_left end
		if ( sides == "S-W" or sides == "S-W-void" ) then texture = o.pictures.corner_down_left end
		if ( sides == "S-W-E" or sides == "S-W-E-void" ) then texture = o.pictures.t_down end
		if ( sides == "W-N-S" or sides == "W-N-S-void" ) then texture = o.pictures.t_left end

		if sides:find( "void" ) then
			if #connec < 4 then
				for _, d in pairs( connections ) do
					new_pipe.pictures[d] = { layers = { void_icon, texture } }
				end
			else
				for _, d in pairs( new_pipe.pictures ) do
					new_pipe.pictures[d] = { layers = { void_icon, new_pipe.pictures[d] } }
				end
			end
		elseif #connec < 4 then
			for _, d in pairs( connections ) do
				new_pipe.pictures[d] = texture
			end
		end

		if sides:find( "void" ) then
			if sides:find( "N" ) then
				table.insert( new_pipe.icons, pipe_dir_void.N )
			end

			if sides:find( "E" ) then
				table.insert( new_pipe.icons, pipe_dir_void.E )
			end

			if sides:find( "S" ) then
				table.insert( new_pipe.icons, pipe_dir_void.S )
			end

			if sides:find( "W" ) then
				table.insert( new_pipe.icons, pipe_dir_void.W )
			end
		else
			if sides:find( "N" ) then
				table.insert( new_pipe.icons, pipe_dir.N )
			end

			if sides:find( "E" ) then
				table.insert( new_pipe.icons, pipe_dir.E )
			end

			if sides:find( "S" ) then
				table.insert( new_pipe.icons, pipe_dir.S )
			end

			if sides:find( "W" ) then
				table.insert( new_pipe.icons, pipe_dir.W )
			end
		end

		if sides == "void" then
			table.insert( new_pipe.icons, { icon = MODNAME .. "/graphics/pipe_indication_void.png" } )
		end

		data:extend( { new_pipe } )
	end
end