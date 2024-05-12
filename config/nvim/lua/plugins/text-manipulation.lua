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
        toggler = {
          line = "<leader>,",
          block = "<leader><",
        },
        opleader = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        extra = {
          ---Add comment on the line above
          above = '<leader>ccO',
          ---Add comment on the line below
          below = '<leader>co',
          ---Add comment at the end of line
          eol = '<leader>cA',
        },
      })
    end
  },
  {
    -- "AndrewRadev/splitjoin.vim", -- Split/Join ruby hashes, arglists, etc
    "echasnovski/mini.splitjoin",
    config = function()
      vim.keymap.set("n", "<leader>cs", vim.cmd.MiniSplitjoinSplit, { desc = "[s]plit block (SplitJoin)" })
      vim.keymap.set("n", "<leader>cS", vim.cmd.MiniSplitjoinSplit, { desc = "[S]plit block (SplitJoin)" })
      vim.keymap.set("n", "<leader>cj", vim.cmd.MiniSplitjoinJoin, { desc = "[j]oin block (SplitJoin)" })
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
