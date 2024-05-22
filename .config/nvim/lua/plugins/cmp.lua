---@diagnostic disable: missing-fields
return {
	{
		"github/copilot.vim",
		build = ":Copilot setup",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"kristijanhusak/vim-dadbod-ui",
			"onsails/lspkind.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-l>"] = cmp_action.luasnip_jump_backward(),
					["<C-h>"] = cmp_action.luasnip_jump_forward(),
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						maxwidth = 50,
					}),
				},
			})

			cmp.setup.filetype({ "sql", "mysql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
