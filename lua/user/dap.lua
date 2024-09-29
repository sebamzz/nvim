local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "leoluz/nvim-dap-go",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup {
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          }
        end,
      },
    },
  },
}

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

function M.config()
  local icons = require "user.icons"
  local wk = require "which-key"
  local dap = require "dap"
  local dapui = require "dapui"
  local dapgo = require "dap-go"

  vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = icons.diagnostics.DebugConditionalBreakpoint, texthl = "", linehl = "", numhl = "" }
  )

  dapui.setup {
    layouts = {
      {
        elements = {
          {
            id = "repl",
            size = 0.25,
          },
          {
            id = "breakpoints",
            size = 0.25,
          },
          {
            id = "stacks",
            size = 0.25,
          },
          {
            id = "watches",
            size = 0.25,
          },
        },
        position = "left",
        size = 10,
      },
      {
        elements = {
          {
            id = "scopes",
            size = 0.75,
          },
        },
        position = "bottom",
        size = 10,
      },
    },
  }

  dapgo.setup()
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- wk.register {
  --   ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  --   ["<leader>dT"] = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Toggle Breakpoint" },
  --   ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  --   ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   ["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  --   ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  --   ["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  --   ["<leader>d<F7>"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  --   ["<leader>d<F8>"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  --   ["<leader>de"] = { "<cmd>lua require'dapui'.eval()<cr>", "Step Out" },
  --   ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  --   ["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  --   ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  --   ["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  --   ["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  --   ["<leader>dU"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },

  wk.add {
    {
      "<leader>dt",
      "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>db",
      "<cmd>lua require'dap'.step_back()<cr>",
      desc = "Step Back",
    },
    {
      "<leader>dc",
      "<cmd>lua require'dap'.continue()<cr>",
      desc = "Continue",
    },
    {
      "<leader>dC",
      "<cmd>lua require'dap'.run_to_cursor()<cr>",
      desc = "Run To Cursor",
    },
    {
      "<leader>dd",
      "<cmd>lua require'dap'.disconnect()<cr>",
      desc = "Disconnect",
    },
    {
      "<leader>dg",
      "<cmd>lua require'dap'.session()<cr>",
      desc = "Get Session",
    },
    {
      "<leader>di",
      "<cmd>lua require'dap'.step_into()<cr>",
      desc = "Step Into",
    },
    {
      "<leader>do",
      "<cmd>lua require'dap'.step_over()<cr>",
      desc = "Step Over",
    },
    {
      "<leader>du",
      "<cmd>lua require'dap'.step_out()<cr>",
      desc = "Step Out",
    },
    {
      "<leader>dp",
      "<cmd>lua require'dap'.pause()<cr>",
      desc = "Pause",
    },
    {
      "<leader>dr",
      "<cmd>lua require'dap'.repl.toggle()<cr>",
      desc = "Toggle Repl",
    },
    {
      "<leader>ds",
      "<cmd>lua require'dap'.continue()<cr>",
      desc = "Start",
    },
    {
      "<leader>dq",
      "<cmd>lua require'dap'.close()<cr>",
      desc = "Quit",
    },
    {
      "<leader>dU",
      "<cmd>lua require'dapui'.toggle({reset = true})<cr>",
      desc = "Toggle UI",
    },
  }

  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
      },
    }
  end
end

return M
