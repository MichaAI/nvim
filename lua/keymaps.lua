local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('', '<C-t>', ':NERDTreeToggleVCS<CR>', default_opts)
