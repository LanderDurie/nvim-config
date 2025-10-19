-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "config.plugins" },
	{ import = "config.colors.external" },
}, {
	checker = { enabled = true },
	rocks = { enabled = false },
})

-- Load centralized config

--local specs = {}

--vim.list_extend(specs, utils.LoadPlugins(config))

local config = require("config.config")
local utils = require("config.utils.config_utils")
local spec = utils.LoadExternalColors(config)

if spec and config.colorscheme then
	vim.cmd.colorscheme(config.colorscheme)
else
	if not utils.LoadCustomColors(config) then
		vim.cmd.colorscheme("tokyonight")
	end
end
