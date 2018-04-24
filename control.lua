require( "mod-gui" )
require( "functions" )
require( "config" )

local directions = { "E-N-S", "E-S", "E-W", "N-E", "N-E-W", "N-S", "N-W", "S-W", "S-W-E", "W-N-S" }

script.on_init( function()
	Senpais_Pipes_globals()
	Senpais_Pipes_Players()
end )

script.on_configuration_changed( function() 
	Senpais_Pipes_globals()
	Senpais_Pipes_Players()
end )