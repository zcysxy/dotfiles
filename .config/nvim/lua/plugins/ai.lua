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
