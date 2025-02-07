local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  local linters = {
    "--disable-all",
    "-E", "bodyclose",
    "-E", "bidichk",
    "-E", "decorder",
    "-E", "containedctx",
    "-E", "contextcheck",
    "-E", "dogsled",
    "-E", "dupl",
    "-E", "errcheck",
    "-E", "errchkjson",
    "-E", "errname",
    "-E", "errorlint",
    "-E", "exportloopref",
    "-E", "exhaustive",
    "-E", "goconst",
    "-E", "godot",
    "-E", "gocritic",
    "-E", "gofmt",
    "-E", "goimports",
    "-E", "gocyclo",
    "-E", "goprintffuncname",
    "-E", "gosec",
    "-E", "gosimple",
    "-E", "govet",
    "-E", "ireturn",
    "-E", "ineffassign",
    "-E", "misspell",
    "-E", "nestif",
    "-E", "nilerr",
    "-E", "nilnil",
    "-E", "nolintlint",
    "-E", "prealloc",
    "-E", "predeclared",
    "-E", "revive",
    "-E", "staticcheck",
    "-E", "stylecheck",
    "-E", "thelper",
    "-E", "tagliatelle",
    "-E", "tparallel",
    "-E", "testpackage",
    "-E", "tenv",
    "-E", "typecheck",
    "-E", "unconvert",
    "-E", "usestdlibvars",
    "-E", "unparam",
    "-E", "unused",
    "-E", "whitespace",
    "-E", "wsl"
  }

  -- local presets = {
  --   "-p", "comment",
  --   "-p", "complexity",
  --   "-p", "error" ,
  --   "-p", "format",
  --   "-p", "import",
  --   "-p", "metalinter",
  --   "-p", "module",
  --   "-p", "performance",
  --   "-p", "sql",
  --   "-p", "style",
  --   "-p", "test",
  --   "-p", "unused"
  -- }

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      formatting.shfmt,

      -- diagnostics.shellcheck,

      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,
      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.completion.spell,
      null_ls.builtins.diagnostics.golangci_lint.with {
        filetypes = { "go" },
        extra_args = linters,
      },
    },
  }
end

return M
