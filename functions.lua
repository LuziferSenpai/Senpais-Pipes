local functions = {}
functions.directions = { "E-N-S", "E-S", "E-W", "N-E", "N-E-W", "N-S", "N-W", "S-W", "S-W-E", "W-N-S" }

function functions.globals()
	global.PlayerDATA = global.PlayerDATA or {}
	global.Pipes = {}
	for _, item in pairs( game.item_prototypes ) do
		if game.entity_prototypes[item.name] and game.entity_prototypes[item.name].type == "pipe" then
			table.insert( global.Pipes, item.name )
			game.print( item.name )
		end
	end
end

function functions.Players()
	for _, p in pairs( game.players ) do
		global.PlayerDATA[p.index] = { currentselected = "", void = false, item_name = "" }
	end
end

function functions.GUI( player, name, void )
	local style = "Senpais-Pipes-Button"
	local A01 = functions.Add_Frame( player, "SenpaisPipesFrame" )
	local A02 = { functions.Add_Table( A01, "SenpaisPipesTable01", 2 ),
				  functions.Add_Table( A01, "SenpaisPipesTable02", 2 ) }
	local A03 = { functions.Add_Sprite_Button( A02[1], "SenpaisPipesSpriteButton01", "entity/" .. name, style ),
				  functions.Add_Sprite_Button( A02[1], "SenpaisPipesSpriteButton02", "entity/" .. name .. "-void", style ) }
	if void then
		A03[2].style = "Senpais-Pipes-Button-active"
		style = "Senpais-Pipes-Button-active"
	else
		A03[1].style = "Senpais-Pipes-Button-active"
	end
	for p = 1, #functions.directions do
		if void then
			local A04 = functions.Add_Sprite_Button( A02[2], "SenpaisPipesSpriteButton03" .. p, "entity/" .. name .. "-" .. functions.directions[p] .. "-void", style )
		else
			local A04 = functions.Add_Sprite_Button( A02[2], "SenpaisPipesSpriteButton03" .. p, "entity/" .. name .. "-" .. functions.directions[p], style )
		end
	end
end

function functions.Add_Frame( flow, name, style )
	return flow.add{ type = "frame", name = name, direction = "vertical", style = style or nil }
end

function functions.Add_Table( flow, name, column_count )
	return flow.add{ type = "table", name = name, column_count = column_count, style = "Senpais-Pipe-Table" }
end

function functions.Add_Sprite_Button( flow, name, sprite, style )
	return flow.add{ type = "sprite-button", name = name, style = style or nil, sprite = sprite }
end

return functions