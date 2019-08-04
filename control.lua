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
	local id = ee.player_index
	local p = game.players[id]
	local pa = e.parent or nil

	if not n or not pa then return end

	local m = p.gui.left
	local G = global.GUIS[id]

	if next( G ) then
		if pa.name == "SenpaisPipesTable01" then
			G.A01.destroy()
			local ni = p.cursor_stack.name
			if n == "SenpaisPipesSpriteButton01" then
				F.GUI( m, ni, false, id )
			else
				F.GUI( m, ni, true, id )
			end
		elseif pa.name == "SenpaisPipesTable02" then
			for _, c in pairs( pa.children ) do
				c.style = "Senpais-Pipes-Button"
			end
			e.style = "Senpais-Pipes-Button-active"
			G.A02[3].caption = n
			global.GUIS[id] = G
		end
	end
end )
script.on_event( de.on_player_created, function( ee )
	local id = ee.player_index
	global.GUIS[id] = global.GUIS[id] or {}
end )
script.on_event( de.on_player_cursor_stack_changed, function( ee )
	local id = ee.player_index
	local p = game.players[id]
	local m = p.gui.left

	if p.cursor_stack and p.cursor_stack.valid and p.cursor_stack.valid_for_read then
		local ni = p.cursor_stack.name

		if global.Pipes[ni] then
			local G = global.GUIS[id]

			if next( G ) then
				if G.A02[4].caption ~= ni then
					G.A01.destroy()
					F.GUI( m, ni, false, id )
				end
			else
				F.GUI( m, ni, false, id )
			end
		else
			if next( global.GUIS[id] ) then global.GUIS[id].A01.destroy() end
			global.GUIS[id] = {}
		end
	else
		if next( global.GUIS[id] ) then global.GUIS[id].A01.destroy() end
		global.GUIS[id] = {}
	end
end )
script.on_event( de.on_built_entity, function( ee )
	local id = ee.player_index
	local G = global.GUIS[id]
	local e = ee.created_entity

	if next( G ) and e.valid then
		local po = e.position
		local f = e.force
		local s = e.surface
		local ni = G.A02[3].caption
		local en = ""
		local n = e.name

		e.destroy()

		if n == "entity-ghost" then
			en = s.create_entity{ name = "entity-ghost", inner_name = ni, position = po, force = f, player = id }
		else
			en = s.create_entity{ name = ni, position = po, force = f, player = id }
		end
	end
end )