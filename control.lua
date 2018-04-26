require "mod-gui"
require "config"

local functions = require "functions"

script.on_init( function()
	functions.globals()
	functions.Players()
	local pipes = {}
	for _, entity in pairs( game.entity_prototypes ) do
		if entity.type == "pipe" then
			table.insert( pipes, entity.name )
		end
	end
	game.write_file( "test/pipes.txt", serpent.block( pipes ) )
end )

script.on_configuration_changed( function() 
	functions.globals()
	functions.Players()
end )

script.on_event( defines.events.on_gui_click, function( event )
	local element = event.element
	local name = element.name
	local player = game.players[event.player_index]
	local parent = element.parent or nil

	if not name then return end
	if not parent then return end
	if parent.name == "SenpaisPipesTable01" then
		mod_gui.get_frame_flow( player ).SenpaisPipesFrame.destroy()
		local item_name = player.cursor_stack.name
		if name == "SenpaisPipesSpriteButton01" then
			global.PlayerDATA[player.index].void = false
			functions.GUI( mod_gui.get_frame_flow( player ), item_name, false )
		else
			global.PlayerDATA[player.index].void = true
			functions.GUI( mod_gui.get_frame_flow( player ), item_name, true )
		end
		return
	end
	if parent.name == "SenpaisPipesTable02" then
		for _, child in pairs( parent.children ) do
			child.style = "Senpais-Pipes-Button"
		end
		element.style = "Senpais-Pipes-Button-active"
		if element.name == "SenpaisPipesSpriteButton030" then
			global.PlayerDATA[player.index].currentselected = ""
			break
		else
			for u = 1, #functions.directions do
				if element.name == "SenpaisPipesSpriteButton03" .. u then
					global.PlayerDATA[player.index].currentselected = functions.directions[u]
					break
				end
			end
		end
	end
end )

script.on_event( defines.events.on_player_created, function( event )
	global.PlayerDATA[game.players[event.player_index].index] = { currentselected = "", void = false, item_name = "" }
end )

script.on_event( defines.events.on_player_cursor_stack_changed, function( event )
	local player = game.players[event.player_index]
	local item_name = player.cursor_stack.name
	if mod_gui.get_frame_flow( player ).SenpaisPipesFrame then mod_gui.get_frame_flow( player ).SenpaisPipesFrame.destroy() end
	global.PlayerDATA[player.index] = { currentselected = "", void = false, item_name = item_name }
	if game.entity_prototypes[item_name] and game.entity_prototypes[item_name].type == "pipe" then
		functions.GUI( mod_gui.get_frame_flow( player ), item_name, false )
	end
end )

script.on_event( defines.events.on_built_entity, function( event )
	local player = game.players[event.player_index]
	if global.PlayerDATA[player.index].item_name ~= "" then
		local entity = event.created_entity
		local position = entity.position
		local force = entity.force
		local name = item_name
		local surface = entity.surface
		entity.destroy()
		if global.PlayerDATA[player.index].currentselected ~= "" then
			name = name .. "-" .. global.PlayerDATA[player.index].currentselected
		end
		if global.PlayerDATA[player.index].void then
			name = name .. "-void"
		end
		surface.create_entity{ name = name, position = position, force = force }
	end
end )