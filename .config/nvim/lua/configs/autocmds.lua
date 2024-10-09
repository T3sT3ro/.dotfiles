-- auto decrypt and encrypt files by prompting for password
local gpgGroup = vim.api.nvim_create_augroup('customGpg', { clear = true })

-- autocmds execute in the order in which they were defined.
-- https://neovim.io/doc/user/autocmd.html#autocmd-define

local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufReadPre', 'FileReadPre' }, {
    pattern = '*.gpg',
    group = gpgGroup,
    callback = function ()
        -- Make sure nothing is written to shada file while editing an encrypted file.
        vim.opt_local.shada = nil
        -- We don't want a swap file, as it writes unencrypted data to disk
        vim.opt_local.swapfile = false
        -- Switch to binary mode to read the encrypted file
        vim.opt_local.bin = true

        vim.cmd("let ch_save = &ch|set ch=2")
    end
})

autocmd({ 'BufReadPost', 'FileReadPost' }, {
    pattern = '*.gpg',
    group = gpgGroup,
    callback = function ()
        vim.cmd("'[,']!gpg --decrypt 2> /dev/null")

        -- Switch to normal mode for editing
        vim.opt_local.bin = false

        vim.cmd('let &ch = ch_save|unlet ch_save')
        vim.cmd(":doautocmd BufReadPost " .. vim.fn.expand("%:r"))
    end
})

-- Convert all text to encrypted text before writing
autocmd({ 'BufWritePre', 'FileWritePre' }, {
    pattern = '*.gpg',
    group = gpgGroup,
    command = "'[,']!gpg --default-recipient-self -ae 2>/dev/null",
})
-- Undo the encryption so we are back in the normal text, directly
-- after the file has been written.
autocmd({ 'BufWritePost', 'FileWritePost' }, {
    pattern = '*.gpg',
    group = gpgGroup,
    command = 'u'
})

-- restore last cursor position, from https://nvchad.com/docs/recipes
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
