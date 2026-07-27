M ={}


function M.create_default_prompt()
	current_file = vim.api.nvim_buf_get_name(0)
	prompt_message = string.format('Implement TODOs within comments listed in the file: %s',current_file)
	return prompt_message
end

function M.submit_prompt(prompt_msg)
	vim.cmd.write()
	crush_args = {
		'crush',
		'run',
		string.format('"%s"', prompt_msg)
	}
	crush_command = vim.system(crush_args, { text = true })
	crush_res = crush_command:wait(10000)

	if crush_res.code == 0 then
		vim.cmd('silent! checktime')
		vim.notify(crush_res.stdout, vim.log.levels.INFO)
	else
		vim.notify("Something went wrong with Crush", vim.log.levels.ERROR)
	end
end

function M.crush_call()
	local msg = M.create_default_prompt()
	M.submit_prompt(msg)
end

return M
