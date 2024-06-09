return {
  -- color arguments in signatures
  { "m-demare/hlargs.nvim",                  opts = {} },

  -- code block actions
  { 'echasnovski/mini.ai',                   version = false },

  -- show whitespace char in visual mode
  { 'mcauley-penney/visual-whitespace.nvim', config = true },

  -- marks on gutter
  { "kshenoy/vim-signature" },

  -- show indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup {
        scope = { highlight = highlight },
        indent = {
          char = "╎", -- "┊",
          -- highlight = { "Comment" },
        },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  },

  -- Add labels to keys
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').register {
        ['<leader>h'] = { name = '[h]arpoon', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[l]ang', _ = 'which_key_ignore' },
        ['<leader>n'] = { name = '[n]otices', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
        ['<leader>v'] = { name = '[v]im', _ = 'which_key_ignore' },
      }
    end,
  },

  -- status line enhancements
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic", "maxmx03/dracula.nvim" },
    config = function()
      local navic = require 'nvim-navic'
      local colors = require 'dracula.palette.init'

      local winbar = {
        lualine_a = {},
        lualine_b = {
          {
            'filename',
          }
        },
        lualine_c = {
          {
            function()
              return navic.get_location()
            end,
            cond = function()
              return navic.is_available()
            end
          },
        },
        lualine_z = {
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic', 'nvim_lsp' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            colors = { bg = colors.base03 },

            diagnostics_color = {
              error = { bg = colors.base03, fg = colors.red },
              warn = { bg = colors.base03, fg = colors.yellow },
              info = { bg = colors.base03, fg = colors.cyan },
              hint = { bg = colors.base03, fg = colors.purple },
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          }
        },
      }
      local sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 4 } },
        lualine_c = {},
        lualine_w = { 'filetype' },
        lualine_y = { 'branch', 'diff', 'progress' },
        lualine_z = { 'location' }
      }
      local inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      }
      require("lualine").setup({
        winbar = winbar,
        inactive_winbar = winbar,
        sections = sections,
        inactive_sections = inactive_sections,
        options = {
          -- theme = "OceanicNext",
          theme = vim.g.colors_name,
          extensions = { "nvim-dapi-ui", "trouble" },
        },
      })
    end,
  },

  -- highlight current word
  {
    'tzachar/local-highlight.nvim',
    opts = {},
    -- config = function()
    --   require('local-highlight').setup({
    --     -- file_types = {'python', 'cpp'}, -- If this is given only attach to this
    --     -- -- OR attach to every filetype except:
    --     -- disable_file_types = {'tex'},
    --     -- hlgroup = 'Search',
    --     -- cw_hlgroup = nil,
    --     -- -- Whether to display highlights in INSERT mode or not
    --     -- insert_mode = false,
    --     -- min_match_len = 1,
    --     -- max_match_len = math.huge,
    --   })
    -- end
  },

  -- pretty messages
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = { signature = { enabled = false } },
      cmdline = { view = "cmdline" },
      presets = {
        lsp_doc_border = true,
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true
      }

    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    vim.keymap.set("n", "<leader>nl", function() require("noice").cmd("last") end, { desc = "[l]ast message", }),
    vim.keymap.set("n", "<leader>ne", function() require("noice").cmd("errors") end, { desc = "[e]rror messages", }),
    vim.keymap.set("n", "<leader><leader>", function() require("noice").cmd("dismiss") end,
      { desc = "[ ][ ] dismiss messages", }),
    vim.keymap.set("n", "<leader>nh", function() require("noice").cmd("telescope") end,
      { desc = "[h]istory of messages", }),
  },

  -- Jump between nvim & tmux windows
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
      vim.keymap.set({ 'n', 't' }, '<A-h>', '<CMD>NavigatorLeft<CR>')
      vim.keymap.set({ 'n', 't' }, '<A-l>', '<CMD>NavigatorRight<CR>')
      vim.keymap.set({ 'n', 't' }, '<A-k>', '<CMD>NavigatorUp<CR>')
      vim.keymap.set({ 'n', 't' }, '<A-j>', '<CMD>NavigatorDown<CR>')
      vim.keymap.set({ 'n', 't' }, '<A-p>', '<CMD>NavigatorPrevious<CR>')
    end
  },

  -- Jump to a place in the active window
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true
        },
        char = {
          jump_labels = true
        }
      }
    },
    keys = {
      {
        "<leader>j",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "[j]ump to word",
      },
      {
        "<leader>J",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "[J]ump with treesitter",
      },
      {
        "<leader>vF",
        mode = { "n", "o", "x" },
        function()
          require("flash").toggle(true)
        end,
        desc = "Enable Jump in search (flash)",
      },
      {
        "<leader>vf",
        mode = { "n", "o", "x" },
        function()
          require("flash").toggle(false)
        end,
        desc = "Disable Jump in search (flash)",
      },
    },
  },
}
