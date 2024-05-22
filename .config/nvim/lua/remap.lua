-- move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keep cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in center while page scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep cursor in center while navigating between matches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste from system clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete to black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- delete character to black hole register
vim.keymap.set("n", "x", [["_x]])

vim.keymap.set("n", "Q", "<Nop>")
