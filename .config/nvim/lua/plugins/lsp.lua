return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"nvim-telescope/telescope.nvim",
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
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config

			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
			})

			local builtin = require("telescope.builtin")
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local nmap = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
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
				end,
			})

			vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP: Restart" })

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"jsonls",
					"denols",
					"eslint",
					"svelte",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					ts_ls = function()
						lspconfig.ts_ls.setup({
							root_dir = lspconfig.util.root_pattern("tsconfig.json"),
							single_file_support = false,
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
				},
			})
		end,
	},
}
