local M = {
"Fildo7525/pretty_hover",
	event = "LspAttach",
	opts = {}
}

function M.config()
  require("pretty_hover").setup()
end

return M
