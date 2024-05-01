return {
  { "simrat39/symbols-outline.nvim", opts = {} },
  { "m-demare/hlargs.nvim",          opts = {} },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('oil').setup({
        default_file_explorer = false,
        vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "pen parent folder" })
      })
    end
  },
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
  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]olor', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
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
    -- Integrated terminal
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<c-t>",
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      })
    end,
  },
  {
    "benlubas/wrapping-paper.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
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
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    version = "*",
    config = true,
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
      presets = { lsp_doc_border = true }

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
}
