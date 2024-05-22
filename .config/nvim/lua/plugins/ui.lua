return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({
				strict = true,
				override_by_filename = {
					["firebase.json"] = {
						icon = "󰥧",
					},
					["firestore.rules"] = {
						icon = "󰥧",
					},
					["firestore.indexes.json"] = {
						icon = "󰥧",
					},
					["database.rules.json"] = {
						icon = "󰥧",
					},
					["storage.rules"] = {
						icon = "󰥧",
					},
				},
			})
		end,
	},
}
