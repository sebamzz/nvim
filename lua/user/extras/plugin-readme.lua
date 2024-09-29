local M = {
     "selectnull/plugin-readme.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local readme = require "plugin-readme"
        vim.keymap.set("n", "<leader>pP", readme.select_plugin, {})
    end,
}

return M
