
local status_ok, pantran = pcall(require, "pantran")
if not status_ok then
	return
end

pantran.setup({
-- Default engine to use for translation. To list valid engine names run
  -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
  default_engine = "argos",
  -- Configuration for individual engines goes here.
  engines = {
    argos = {
      -- Default languages can be defined on a per engine basis. In this case
      -- `:lua require("pantran.async").run(function()
      -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
      -- can be used to list available language identifiers.
      default_source = "auto",
      default_target = "es"
    },
  },
})

local opts = {noremap = true, silent = true, expr = true}
vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)
