return {
    {
        "folke/trouble.nvim",
        event = "BufRead",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        init = function()
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)
        end,
    },
}
