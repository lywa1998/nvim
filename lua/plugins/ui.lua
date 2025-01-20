return {
    {
        "goolord/alpha-nvim",
        config = function ()
            local alpha = require "alpha"
            local dashboard = require "alpha.themes.dashboard"
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.project.project{}<CR>"),
                dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            alpha.setup(dashboard.opts)

        end
    },
}
