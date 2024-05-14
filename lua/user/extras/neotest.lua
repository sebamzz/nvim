local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",
    "David-Kunz/jester",
    -- general tests
    "vim-test/vim-test",
    "nvim-neotest/neotest-vim-test",
    -- language specific tests
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "rouge8/neotest-rust",
    "lawrence-laz/neotest-zig",
    "rcasia/neotest-bash",
    'nvim-neotest/neotest-jest',
    "nvim-neotest/neotest-go",
  },
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>tt"] = { "<cmd>w<cr><cmd>lua require'neotest'.run.run()<cr>", "Test Nearest" },
    ["<leader>tf"] = { "<cmd>w<cr><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
    ["<leader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },
    ["<leader>ts"] = { "<cmd>Neotest summary<cr>", "Test Summary" },
    ["<leader>to"] = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Test Output" },
    -- ["<leader>ts"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
    ["<leader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
  }

  ---@diagnostic disable: missing-fields
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vitest",
      require "neotest-zig",
      require "neotest-rust",
      require "neotest-go" {
        experimental = {
          test_table = true,
        },
      },
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
      },
      require 'neotest-jest' {
        jestCommand = "npm test --",
        jestConfigFile = function(file)
          if string.find(file, "/packages/") then
            return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
          end
          return vim.fn.getcwd() .. "/jest.config.js"
        end,
        env = { CI = true },
        cwd = function(file)
          if string.find(file, "/packages/") then
            return string.match(file, "(.-/[^/]+/)src")
          end
          return vim.fn.getcwd()
        end
      },
    },
  }
end

return M
