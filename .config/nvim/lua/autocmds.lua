vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.vert", "*.frag" },
	group = vim.api.nvim_create_augroup("glsl", { clear = true }),
	callback = function()
		vim.bo.filetype = "glsl"
	end,
})
