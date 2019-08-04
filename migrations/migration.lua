game.reload_script()

for _, s in pairs( game.surfaces ) do
	local tt = s.find_entities_filtered{ type = "pipe" }
	for _, e in pairs( tt ) do
		local n = e.name
		local t = e.type
		local g = false
		if n == "entity-ghost" then
			n = e.ghost_name
			t = e.ghost_type
			g = true
		end
		if n:find( "void" ) then
			local f = e.force
			local p = e.position
			local en = ""
			if game.entity_prototypes[n].type ~= t then
				e.destroy()
				if g then
					en = s.create_entity{ name = "entity-ghost", inner_name = n, position = p, force = f }
				else
					en = s.create_entity{ name = n, position = p, force = f }
				end
			end
		end
	end
end