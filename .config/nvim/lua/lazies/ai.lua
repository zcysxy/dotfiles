---@diagnostic disable: undefined-global

return {
  'madox2/vim-ai',
	-- {
	--   "zbirenbaum/copilot.lua",
	--   event = "VeryLazy",
	--   config = function()
	--     require("copilot").setup({})
	--   end,
	-- },
	{
		'github/copilot.vim',
		config = function()
			vim.cmd([[
let s:initial_chat_prompt =<< trim END
>>> system

I am writing a computer science paper using LaTeX. You are a proficient researcher and academic writer. I want you to help me polish my manuscript. Specifically, please help me polish the writing to meet the academic style, improve the spelling, grammar, clarity, concision and overall readability. When necessary, rewrite the whole sentence.
I will provide the manuscript in LaTeX; please directly return the edited LaTeX text. You don't need to explain your modification.

END
let g:vim_ai_chat = {
\  "options": {
\    "model": "gpt-4",
\    "max_tokens": 1000,
\    "temperature": 1,
\    "request_timeout": 20,
\    "selection_boundary": "",
\    "initial_prompt": s:initial_chat_prompt,
\  },
\  "ui": {
\    "code_syntax_enabled": 1,
\    "populate_options": 0,
\    "open_chat_command": "preset_below",
\    "scratch_buffer_keep_open": 0,
\    "paste_mode": 1,
\  },
\}

" Copilot
let g:copilot_filetypes = {
    \ '*': v:true,
    \ 'markdown': v:true,
    \ }
]])

			-- Function to ask the user for the commit intention
			local function askCommitIntention()
				return vim.fn.input('Enter the intention of the commit: ')
			end

			-- Function to obtain the git diff
			local function getGitDiff()
				return vim.fn.system('git --no-pager diff --staged')
			end

			-- Function to build the prompt for the GPT-4 model
			local function buildPrompt(diff, intention)
				local instructions = "Generate a professional git commit message using the" ..
						" Conventional Commits format. " ..
						"This includes using a commit type (such as 'feat', 'fix', 'refactor', etc.), " ..
						"optionally a scope in parentheses, and a brief description that reflects" ..
						" the intention '" .. intention .. "'." ..
						"- All explanation must be inside the commit message. Do not write" ..
						" anything before or affter." ..
						"- Do not enclose the commit message between ``` and ```" ..
						"- Add line breaks at collumn 78" ..
						"- Base the commit message on the changes provided below:\n" ..
						diff

				return instructions
			end

			local function generateCommitMessage()
				local intention = askCommitIntention()
				local diff = getGitDiff()

				if diff == "" then
					print("No changes detected. Cannot generate a commit message.")
					return
				end

				local prompt = buildPrompt(diff, intention)
				local range = 0
				local config = {
					engine = "chat",
					options = {
						model = "gpt-4",
						endpoint_url = "https://api.openai.com/v1/chat/completions",
						max_tokens = 1000,
						initial_prompt = ">>> system\nyou are a code assistant",
						temperature = 1,
					},
				}

				-- Execute the AI with the provided configuration
				vim.api.nvim_call_function('vim_ai#AIRun', { range, config, prompt })
			end

			-- Custom command to suggest a commit message
			vim.api.nvim_create_user_command('GitCommitMessage', generateCommitMessage, {})

			-- Function to generate a vim command
			local function generateVimCommand(args)
				local purpose = args['args']
				local prompt = "I am in a NeoVim buffer. What is the Vim command for this purpose: \"" ..
				purpose .. "\"? Please directly return the command without any explanation."
				print(prompt)

				local range = 0
				local config = {
					engine = "chat",
					options = {
						model = "gpt-4",
						endpoint_url = "https://api.openai.com/v1/chat/completions",
						max_tokens = 1000,
						initial_prompt = ">>> system\nyou are a code assistant",
						temperature = 1,
					},
				}

				-- Execute the AI with the provided configuration
				vim.api.nvim_call_function('vim_ai#AIRun', { range, config, prompt })
			end

			-- Custom command to suggest a commit message
			vim.api.nvim_create_user_command('AIV', generateVimCommand, { nargs = '*' })
		end
	}
}
