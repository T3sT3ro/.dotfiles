return {

  -- formatting plugin
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highligh = { enable = true },
      indent = { enable = true },
      ensure_installed = { "html", "css", "bash", "lua" },
      -- like CTRL+W in IntelliJ
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      }
    },
  },

  -- explorer
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = require "configs.lspconfig",
  },


  -- cmp for completionList
  {
    "hrsh7th/nvim-cmp",

    dependencies = {

      {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
        config = function()
          local cmp = require "cmp"

          cmp.setup.cmdline("/", {
            mapping = vim.tbl_deep_extend("force", cmp.mapping.preset.cmdline(), {
              ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
              ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            }),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = vim.tbl_deep_extend("force", cmp.mapping.preset.cmdline(), {
              ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
              ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            }),
            sources = cmp.config.sources(
              { { name = "path" } },
              { {
                name = "cmdline",
                option = { ignore_cmds = { "Man", "!" } },
                trigger_characters = { ":" }
              } }
            ),
            matching = { disallow_symbol_nonprefix_matching = false },
          })
        end,
      },
    },

    opts = function(_, opts)
      local cmp = require 'cmp'
      print(opts)
      opts.mapping['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      opts.mapping['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })

      table.insert(opts.sources, { name = "codeium" })
    end,
  },

  -- multi-cursors - barely configured
  -- https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    config = function() end,
  },

  -- Sudo writes
  -- https://github.com/lambdalisue/suda.vim
  {
    "lambdalisue/suda.vim",
    lazy = false,
  },

  -- undo tree
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      -- { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  -- another undo tree with fzf
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      { 
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {},
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },

  -- AI autocomplete plugin
  {
    "Exafunction/codeium.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_chat = true,
      })
    end
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  -- LSP filter window
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  { "nvchad/volt" , lazy = true },
  { "nvchad/menu" , lazy = true },
}
