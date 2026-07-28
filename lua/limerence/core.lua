M = {}
local config = require("limerence").config

-- write docstrings
function M.create_default_prompt()
	local current_file = vim.api.nvim_buf_get_name(0)
	local prompt_message = string.format('Implement TODOs within comments listed in the file: %s',current_file)
	return prompt_message
end

local function crush_callback(crush_res)
	if crush_res.code == 0 then
		vim.cmd('edit!')
		vim.notify(crush_res.stdout, vim.log.levels.INFO)
	else
		vim.notify("Crush exited with an error (code: " .. crush_res.code .. ")", vim.log.levels.ERROR)
	end
end

function M.submit_prompt(prompt_msg)
	vim.cmd.write()
	local crush_args = {
		'crush',
		'run',
		string.format('"%s"', prompt_msg),
	}
	if config.model then
		table.insert(crush_args,'--model')
		table.insert(crush_args,config.model)
	end
	vim.system(crush_args, { text = true }, vim.schedule_wrap(crush_callback))
end

function M.crush_call()
	local msg = M.create_default_prompt()
	M.submit_prompt(msg)
end

return M
