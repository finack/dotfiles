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

  -- window title
  {
    "fgheng/winbar.nvim", -- Show file path on first line of panes
    opts = {
      enabled = true,
      show_file_path = true,
      show_symbols = true,
      colors = {
        path = "", -- You can customize colors like #c946fd
        file_name = "",
        symbols = "",
      },
      icons = {
        file_icon_default = "",
        seperator = "/",
        editor_state = "●",
        lock_icon = "",
      },
      exclude_filetype = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "qf",
      },
    },
  },

  -- Add labels to keys
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').register {
        -- ['<leader>c'] = { name = '[c]hange', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[l]ang', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
        -- ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        -- ['<leader>lw'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        -- ['<leader>x'] = { name = '[x] Trouble', _ = 'which_key_ignore' },
        ['<leader>v'] = { name = '[v]im', _ = 'which_key_ignore' },
      }
    end,
  },

  -- status line enhancements
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "OceanicNext",
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

  -- floating statusline / filename
  {
    "b0o/incline.nvim",
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local devicons = require 'nvim-web-devicons'

      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = '', changed = '', added = '' }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { '┊ ' })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = '', warn = '', info = '', hint = '' }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { '┊ ' })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
            { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
            { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' },
          }
        end,
      })
    end,
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
