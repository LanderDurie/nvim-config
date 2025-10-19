local M = {}

-- Edit the config file in Neovim
function M.EditConfig()
	vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/config/config.lua")
end

-- Load external colorschemes
function M.LoadExternalColors(config)
	for _, spec in ipairs(require("config.colors.external")) do
		local repo = spec[1]
		if repo:find(config.colorscheme, 1, true) ~= nil then
			return spec
		end
	end
	return nil
end

-- Load a custom colorscheme if selected
function M.LoadCustomColors(config)
	for _, file in ipairs(vim.fn.glob("lua/config/colors/*.lua", true, true)) do
		local fname = vim.fn.fnamemodify(file, ":t:r")
		if fname ~= "external" and fname == config.colorscheme then
			local ok, colorspec = pcall(require, "config.colors." .. config.colorscheme)
			if ok and colorspec.config then
				colorspec.config() -- apply highlights
				return colorspec
			end
		end
	end
	return nil
end

-- Load other plugins based on config.plugins
function M.LoadPlugins(config)
	local specs = {}
	for plugin_name, enabled in pairs(config.plugins) do
		if enabled then
			local ok, plugin_specs = pcall(require, "config.plugins." .. plugin_name)
			if ok then
				for _, p in ipairs(plugin_specs) do
					table.insert(specs, p)
				end
			end
		end
	end
	return specs
end

return M
