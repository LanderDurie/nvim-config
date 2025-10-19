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
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
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
				-- === Core navigation ===
				vim.keymap.set("n", "H", vim.lsp.buf.hover, { desc = "Show documentation", buffer = bufnr })
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "List references", buffer = bufnr })
				vim.keymap.set(
					"n",
					"<leader>gt",
					vim.lsp.buf.type_definition,
					{ desc = "Go to type definition", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>gi",
					vim.lsp.buf.implementation,
					{ desc = "Go to implementation", buffer = bufnr }
				)

				-- === Refactor / edit ===
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
				vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer", buffer = bufnr })

				-- === Highlight references ===
				vim.keymap.set(
					"n",
					"<leader>hh",
					vim.lsp.buf.document_highlight,
					{ desc = "Highlight symbol references", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>hc",
					vim.lsp.buf.clear_references,
					{ desc = "Clear symbol highlights", buffer = bufnr }
				)
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
