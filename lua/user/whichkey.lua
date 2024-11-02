local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local icons = require "user.icons"
  local which_key = require "which-key"
  which_key.setup {
    preset = "helix",
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      border = "rounded",
      no_overlap = false,
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = false,
      title_pos = "center",
      zindex = 1000,
    },
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local wk = require "which-key"

  -- icon colors
  -- azure, blue, cyan, green, grey, orange, purple, red, yellow

  wk.add {
    {
      "<leader>c",
      group = "Copilot Chat",
      icon = {
        icon = " ",
        color = "cyan",
      },
    },
    {
      "<leader>q",
      "<cmd>confirm q<CR>",
      desc = "Quit",
    },
    {
      "<leader>h",
      "<cmd>nohlsearch<CR>",
      desc = "NOHL",
      hidden = true,
    },
    {
      "<leader>;",
      "<cmd>tabnew | terminal<CR>",
      desc = "Term",
      icon = {
        icon = " ",
        color = "green",
      },
    },
    {
      "<leader>w",
      "<cmd>write<CR>",
      desc = "Write",
      hidden = true,
    },
    {
      "<leader>v",
      "<cmd>vsplit<CR>",
      desc = "Split",
      hidden = true,
    },
    {
      "<leader>b",
      group = "Buffers",
    },
    {
      "<leader>d",
      group = "Debug",
      icon = {
        icon = icons.ui.Bug,
        color = "grey",
      },
    },
    {
      "<leader>f",
      group = "Find",
    },
    {
      "<leader>g",
      group = "Git",
    },
    {
      "<leader>l",
      group = "LSP",
      icon = {
        icon = " ",
        color = "blue",
      },
    },
    {
      "<leader>n",
      icon = {
        icon = "󱞂 ",
        color = "yellow",
      },
      group = "Nostr",
    },
    {
      "<leader>p",
      icon = {
        icon = " ",
        color = "azure",
      },
      group = "Plugins",
    },
    {
      "<leader>t",
      group = "Test",
    },
    {
      "<leader>T",
      group = "Treesitter",
    },
    {
      "<leader>o",
      icon = {
        icon = "󱄎 ",
        color = "green",
      },
      group = "Options",
    },
    { "<leader>ow", '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', desc = "Wrap" },
    { "<leader>or", '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', desc = "Relative" },
    { "<leader>oc", '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', desc = "Cursorline" },
    { "<leader>os", '<cmd>lua require("user.functions").toggle_option("spell")<cr>', desc = "Spell" },
  }
end

return M
