local M = {
  "folke/trouble.nvim",
}

function M.config()
  require("trouble").setup {
    focus = true,
  }
  local wk = require "which-key"
  wk.register {
    -- ["<leader>ld"] = { "<cmd>Trouble diagnostics<cr>", "Diagnostics" },
  }

  local actions = require "telescope.actions"
  local open_with_trouble = require("trouble.sources.telescope").open

  -- Use this to add more results without clearing the trouble list
  local add_to_trouble = require("trouble.sources.telescope").add

  local telescope = require "telescope"

  telescope.setup {
    defaults = {
      mappings = {
        i = { ["<c-t>"] = open_with_trouble },
        n = { ["<c-t>"] = open_with_trouble },
      },
    },
  }
end

return M
