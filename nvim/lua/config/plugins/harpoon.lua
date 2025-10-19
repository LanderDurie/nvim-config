return {
	{
		"ThePrimeagen/harpoon",
		lazy = false, -- load immediately
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			-- Keymaps for Harpoon
			vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon add file" })
			vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon toggle menu" })
			vim.keymap.set("n", "<leader>h1", function()
				ui.nav_file(1)
			end, { desc = "Harpoon go to file 1" })
			vim.keymap.set("n", "<leader>h2", function()
				ui.nav_file(2)
			end, { desc = "Harpoon go to file 2" })
			vim.keymap.set("n", "<leader>h3", function()
				ui.nav_file(3)
			end, { desc = "Harpoon go to file 3" })
			vim.keymap.set("n", "<leader>h4", function()
				ui.nav_file(4)
			end, { desc = "Harpoon go to file 4" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "ThePrimeagen/harpoon" },
		config = function()
			local lualine = require("lualine")
			local harpoon = require("harpoon.mark")

			-- Function to display the number of Harpoon marks
			local function harpoon_count()
				local marks = harpoon.get_mark_config().marks or {}
				return #marks > 0 and "H:" .. #marks or ""
			end

			-- Basic Lualine setup
			lualine.setup({
				options = {
					theme = "auto",
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { harpoon_count },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
