return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"nvim-telescope/telescope.nvim",
			{ "folke/neodev.nvim", opts = {} },
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})

			local builtin = require("telescope.builtin")
			---@diagnostic disable-next-line: unused-local
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.buffer_autoformat()

				local nmap = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
				nmap("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
				nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")

				nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", builtin.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			end)

			local lspconfig = require("lspconfig")

			local configs = require("lspconfig.configs")
			local util = require("lspconfig.util")

			local root_file = {
				".xo-config",
				".xo-config.json",
				".xo-config.js",
				"xo.config.js",
				".xo-config.cjs",
				"xo.config.cjs",
			}
			if not configs.xo then
				configs.xo = {
					default_config = {
						cmd = { "xo", "--reporter", "json", "--stdin" },
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						root_dir = function(fname)
							root_file = util.insert_package_json(root_file, "xo", fname)
							return util.root_pattern(unpack(root_file))(fname)
						end,
						settings = {},
					},
				}
			end
			lspconfig.xo.setup({})

			local on_init_no_format = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentFormattingRangeProvider = false
			end

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"jsonls",
					"denols",
					"eslint",
					"svelte",
				},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						lspconfig.lua_ls.setup(lua_opts)
					end,
					tsserver = function()
						lspconfig.tsserver.setup({
							root_dir = lspconfig.util.root_pattern("tsconfig.json"),
							single_file_support = false,
							on_init = on_init_no_format,
						})
					end,
					jsonls = function()
						lspconfig.jsonls.setup({
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,
					denols = function()
						lspconfig.denols.setup({
							root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
							on_init = on_init_no_format,
						})
					end,
					eslint = function()
						lspconfig.eslint.setup({
							---@diagnostic disable-next-line: unused-local
							on_attach = function(client, bufnr)
								vim.api.nvim_create_autocmd("BufWritePre", {
									buffer = bufnr,
									command = "EslintFixAll",
								})
							end,
						})
					end,
					svelte = function()
						lspconfig.svelte.setup({
							on_init = on_init_no_format,
						})
					end,
				},
			})

			vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP: Restart" })
		end,
	},
}
