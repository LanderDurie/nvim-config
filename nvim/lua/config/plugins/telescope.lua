return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		priority = 1000,
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Telescope defaults
			telescope.setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "smart" },
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = { preview_width = 0.6 },
					},
					file_ignore_patterns = { "node_modules", "%.lock" },
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({ no_ignore = false })
			end, { desc = "Find all files (including untracked)" })

			vim.keymap.set("n", "<leader>pg", function()
				builtin.git_files({ show_untracked = true })
			end, { desc = "Find Git files (tracked + untracked)" })

			vim.keymap.set("n", "<leader>ps", function()
				builtin.live_grep({ cwd = vim.fn.getcwd() })
			end, { desc = "Grep in all files" })

			vim.keymap.set("n", "<leader>pd", function()
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if not git_root or git_root == "" then
					vim.notify("Not inside a Git repository", vim.log.levels.WARN)
					return
				end
				builtin.live_grep({ cwd = git_root })
			end, { desc = "Grep in Git files (tracked + untracked)" })
		end,
	},
}
