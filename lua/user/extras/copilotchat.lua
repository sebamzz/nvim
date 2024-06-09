local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

local M = {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      prompts = prompts,
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      language = "es", -- Language for the prompt
    },
    -- See Commands section for default commands if you want to lazy load on them
}


function M.config(_, opts)
  local chat = require("CopilotChat")
  local select = require("CopilotChat.select")

  -- Override the git prompts message
  opts.prompts.Commit = {
    prompt = "Write commit message for the change with commitizen convention",
    selection = select.gitdiff,
  }
  opts.prompts.CommitStaged = {
    prompt = "Write commit message for the change with commitizen convention",
    selection = function(source)
      return select.gitdiff(source, true)
    end,
  }

  chat.setup(opts)


  require("CopilotChat.integrations.cmp").setup()

  vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
    chat.ask(args.args, { selection = select.visual })
  end, { nargs = "*", range = true })

  -- Inline chat with Copilot
  vim.api.nvim_create_user_command("CopilotChatInline", function(args)
    chat.ask(args.args, {
      selection = select.visual,
      window = {
        layout = "float",
        relative = "cursor",
        width = 1,
        height = 0.4,
        row = 1,
      },
    })
  end, { nargs = "*", range = true })

  -- Restore CopilotChatBuffer
  vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
    chat.ask(args.args, { selection = select.buffer })
  end, { nargs = "*", range = true })

  -- Custom buffer for CopilotChat
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "copilot-*",
    callback = function()
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false

      -- Get current filetype and set it to markdown if the current filetype is copilot-chat
      local ft = vim.bo.filetype
      if ft == "copilot-chat" then
        vim.bo.filetype = "markdown"
      end
    end,
  })

  local wk = require "which-key"
  wk.register {
    ["<leader>ch"] = {
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      "Help actions",
    },
    ["<leader>cp"] = {
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      "Prompt actions",
    },
    ["<leader>ci"] = {
      function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end,
      "Ask input",
    },
    ["<leader>cm"] = {
      "<cmd>CopilotChatCommit<cr>",
      "Generate commit message for all changes",
    },
    ["<leader>cM"] = {
      "<cmd>CopilotChatCommitStaged<cr>",
      "Generate commit message for staged changes",
    },
    ["<leader>cq"] = {
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatBuffer " .. input)
        end
      end,
      "Quick chat",
    },
    ["<leader>ce"] = {"<cmd>CopilotChatExplain<cr>", "Explain code" },
    ["<leader>ct"] = {"<cmd>CopilotChatTests<cr>", "Generate tests" },
    ["<leader>cr"] = {"ggVGy<cmd>CopilotChatReview<cr>", "Review code" },
    ["<leader>cR"] = {"ggVGy<cmd>CopilotChatRefactor<cr>", "Refactor code" },
    ["<leader>cn"] = {"<cmd>CopilotChatBetterNamings<cr>", "Better Naming" },
    ["<leader>cd"] = {"<cmd>CopilotChatDebugInfo<cr>", "Debug Info" },
    ["<leader>cf"] = {"<cmd>CopilotChatFixDiagnostic<cr>", "Fix Diagnostic" },
    ["<leader>cl"] = {"<cmd>CopilotChatReset<cr>", "Clear buffer and chat history" },
    ["<leader>cv"] = {"<cmd>CopilotChatToggle<cr>", "Toggle" },
  }

  wk.register {
    ["<leader>c"] = {
      name = "Copilot Chat",
      p = {
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        "Prompt actions",
      },
      v = {
        "<cmd>CopilotChatVisual<cr>",
        "Open in vertical split",
      },
      x = {
        "<cmd>CopilotChatInline<cr>",
        "Inline chat",
      },
      r = {
        "<cmd>CopilotChatRefactor<cr>",
        "Refactor",
      },
      mode = "x",
    }
  }


end

return M

