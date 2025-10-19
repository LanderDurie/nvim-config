return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<C-\>]],
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				persist_size = true,
				direction = "horizontal",
			})

			vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
			vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:close<CR>]], { desc = "Exit terminal mode and close terminal" })
		end,
	},
}
