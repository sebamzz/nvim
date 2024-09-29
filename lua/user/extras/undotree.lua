local M = {
  "mbbill/undotree",
}

function M.config()

  local wk = require "which-key"
  wk.add {
    {
      "<leader>u",
      "<cmd>UndotreeToggle<cr><C-w>h",
      desc = "Undotree Toggle",
    },
  }
end

return M
