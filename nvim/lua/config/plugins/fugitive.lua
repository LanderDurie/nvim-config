return {
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"G",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Git log<CR>", desc = "Git log" },
		},
		config = function()
			vim.g.fugitive_gitlab_domains = { "https://gitlab.com" }
		end,
	},
}
