local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap-go'.debug_test()<CR>", "Debug Test" },
  },
  G = {
    name = "Go",
    a = { "<cmd>GoAlt<CR>", "Alternate" },
    r = { "<Cmd>!go run %<CR>", "Run" },
    b = { "<cmd>GoCoverageBrowser<CR>", "Coverage Browser" },
    c = { "<cmd>GoCoverageToggle<CR>", "Coverage" },
    f = { "<cmd>GoTestFunc<CR>", "Test Function" },
    i = { "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>", "Implement Interface" },
    t = { "<cmd>GoTest<CR>", "Test Project" },
    T = { "<cmd>GoAddTag<CR>", "Add Tags" },
    m = { "<cmd>GoModReload<CR>", "Mod Tidy" },
    C = { "<cmd>GoClearTag<CR>", "Clear Tag" },
    s = { "<cmd>GoFillStruct<CR>", "Fill Struct" },
  },
}

local vmappings = {
  r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor Menu" },
  f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
  o = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "Extract Function To File" },
  v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
  i = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

-- Auto Imports
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- Autocommands
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    OrgImports()
  end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "setlocal shiftwidth=2"
  end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "setlocal tabstop=2"
  end,
})
