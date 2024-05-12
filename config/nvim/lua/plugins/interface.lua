return {
  { "simrat39/symbols-outline.nvim", opts = {} },
  { "m-demare/hlargs.nvim",          opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "╎", -- "┊",
        -- highlight = { "Comment" },
      },
      scope = { enabled = true },
    },
  },
  {
    "mbbill/undotree", -- visualize local undo tree
    cmd = "UndoTreeToggle",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
        desc = "Show [U]ndo tree",
      })
    end,
  },
  {
    -- window title
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
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').register {
        ['<leader>c'] = { name = '[C]hange', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        -- ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        ['<leader>lw'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = '[x] Trouble', _ = 'which_key_ignore' },
        ['<leader>v'] = { name = '[V]im', _ = 'which_key_ignore' },
      }
    end,
  },
  {
    -- status line enhancements
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "everforest",
        },
      })
    end,
  },
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
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true
  },
  {
    "kshenoy/vim-signature" -- marks on gutter
  },
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
    }
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
            or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#6699aa",
          }
          return buffer
        end,
      })
    end,
  },
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
}
