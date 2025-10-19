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

local vim_inspect = require("vim.inspect")

local config = require("config.config")
local utils = require("config.utils.config_utils")

local conf = utils.LoadPlugins(config)
table.insert(conf, { import = "config.colors.external" })

print(vim_inspect(conf))

require("lazy").setup(conf, {
	checker = { enabled = true },
	rocks = { enabled = false },
})

-- Load centralized config
local colorscheme = utils.LoadExternalColors(config)

if colorscheme and config.colorscheme then
	vim.cmd.colorscheme(config.colorscheme)
else
	if not utils.LoadCustomColors(config) then
		vim.cmd.colorscheme("tokyonight")
	end
end
