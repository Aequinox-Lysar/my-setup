vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.o.cmdheight = 2
vim.wo.number = true
vim.cmd[[colorscheme industry]]
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.api.nvim_set_keymap("n", "<leader>g", ":w<CR>:terminal glow %<CR>", { noremap = true, silent = true } )
