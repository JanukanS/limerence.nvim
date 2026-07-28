local limerence = require("limerence.core")

vim.api.nvim_create_user_command("CrushFix", function()
	limerence.crush_call()
end, { desc = "Call Crush on the current file", nargs = 0 })
