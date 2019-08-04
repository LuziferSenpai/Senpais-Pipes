require "config"
local F = {}
F.D =
{
	["E-N-S"] = true,
	["E-S"] = true,
	["E-W"] = true,
	["N-E"] = true,
	["N-E-W"] = true,
	["N-S"] = true,
	["N-W"] = true,
	["S-W"] = true,
	["S-W-E"] = true,
	["W-N-S"] = true
}
F.Globals = function()
	global.Pipes = {}
	global.GUIS = global.GUIS or {}
	for _, e in pairs( game.entity_prototypes ) do
		local n = e.name
		if not Senpais.Pipes.NOCOPYS[n] and e.type == "pipe" then
			if n:find( "void" ) then
				return
			else
				for d, _ in pairs( F.D ) do
					if n:find( d ) then
						return
					end
				end
			end
			global.Pipes[n] = true
		end
	end
end
F.Players = function()
	for _, p in pairs( game.players ) do
		global.GUIS[p.index] = global.GUIS[p.index] or {}
	end
end
F.GUI = function( p, n, v, id )
	local G = {}
	G.A01 = F.AddFrame( p, "SenpaisPipesFrame01" )	
	G.A02 =
	{
		F.AddTable( G.A01, "SenpaisPipesTable01", 2 ),
		F.AddFrame( G.A01, "SenpaisPipesFrame02", "image_frame" ),
		F.AddLabel( G.A01, "SenpaisPipesLabelWithDirection", n ),
		F.AddLabel( G.A01, "SenpaisPipesLabelWithoutDirection", n )
	}
	G.A02[3].visible = false
	G.A02[4].visible = false
	G.A03 =
	{
		F.AddSpriteButton( G.A02[1], "SenpaisPipesSpriteButton01", "entity/" .. n ),
		F.AddSpriteButton( G.A02[1], "SenpaisPipesSpriteButton02", "entity/" .. n .. "-void" ),
		F.AddTable( G.A02[2], "SenpaisPipesTable02", 3 )
	}
	if v then
		G.A03[2].style = "Senpais-Pipes-Button-active"
		G.A04 = F.AddSpriteButton( G.A03[3], n .. "-void", "entity/" .. n .. "-void" )
	else
		G.A03[1].style = "Senpais-Pipes-Button-active"
		G.A04 = F.AddSpriteButton( G.A03[3], n, "entity/" .. n )
	end
	for d, _ in pairs( F.D ) do
		if v then
			G.A05 = F.AddSpriteButton( G.A03[3], n .. "-" .. d .. "-void",  "entity/" .. n .. "-" .. d .. "-void" )
		else
			G.A05 = F.AddSpriteButton( G.A03[3], n .. "-" .. d,  "entity/" .. n .. "-" .. d )
		end
	end
	global.GUIS[id] = G
end
F.AddFrame = function( f, n, s )
	return f.add{ type = "frame", name = n, direction = "vertical", style = s or nil }
end
F.AddLabel = function( f, n, c )
	return f.add{ type = "label", name = n, caption = c }
end
F.AddTable = function( f, n, c )
	return f.add{ type = "table", name = n, column_count = c, style = "Senpais-Pipe-Table" }
end
F.AddSpriteButton = function( f, n, s )
	return f.add{ type = "sprite-button", name = n, style = "Senpais-Pipes-Button", sprite = s }
end

return F