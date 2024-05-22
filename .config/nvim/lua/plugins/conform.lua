return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			svelte = { { "prettierd", "prettier" } },
			markdown = { { "prettierd", "prettier" } },
			fish = { "fish_indent" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = { timeout_ms = 5000, lsp_fallback = true },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
