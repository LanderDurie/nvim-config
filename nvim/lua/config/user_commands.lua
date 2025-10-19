vim.api.nvim_create_user_command("LConfig", function()
	require("config.utils.config_utils").EditConfig()
end, { desc = "Edit Neovim config.lua" })

vim.api.nvim_create_user_command("LTheme", function(opts)
	local theme = opts.args
	if theme == "" then
		print("Usage: LSetTheme <colorscheme_name>")
		return
	end

	-- Update the config file
	local config_file = vim.api.nvim_get_runtime_file("lua/config/config.lua", false)[1]
	if not config_file then
		print("Config file not found!")
		return
	end

	-- Read the file
	local lines = vim.fn.readfile(config_file)

	-- Find and replace the colorscheme line
	for i, line in ipairs(lines) do
		if line:match("^M%.colorscheme%s*=%s*") then
			lines[i] = 'M.colorscheme = "' .. theme .. '"'
			break
		end
	end

	-- Write back
	vim.fn.writefile(lines, config_file)
end, { nargs = 1, desc = "Set colorscheme in config.lua" })
