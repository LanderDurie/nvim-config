return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false, -- load immediately on startup
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				ensure_installed = {
					"c",
					"cpp",
					"javascript",
					"typescript",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				highlight = {
					enable = true,

					-- Set to true to run both `:syntax` and tree-sitter highlighting
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
