--[[
#H    Hostname of local host
#h    Hostname of local host without the domain name
#F    Current window flag
#I    Current window index
#S    Session name
#W    Current window name
#(shell-command)  First line of the command's output

string will be passed through strftime(3) before being used.
--]]

local presets = {
	default = {
		a = { "#S" },
		--b = { "#h" },
		--c = "",
		win = { "#I", "#W" },
		cwin = { "#I", "#W" },
		x = { "#(~/.dotfiles/bin/disk.sh)", "#(~/.dotfiles/bin/battery.sh)" },
		y = "%Y-%m-%d",
		z = "%I:%M %p",
		options = {
			["status-justify"] = "left",
		},
	},
}

local separators = {
	slash = {
		left_sep = "",
		left_alt_sep = "",
		right_sep = "",
		right_alt_sep = "",
		space = " ",
	},
	arrows = {
		left = "",
		left_alt = "",
		right = "",
		right_alt = "",
		space = " ",
	},
	airline = {
		left = vim.g.airline_left_sep,
		left_alt = vim.g.airline_left_alt_sep,
		right = vim.g.airline_right_sep,
		right_alt = vim.g.airline_right_alt_sep,
		space = " ",
	},
}

--[[
values represent: [ FG, BG, ATTR ]
  FG ang BG are color codes
  ATTR (optional) is a comma-delimited string of one or more of bold,
  dim, underscore, etc. For details refer to the STYLE section in the tmux man page
--]]

local themes = {
  ansi = {
		bg = { "black", "black" },
		a = { "white", "blue" },
		b = { "black", "gray" },
		c = { "white", "black" },
		win = { "black", "brightblack" },
		cwin = { "black", "white" },
		x = { "white", "black" },
		y = { "black", "brightblack" },
		z = { "white", "blue" },
  },
	solarized = {
		bg = { 7, 8 },
		a = { 7, 4 },
		b = { 7, 10 },
		c = { 7, 0 },
		win = { 10, 0 },
		cwin = { 7, 10 },
		x = { 7, 0 },
		y = { 7, 10 },
		z = { 7, 4 },
	},
	monokai_pro = {
		bg = { "white", "black" },
		a = { "white", "blue" },
		b = { "white", "lightgreen" },
		c = { "white", "black" },
		win = { "lightgreen", "darkgray" },
		cwin = { "white", "lightgreen" },
		x = { "white", "black" },
		y = { "white", "lightgreen" },
		z = { "white", "blue" },
	},
  material = {
		bg = { "white", "black" },
		a = { "white", "blue" },
		b = { "white", "lightgreen" },
		c = { "white", "black" },
		win = { "lightgreen", "darkgray" },
		cwin = { "white", "lightgreen" },
		x = { "white", "black" },
		y = { "white", "lightgreen" },
		z = { "white", "blue" },
  }
}

vim.g.tmuxline_preset = presets.default
vim.g.tmuxline_separators = separators.arrows
vim.g.tmuxline_theme = themes.solarized
