return {
  {
    "ntpeters/vim-better-whitespace",
  },
  {
    -- jsx/tsx commenting
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  {
    "AndrewRadev/splitjoin.vim", -- Split/Join ruby hashes, arglists, etc
    config = function()
      -- Splitjoin keymaps
      vim.keymap.set("n", "gs", vim.cmd.SplitjoinSplit, { desc = "[S]plitjoin [S]plit" })
      vim.keymap.set("n", "gj", vim.cmd.SplitjoinJoin, { desc = "[S]plitjoin [J]oin" })
    end,
  },
  {
    "AndrewRadev/switch.vim", -- Automate common substitutions
    config = function()
      -- remap default mapping to add description
      vim.keymap.set("n", "gs", vim.cmd.Switch, { desc = "[S]witch toggle" })
    end,
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = '',            -- Add surrounding in Normal and Visual modes
          delete = 'ds',       -- Delete surrounding
          find = 'gs',         -- Find surrounding (to the right)
          find_left = 'gS',    -- Find surrounding (to the left)
          highlight = 'gh',    -- Highlight surrounding
          replace = 'cs',      -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = 'l',   -- Suffix to search with "prev" method
          suffix_next = 'n',   -- Suffix to search with "next" method
        },
      })
    end,
  },
}
