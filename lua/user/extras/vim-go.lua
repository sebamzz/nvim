local M = {
  "fatih/vim-go",
  ft = "go",
}

function M.config()
  local wk = require "which-key"
  wk.add {
    {
      "<leader>G",
      group = "Go",
      icon = {
        icon = "",
        color = "cyan"
      },
    },
    { "<leader>Gr", "<cmd>GoRun<cr>", desc = "Run" },
  }

end

return M
