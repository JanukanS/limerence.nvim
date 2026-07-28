M = {}

local default_config  = {
	model=nil,
}
M.config  = {}

M.setup = function(user_opts)
	M.config=vim.tbl_deep_extend("force", default_config, user_opts)
end

return M
