local M = {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  require("refactoring").setup {}

  -- load refactoring Telescope extension

  local wk = require "which-key"
  wk.add {
    {
      "<leader>r",
      icon = {
        icon = "󰪨 ",
        color = "azure",
      },
      group = "Refactor",
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      desc = "Refactor",
      mode = { "n", "x" },
    },
  }
end

return M
