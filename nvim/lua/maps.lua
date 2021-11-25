local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
local M = {}

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true, silent = true }
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)

-- CHADtree
map('n', '<leader>v', ':CHADopen<cr>', options)

-- Not an editor command: Wqa
cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')
