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
        "RainbowCyan",
        "RainbowRed",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
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
    event = 'VeryLazy',
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').register {
        ['<leader>h'] = { name = 'harpoon', },
        ['<leader>l'] = { name = 'lang' },
        ['<leader>s'] = { name = 'search' },
        ['<leader>v'] = { name = 'vim' },

      }
    end,
  },

  -- status line enhancements
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "maxmx03/dracula.nvim" },
    config = function()
      local colors = require 'dracula.palette.init'

      local sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 4 } },
        lualine_c = {},
        lualine_x = { 'branch' },
        lualine_y = { 'diff',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },

            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
              hint = { fg = colors.purple },
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          },
        },
        lualine_z = {
          -- 'progress',
          'location'
        }
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
        sections = sections,
        inactive_sections = inactive_sections,
        options = {
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
  },

  -- Jump between nvim & tmux windows
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({ disable_on_zoom = false, mux = 'auto' })
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

  -- Use the tabline to show buffers
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",
          show_buffer_icons = false,
          right_mouse_command = "vertical sbuffer %d",
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          auto_toggle_bufferline = true,
          numbers = "ordinal",
          show_close_icon = false,
          show_buffer_close_icons = false,
        }
      })

      vim.api.nvim_set_keymap('n', 'gb', ':BufferLinePick<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gB', ':BufferLinePickClose<CR>', { noremap = true, silent = true })

      for i = 1, 9 do
        vim.api.nvim_set_keymap('n', '<leader>' .. i, ':lua require("bufferline").go_to(' .. i .. ')<CR>',
          { noremap = true, silent = true, desc = "which_key_ignore" })
      end
    end,
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    keys = {
      { '<leader>n',        '',                                                                            desc = '+notices' },
      { '<leader><leader>', function() require('noice').cmd('dismiss') end,                                desc = 'Noice Clear Messages' },
      { '<leader>nl',       function() require('noice').cmd('last') end,                                   desc = 'Noice Last Message' },
      { '<leader>nh',       function() require('noice').cmd('history') end,                                desc = 'Noice History' },
      { '<leader>na',       function() require('noice').cmd('all') end,                                    desc = 'Noice All' },
      { '<leader>nt',       function() require('noice').cmd('pick') end,                                   desc = 'Noice Picker (Telescope/FzfLua)' },
      { '<C-f>',            function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end,  silent = true,                           expr = true, desc = 'Scroll Forward',  mode = { 'i', 'n', 's' } },
      { '<C-b>',            function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end, silent = true,                           expr = true, desc = 'Scroll Backward', mode = { 'i', 'n', 's' } },
    },
    config = function()
      require('noice').setup({
        transparency = 0.6,
        cmdline = {
          view = "cmdline_popup",
          position = {
            row = "75%", -- position at the bottom
            col = "50%", -- center it horizontally
          },
        },
        lsp = {
          signature = { enabled = false },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = {
              -- kind = "lazy.nvim",
              find = "Config Change Detected",
            },
            view = 'mini',
            -- opts = { skip = true },
          },
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '^%d+ changes?; after #%d+' },
                { find = '^%d+ changes?; before #%d+' },
                { find = '^Hunk %d+ of %d+$' },
                { find = '^%d+ fewer lines;?' },
                { find = '^%d+ more lines?;?' },
                { find = '^%d+ line less;?' },
                { find = '^Already at newest change' },
                { kind = 'wmsg' },
                { kind = 'quickfix' },
                { find = 'written' },
              },
            },
            view = 'mini',
          },
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '^%d+ lines .ed %d+ times?$' },
                { find = '^%d+ lines yanked$' },
                { kind = 'emsg',                      find = 'E490' },
                { kind = 'search_count' },
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = 'notify',
              any = {
                { find = '^No code actions available$' },
                { find = '^No information available$' },
              },
            },
            view = 'mini',
          },
        }
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "wrapped-compact",
      timeout = 5000,
      stages = "fade_in_slide_out",
      max_width = 50,
    },
  },
}
