-- Find config.lua in your runtime path
local config_files = vim.api.nvim_get_runtime_file("lua/config/config.lua", false)
local config_file = config_files[1]

if config_file then
	local handle = vim.uv.new_fs_event()

	local function watch_config()
		handle:start(config_file, {}, function(err, filename, events)
			if err then
				return
			end

			-- Stop the watcher
			handle:stop()

			vim.schedule(function()
				package.loaded["config.config"] = nil
				local config = require("config.config")
				package.loaded["config.utils.config_utils"] = nil
				local utils = require("config.utils.config_utils")

				if utils.LoadExternalColors(config) and config.colorscheme then
					vim.cmd.colorscheme(config.colorscheme)
				else
					if not utils.LoadCustomColors(config) then
						vim.cmd.colorscheme("tokyonight")
					end
				end

				-- Restart the watcher
				watch_config()
			end)
		end)
	end

	-- Start watching
	watch_config()
end
