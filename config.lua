Senpais = Senpais or {}
Senpais.Pipes = Senpais.Pipes or {}
Senpais.Pipes.Directions = {}
Senpais.Pipes.NOCOPYS = {}

Senpais.Pipes.Directions["void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } },
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = nil
}

Senpais.Pipes.Directions["E-N-S"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } },
		{ position = { 0, 1 } }
	},
	tex = "t_right"
}

Senpais.Pipes.Directions["E-S"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { 0, 1 } }
	},
	tex = "corner_down_right"
}

Senpais.Pipes.Directions["E-W"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { -1, 0 } }
	},
	tex = "straight_horizontal"
}

Senpais.Pipes.Directions["N-E"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } }
	},
	tex = "corner_up_right"
}

Senpais.Pipes.Directions["N-E-W"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } },
		{ position = { -1, 0 } }
	},
	tex = "t_up"
}

Senpais.Pipes.Directions["N-S"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 0, 1 } }
	},
	tex = "straight_vertical"
}

Senpais.Pipes.Directions["N-W"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { -1, 0 } }
	},
	tex = "corner_up_left"
}

Senpais.Pipes.Directions["S-W"] =
{
	connec =
	{
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "corner_down_left"
}

Senpais.Pipes.Directions["S-W-E"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "t_down"
}

Senpais.Pipes.Directions["W-N-S"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "t_left"
}

Senpais.Pipes.Directions["E-N-S-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } },
		{ position = { 0, 1 } }
	},
	tex = "t_right"
}

Senpais.Pipes.Directions["E-S-void"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { 0, 1 } }
	},
	tex = "corner_down_right"
}

Senpais.Pipes.Directions["E-W-void"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { -1, 0 } }
	},
	tex = "straight_horizontal"
}

Senpais.Pipes.Directions["N-E-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } }
	},
	tex = "corner_up_right"
}

Senpais.Pipes.Directions["N-E-W-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 1, 0 } },
		{ position = { -1, 0 } }
	},
	tex = "t_up"
}

Senpais.Pipes.Directions["N-S-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 0, 1 } }
	},
	tex = "straight_vertical"
}

Senpais.Pipes.Directions["N-W-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { -1, 0 } }
	},
	tex = "corner_up_left"
}

Senpais.Pipes.Directions["S-W-void"] =
{
	connec =
	{
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "corner_down_left"
}

Senpais.Pipes.Directions["S-W-E-void"] =
{
	connec =
	{
		{ position = { 1, 0 } },
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "t_down"
}

Senpais.Pipes.Directions["W-N-S-void"] =
{
	connec =
	{
		{ position = { 0, -1 } },
		{ position = { 0, 1 } },
		{ position = { -1, 0 } }
	},
	tex = "t_left"
}

Senpais.Pipes.NOCOPYS["factory-fluid-dummy-connector"] = true
Senpais.Pipes.NOCOPYS["factory-fluid-dummy-connector-south"] = true