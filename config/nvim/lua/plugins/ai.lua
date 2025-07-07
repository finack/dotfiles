return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } }, -- Optional: For prettier markdown rendering
      { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = {
            slash_commands = {
              ['buffer'] = {
                opts = {
                  provider = 'fzf_lua', -- default|telescope|mini_pick|fzf_lua
                },
              },

              ['file'] = {
                opts = {
                  provider = 'fzf_lua', -- default|telescope|mini_pick|fzf_lua
                },
              },

              ['help'] = {
                opts = {
                  provider = 'fzf_lua', -- telescope|mini_pick|fzf_lua
                },
              },

              ['symbols'] = {
                opts = {
                  provider = 'fzf_lua', -- default|telescope|mini_pick|fzf_lua
                },
              },
            },
            adapter = 'anthropic',
          },
          inline = {
            adapter = 'anthropic',
          },
        },
        adapters = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {})
          end,
        },
      }
    end,
    keys = {
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Chat (CodeCompanion)', mode = { 'n', 'v' } },
      { '<leader>ai', '<cmd>CodeCompanionActions<cr>', desc = 'Actions (CodeCompanion)', mode = { 'n', 'v' } },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'Add to AI context (CodeCompanion)', mode = 'v' },
    },
  },

  -- Bink integration
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- default = { "lsp", "path", "buffer", "codecompanion" },
        default = { 'codecompanion' },
        providers = {
          codecompanion = {
            name = 'CodeCompanion',
            module = 'codecompanion.providers.completion.blink',
            enabled = true,
          },
        },
      },
    },
    opts_extend = {
      'sources.default',
    },
  },

  -- Edgy integration
  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = 'codecompanion',
        title = 'CodeCompanion Chat',
        size = { width = 50 },
      })
    end,
  },
}
