---@diagnostic disable: unused-local
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
			"saghen/blink.cmp",
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

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

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

			---@diagnostic disable-next-line: missing-fields
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"denols",
					"jsonls",
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
					denols = function()
						lspconfig.denols.setup({
							root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
					eslint = function()
						lspconfig.eslint.setup({
							settings = {
								run = "onSave",
							},
							on_attach = function(client, bufnr)
								vim.keymap.set(
									"n",
									"<leader>ef",
									":EslintFixAll<CR>",
									{ buffer = bufnr, desc = "LSP: Restart" }
								)
							end,
						})
					end,
					vim.lsp.config("svelte", {
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									-- Update imported things from js or ts files inside of svelte files
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end,
					}),
				},
			})
		end,
	},
}
