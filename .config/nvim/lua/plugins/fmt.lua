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
			javascript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			jsonc = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			svelte = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },
			handlebars = { "prettierd", "prettier" },
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
