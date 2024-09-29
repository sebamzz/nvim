local M = {
  "folke/trouble.nvim",
}

function M.config()
  require("trouble").setup {
    focus = true,
  }
  local wk = require "which-key"

  wk.add {
    {
      "<leader>ld",
      "<cmd>Trouble<cr>",
      desc = "Diagnostics",
    },
    {
      "<leader>lt",
      "<cmd>TodoTrouble<cr>",
      desc = "TODO",
    },
  }
end

return M
