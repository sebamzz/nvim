local M = {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

function M.config()
  require("go").setup {
    lsp_cfg = false,
    diagnostic = false, -- show diagnostics
  }
end

return M
