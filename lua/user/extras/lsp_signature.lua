local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
}

function M.config()
  require("lsp_signature").setup {
    always_trigger = true,
    transparency = 10, -- disabled by default, allow floating win transparent value 1~100
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    hint_enable = true, -- virtual hint enable
    toggle_key = "<C-s>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    toggle_key_flip_floatwin_setting = true, -- true: toggle floating_windows: true|false setting after toggle key pressed
  }
end

return M
