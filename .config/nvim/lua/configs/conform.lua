local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    bash = { 'shfmt', 'shellcheck' },
    zsh = { 'shellcheck' }, -- don't use shfmt as it doesn't support zsh officialy and breaks scripts
    sh = { 'shfmt', 'shellcheck' },
    ["*"] = { "codespell" },
  },

  notify_on_error = true,
  notify_no_formatters = true,
}

return options
