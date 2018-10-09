require "config"

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

for _, o in pairs( data.raw["pipe"] ) do
	if not Senpais.Pipes.NOCOPYS[o.name] then
		subgroupnumber = subgroupnumber + 1
		if subgroupnumber < 10 then subpad = "0" else subpad = "" end
		data:extend( { { type = "item-subgroup", name = "pipe-subgroup-" .. subpad .. subgroupnumber, group = "Senpais-Pipes", order = subpad .. subgroupnumber } } )
		local ordernumber = 0
		for sides, b in pairs( Senpais.Pipes.Directions ) do
			ordernumber = ordernumber + 1
			if ordernumber < 10 then orderpad = "0" else orderpad = "" end
			local new_pipe = util.table.deepcopy( data.raw["pipe"][o.name] )
			new_pipe.name = o.name .. "-" .. sides
			new_pipe.icon = nil
			new_pipe.icons = { { icon = o.icon } }
			new_pipe.subgroup = "pipe-subgroup-" .. subpad .. subgroupnumber
			new_pipe.order = "pipe-" .. orderpad .. ordernumber
			new_pipe.fluid_box = { base_area = o.fluid_box.base_area, pipe_connections = b.connec }
			new_pipe.localised_name = { "entity-name.Senpais-Pipes", { "entity-name." .. o.name }, { "Senpais-Pipes." .. sides } }
			new_pipe.placeable_by = { item = o.name, count = o.minable and o.minable.count or 1 }
			if sides == "void" then
				table.insert( new_pipe.icons, { icon = MODNAME .. "/graphics/pipe_indication_void.png" } )
				for _, name in pairs( connections ) do
					new_pipe.pictures[name] = { layers = { new_pipe.pictures[name], void_icon } }
				end
			else
				local texture = o.pictures[b.tex]
				if sides:find( "void" ) then
					for _, name in pairs( connections ) do
						new_pipe.pictures[name] = { layers = { texture, void_icon } }
					end
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
					for _, name in pairs( connections ) do
						new_pipe.pictures[name] = texture
					end
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
			end
			table.insert( pipe_entitys, new_pipe )
		end
	end
end

for u = 1, #pipe_entitys do
	data:extend{ pipe_entitys[u] }
end