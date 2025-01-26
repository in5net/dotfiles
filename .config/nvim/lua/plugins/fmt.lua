return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback", stop_after_first = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			svelte = { "prettier" },
			markdown = { "prettier" },
			handlebars = { "prettier" },
			svg = { "prettier" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			sql = { "sqlfmt" },
			nix = { "nixfmt" },
			_ = { "trim_whitespace" },
		},
		format_on_save = { timeout_ms = 3000, lsp_format = "fallback", stop_after_first = true },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
