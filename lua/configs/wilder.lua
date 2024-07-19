local wilder = require "wilder"
local highlighters = {
  wilder.pcre2_highlighter(),
}

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
  highlighter = highlighters,
  border = "rounded",
  left = { " ", wilder.popupmenu_devicons() },
  right = { " ", wilder.popupmenu_scrollbar() },
})

wilder.setup {
  modes = { ":", "/", "?" },
  next_key = "<C-j>",
  previous_key = "<C-k>",
}

wilder.set_option(
  "renderer",
  wilder.renderer_mux {
    [":"] = popupmenu_renderer,
  }
)
