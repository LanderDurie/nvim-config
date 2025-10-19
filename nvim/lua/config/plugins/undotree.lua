return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle", -- load only when this command is called
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
		},
		config = function()
			-- Optional: make undo history persistent between sessions
			vim.opt.undofile = true
			vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

			-- Optional: tweak behavior
			vim.g.undotree_SplitWidth = 40
			vim.g.undotree_SetFocusWhenToggle = true
			vim.g.undotree_WindowLayout = 2 -- layout: diff on the right side
		end,
	},
}
