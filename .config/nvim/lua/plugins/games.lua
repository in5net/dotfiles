return {
    { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
    { "alec-gibson/nvim-tetris",  cmd = "Tetris" },
    { "mmisono/viminesweeper",    cmd = "Nvimesweeper" },
    { "zyedidia/vim-snake",       cmd = "Snake" },
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>" },
        },
    },
    {
        "NStefan002/2048.nvim",
        cmd = "Play2048",
        config = true,
    },
}
