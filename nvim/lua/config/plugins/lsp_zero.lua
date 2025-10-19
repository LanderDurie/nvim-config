return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{
						name = "nvim_lsp",
						keyword_length = 2,
						max_item_count = 20,
						entry_filter = function(entry, ctx)
							local kind = entry:get_kind()
							-- Filter out Constant kind (like M_2_PIf128)
							if kind == 21 then
								return false
							end

							local word = entry:get_word()
							-- Filter out complex template functions when typing simple letters
							if string.find(word, "::make_") or string.find(word, "std::") then
								-- Only show std functions if we've explicitly typed "std::"
								local line = vim.api.nvim_get_current_line()
								local col = vim.api.nvim_win_get_cursor(0)[2]
								local text_before_cursor = line:sub(1, col)
								if not string.find(text_before_cursor, "std::") then
									return false
								end
							end
							return true
						end,
					},
					{ name = "buffer" },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.score,
						cmp.config.compare.locality,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
						cmp.config.compare.offset,
						cmp.config.compare.order,
					},
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
				},
			})
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			vim.lsp.set_log_level("OFF")
			local lsp_zero = require("lsp-zero")

			-- LSP keymaps
			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 2 },
				signs = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Mason setup
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"pyright",
					"jdtls",
					"ts_ls",
					"sqlls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				cpp = { "clang_format" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				sql = { "sqlfluff" },
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
