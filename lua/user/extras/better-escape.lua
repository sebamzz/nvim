local M = {
  "max397574/better-escape.nvim",
}

function M.config()
  require("better_escape").setup {
    mappings = {
      v = {
        j = {
          k = false,
        },
      },
    },
  }
end

return M
