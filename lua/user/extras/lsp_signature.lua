
local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
}

function M.config()
  require("lsp_signature").setup({
    hint_enable = false, -- virtual hint enable
  })
end

return M
