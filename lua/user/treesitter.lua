local M = {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPost", "BufNewFile" },
  -- build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- event = "VeryLazy",
    },
  },
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>Ti"] = { "<cmd>TSConfigInfo<CR>", "Info" },
  }

  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "c", "vim", "javascript", "go", "vimdoc" }, -- put the language you want in this array
    ignore_install = { "" },
    sync_install = false,
    highlight = {
      enable = true,
      -- disable = { "markdown" },
      additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    modules = {},
    indent = {
      enable = true,
      disable = { "yaml" },
    },
    autopairs = { enable = true },
    refactor = {
      navigation = {
        enable = true,
        -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = "<c-space>",
        node_incremental = "v",
        node_decremental = "V",
        -- scope_incremental = "<c-s>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["<M-Down>"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]m"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["<M-Up>"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[m"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["at"] = "@class.outer",
          ["it"] = "@class.inner",
          ["ac"] = "@call.outer",
          ["ic"] = "@call.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["a/"] = "@comment.outer",
          ["i/"] = "@comment.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@scopename.inner",
          ["aA"] = "@attribute.outer",
          ["iA"] = "@attribute.inner",
          ["aF"] = "@frame.outer",
          ["iF"] = "@frame.inner",
          ["ak"] = "@assignment.lhs",
          ["av"] = "@assignment.rhs",
        },
      },
    },
  }
end

return M
