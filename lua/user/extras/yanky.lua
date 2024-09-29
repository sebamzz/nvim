local M = {
  "gbprod/yanky.nvim",
}

function M.config()
  require("yanky").setup {
    preserve_cursor_position = {
      enabled = true,
    },
  }

  vim.keymap.set({"n","x"}, "y", "<Plug>(YankyYank)")
end

return M
