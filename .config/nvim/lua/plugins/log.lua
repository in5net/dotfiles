return {
	"rareitems/printer.nvim",
	config = function()
		---@diagnostic disable-next-line: unused-local
		local function consoledotlog(text_inside, text_var)
			return string.format('console.log("%s", %s)', text_var, text_var)
		end

		require("printer").setup({
			keymap = "gl",
			formatters = {
				javascript = consoledotlog,
				typescript = consoledotlog,
				svelte = consoledotlog,
			},
		})
	end,
}
