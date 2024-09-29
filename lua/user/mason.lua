local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
}

M.execs = {
  "lua_ls",
  "cssls",
  "html",
  -- "tsserver",
  "astro",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
  "tailwindcss",
  "rust_analyzer",
  "eslint",
  "gopls",
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }
  require("mason-lspconfig").setup {
    ensure_installed = M.execs,
  }

  require("mason-nvim-dap").setup {
    ensure_installed = {'node2', 'js'},
    handlers = {},
    automatic_installation = false,
  }
end

return M
