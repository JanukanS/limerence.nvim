local function check_presence(prog)
	local command = vim.system({'whereis',prog})
	result = command:wait()
	return result.code == 0
end

local function loop_check_presence(req_progs)
	local not_present = {}
	for _, prog in ipairs(req_progs) do
		if not check_presence(prog) then
			table.insert(not_present,prog)
		end
	end
	return not_present
end

local req_progs = {'git','crush'}

local M = {}

M.check = function()
	vim.health.start("Limerence Report")
	local not_present = loop_check_presence(req_progs)
	if #not_present == 0 then
		vim.health.ok("Required programs are available")
	else
		vim.health.error("Required programs could not be found")
	end
end

return M
