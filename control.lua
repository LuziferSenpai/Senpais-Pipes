require "mod-gui"

local F = require "functions"
local de = defines.events

script.on_init( function()
	F.Globals()
	F.Players()
end )

script.on_configuration_changed( function() 
	F.Globals()
	F.Players()
end )

script.on_event( de.on_gui_click, function( ee )
	local e = ee.element
	local n = e.name
	local i = ee.player_index
	local p = game.players[i]
	local pa = e.parent or nil

	if not n or not pa then return end

	local m = mod_gui.get_frame_flow( p )

	if pa.name == "SenpaisPipesTable01" then
		m.SenpaisPipesFrame01.destroy()
		local ni = p.cursor_stack.name
		if n == "SenpaisPipesSpriteButton01" then
			global.PlayerDATA[i].v = false
			F.GUI( m, ni, false )
		else
			global.PlayerDATA[i].v = true
			F.GUI( m, ni, true )
		end
		return
	end
	if pa.name == "SenpaisPipesTable02" then
		for _, c in pairs( pa.children ) do
			c.style = "Senpais-Pipes-Button"
		end
		e.style = "Senpais-Pipes-Button-active"
		global.PlayerDATA[i].cs = n
		return
	end
end )

script.on_event( de.on_player_created, function( ee )
	global.PlayerDATA[ee.player_index] = { cs = "", v = false, ni = "" }
end )

script.on_event( de.on_player_cursor_stack_changed, function( ee )
	local i = ee.player_index
	local p = game.players[i]
	local m = mod_gui.get_frame_flow( p )

	if p.cursor_stack and p.cursor_stack.valid and p.cursor_stack.valid_for_read then
		local ni = p.cursor_stack.name
		if ni ~= global.PlayerDATA[i].ni and game.entity_prototypes[ni] and game.entity_prototypes[ni].type == "pipe" then
			global.PlayerDATA[i] = { cs = ni, v = false, ni = ni }

			if m.SenpaisPipesFrame01 then m.SenpaisPipesFrame01.destroy() end

			F.GUI( m, ni, false )
		end
	else
		global.PlayerDATA[i] = { cs = "", v = false, ni = "" }

		if m.SenpaisPipesFrame01 then m.SenpaisPipesFrame01.destroy() end
	end
end )

script.on_event( de.on_built_entity, function( ee )
	local i = ee.player_index
	local p = game.players[i]
	local e = ee.created_entity
	local n = e.name
	local d = global.PlayerDATA[i]

	if d.ni ~= "" and n ~= d.cs then
		local po = e.position
		local f = e.force
		local s = e.surface

		e.destroy()

		local ne = s.create_entity{ name = d.cs, position = po, force = f }
		if d.v then
			table.insert( global.VoidPipes, ne )
		end
	end
end )

script.on_event( defines.events.on_tick, function( event )
	if #global.VoidPipes > 0 and event.tick % ( game.speed * 60 ) == 0 then
		for o, p in pairs( global.VoidPipes ) do
			if p.valid then
				p.fluidbox[1] = nil
			else
				table.remove( global.VoidPipes, o )
			end
		end
	end
end )