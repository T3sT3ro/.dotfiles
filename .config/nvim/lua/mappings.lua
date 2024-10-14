require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- move up/down with preserving indentation
map("n", "<A-S-Down>", ":m .+1<CR>==", { desc = "move line down" })
map("n", "<A-S-Up>", ":m .-2<CR>==", { desc = "move line up" })
map("i", "<A-S-Down>", "<ESC>:m .+1==gi", { desc = "move line down" })
map("i", "<A-S-Up>", "<ESC>:m .-2==gi", { desc = "move line up" })
map("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

map("i", "<C-S-Z>", "<c-o><c-r>", { desc = "redo" })
map("i", "<C-Z>", "<c-o>u", { desc = "undo" })

-- save with ctrl+S
map('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
map('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

