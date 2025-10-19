-- Central configuration for plugins and colors

local M = {}

-- Select colorscheme
M.colorscheme = "rose-pine"

-- Enable/disable plugins
M.plugins = {
	mini = true,
	telescope = true,
	treesitter = true,
	harpoon = true,
	undotree = true,
	fugitive = true,
	lsp_zero = true,
	indent_blankline = true,
	web_devicons = true,
	toggleterm = true,
	completion = true,
}

return M
