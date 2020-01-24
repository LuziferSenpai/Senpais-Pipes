require "config"

local m = "__Senpais_Pipes__"

data:extend
{
	{
		type = "item-group",
		name = "Senpais-Pipes",
		icon = m .. "/graphics/icon.png",
		icon_size = 32,
		order = "gg"
	}
}

local sn = 0
local pe, pd, ps, pdv = {}, {}, {}, {}
local c =
{
	"straight_vertical_single",
	"straight_vertical",
	"straight_vertical_window",
	"straight_horizontal_window",
	"straight_horizontal",
	"corner_up_right",
	"corner_up_left",
	"corner_down_right",
	"corner_down_left",
	"t_up", "t_down",
	"t_right",
	"t_left",
	"cross",
	"ending_up",
	"ending_down",
	"ending_right",
	"ending_left"
}
local void_icon =
{
	filename = m .. "/graphics/pipe_indication_void.png",
	priority = "extra-high",
	width = 32,
	height = 32
}

for _, a in pairs { "N", "E", "S", "W" } do
	pd[a] = { icon = m .. "/graphics/pipe_indication_" .. a .. ".png", icon_size = 32 }
	ps[a] = { icon = m .. "/graphics/pipe_indication_shadow_" .. a .. ".png", icon_size = 32 }
	pdv[a] = { icon = m .. "/graphics/pipe_indication_" .. a .. ".png", icon_size = 32, tint = { r = 0.6, g = 0, b = 0.6 } }
end

for _, o in pairs( data.raw["pipe"] ) do
	if not Senpais.Pipes.NOCOPYS[o.name] then
		local on = 0
		
		sn = sn + 1
		
		if sn < 10 then sp = "0" else sp = "" end
		
		data:extend
		{
			{
				type = "item-subgroup",
				name = "pipe-subgroup-" .. sp .. sn,
				group = "Senpais-Pipes",
				order = sp .. sn
			}
		}
		
		for s, b in pairs( Senpais.Pipes.Directions ) do
			on = on + 1
			
			if on < 10 then op = "0" else op = "" end
			
			local np = util.table.deepcopy( data.raw["pipe"][o.name] )
			np.name = o.name .. "-" .. s
			np.icon = nil
			np.icon_size = nil
			np.icon_mipmap = nil
			np.icons = { { icon = o.icon, icon_size = o.icon_size or nil, icon_mipmap = o.icon_mipmap or nil } }
			np.subgroup = "pipe-subgroup-" .. sp .. sn
			np.order = "pipe-" .. op .. on
			np.fluid_box = { base_area = o.fluid_box.base_area, pipe_connections = b.connec }
			np.localised_name = { "entity-name.Senpais-Pipes", {"entity-name." .. o.name }, { "Senpais-Pipes." .. s } }
			np.placeable_by = { item = o.name, count = o.minable and o.minable.count or 1 }

			--[[if o.icon_size then
				np.icons[1].icon_size = o.icon_size
			end

			if o.icon_mipmap then
				np.icons[1].icon_mipmap = o.icon_mipmap
			end]]

			if s == "void" then
				np.type = "infinity-pipe"
				np.gui_mode = "none"
				table.insert( np.icons, { icon = m .. "/graphics/pipe_indication_void.png", icon_size = 32 } )
				for _, name in pairs( c ) do
					np.pictures[name] = { layers = { np.pictures[name], void_icon } }
				end
			else
				local texture = o.pictures[b.tex]
				if s:find( "void" ) then
					np.type = "infinity-pipe"
					np.gui_mode = "none"
					for _, name in pairs( c ) do
						np.pictures[name] = { layers = { texture, void_icon } }
					end
					if s:find( "N" ) then
						table.insert( np.icons, pdv.N )
					end
					if s:find( "E" ) then
						table.insert( np.icons, pdv.E )
					end
					if s:find( "S" ) then
						table.insert( np.icons, pdv.S )
					end
					if s:find( "W" ) then
						table.insert( np.icons, pdv.W )
					end
				else
					for _, name in pairs( c ) do
						np.pictures[name] = texture
					end
					if s:find( "N" ) then
						table.insert( np.icons, pd.N )
					end
					if s:find( "E" ) then
						table.insert( np.icons, pd.E )
					end
					if s:find( "S" ) then
						table.insert( np.icons, pd.S )
					end
					if s:find( "W" ) then
						table.insert( np.icons, pd.W )
					end
				end
			end
			table.insert( pe, np )
		end
	end
end
for u = 1, table_size( pe ) do
	data:extend{ pe[u] }
end