require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<A-S-Down>", ":m .+1<CR>==", { desc = "move line down" })
map("n", "<A-S-Up>", ":m .-2<CR>==", { desc = "move line up" })

map("i", "<A-S-Down>", "<c-o>:m .+1<CR>==", { desc = "move line down" })
map("i", "<A-S-Up>", "<c-o>:m .-2<CR>==", { desc = "move line up" })

map("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { desc = "move line down" })
map("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { desc = "move line up" })

map("i", "<C-S-Z>", "<c-o><c-r>", { desc = "redo" })
map("i", "<C-Z>", "<c-o>u", { desc = "undo" })
