local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,
      -- null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
      null_ls.builtins.diagnostics.golangci_lint.with {
        filetypes = { "go" },
        extra_args = { "-p", "comment", "-p", "complexity", "-p", "error" , "-p", "format" , "-p", "import" , "-p", "metalinter" , "-p", "module" , "-p", "performance", "-p", "sql", "-p", "style", "-p", "test", "-p", "unused" },
      },
    },
  }
end

return M
