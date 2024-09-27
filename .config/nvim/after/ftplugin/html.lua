---@diagnostic disable: undefined-global

vim.keymap.set({ 'n' },'<leader>ll', function() require("knap").toggle_autopreviewing() end)
