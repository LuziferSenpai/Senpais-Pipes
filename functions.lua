local F = {}
F.D = { "E-N-S", "E-S", "E-W", "N-E", "N-E-W", "N-S", "N-W", "S-W", "S-W-E", "W-N-S" }

F.Globals = function()
	global.PlayerDATA = global.PlayerDATA or {}
	global.Pipes = {}
	global.VoidPipes = global.VoidPipes or {}
	for _, item in pairs( game.item_prototypes ) do
		if game.entity_prototypes[item.name] and game.entity_prototypes[item.name].type == "pipe" then
			table.insert( global.Pipes, item.name )
		end
	end
end

F.Players = function()
	for _, p in pairs( game.players ) do
		global.PlayerDATA[p.index] = { cs = "", v = false, ni = "" }
	end
end

F.GUI = function( p, n, v )
	local A01 = F.AddFrame( p, "SenpaisPipesFrame01" )
	local A02 =
	{
		F.AddTable( A01, "SenpaisPipesTable01", 2 ),
		F.AddFrame( A01, "SenpaisPipesFrame02", "image_frame" )
	}
	local A03 =
	{
		F.AddSpriteButton( A02[1], "SenpaisPipesSpriteButton01", "entity/" .. n ),
		F.AddSpriteButton( A02[1], "SenpaisPipesSpriteButton02", "entity/" .. n .. "-void" ),
		F.AddTable( A02[2], "SenpaisPipesTable02", 3 )
	}
	if v then
		A03[2].style = "Senpais-Pipes-Button-active"
		local A04 = F.AddSpriteButton( A03[3], n .. "-void", "entity/" .. n .. "-void" )
	else
		A03[1].style = "Senpais-Pipes-Button-active"
		local A04 = F.AddSpriteButton( A03[3], n, "entity/" .. n )
	end
	for p = 1, #F.D do
		local d = F.D[p]
		if v then
			local A05 = F.AddSpriteButton(A03[3], n .. "-" .. d .. "-void",  "entity/" .. n .. "-" .. d .. "-void" )
		else
			local A05 = F.AddSpriteButton(A03[3], n .. "-" .. d,  "entity/" .. n .. "-" .. d )
		end
	end
end

F.AddFrame = function( f, n, s )
	return f.add{ type = "frame", name = n, direction = "vertical", style = s or nil }
end

F.AddTable = function( f, n, c )
	return f.add{ type = "table", name = n, column_count = c, style = "Senpais-Pipe-Table" }
end

F.AddSpriteButton = function( f, n, s )
	return f.add{ type = "sprite-button", name = n, style = "Senpais-Pipes-Button", sprite = s }
end

return F