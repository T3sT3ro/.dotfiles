local cmp = require "cmp"

-- IMPORTANT:
-- THIS FILE DOESN'T HAVE ANY EFFECT NOW CUZ IT'S NOT SOURCED IN init.lua!!!


-- this doesn't work for some reason
--- @type cmp.ConfigSchema
local options = {
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },

  sources = {
    "codeium"
  }
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Tab
    ['<CR>'] = cmp.mapping.confirm({ select = false })  -- Insert without selection on Enter
  }),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

return options
