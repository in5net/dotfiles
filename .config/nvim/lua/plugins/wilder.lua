return {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
        local wilder = require("wilder")
        wilder.setup({ modes = { ":", "/", "?" } })
        wilder.set_option(
            "renderer",
            wilder.wildmenu_renderer({
                highlighter = wilder.basic_highlighter(),
            })
        )
    end,
}
