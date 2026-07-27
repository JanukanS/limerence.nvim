-- Constructs a default prompt message referencing the current file name
local function create_default_prompt()
	current_file = vim.fn.expand('%:t')
	prompt_message = string.format('Implement todos within comments listed in the file @%s',current_file)
	return prompt_message
end

-- Submits the given prompt to Crush and handles the response
local function submit_prompt(prompt_msg)
	vim.cmd.write()
	crush_args = {
		'crush',
		'run',
		string.format('"%s"', prompt_msg)
	}
	crush_command = vim.system(crush_args)
	crush_res = crush_command:wait(10000)

	if crush_res.code == 0 then
		vim.cmd('silent! checktime')
		vim.notify(crush_res.stdout, vim.log.levels.INFO)
	else
		vim.notify("Something went wrong with Crush", vim.log.levels.ERROR)
	end
end

local function crush_call()
	local msg = create_default_prompt()
	submit_prompt(msg)
end
