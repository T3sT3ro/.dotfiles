local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    ["*"] = { "codespell" },
  },

  notify_on_error = true,
  notify_no_formatters = true,
}

return options
