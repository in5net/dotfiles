return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                transparent = true,
                ---@diagnostic disable-next-line: unused-local
                overrides = function(colors)
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPre",
    },
}
