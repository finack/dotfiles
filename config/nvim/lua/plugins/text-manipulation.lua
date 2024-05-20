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
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "echasnovski/mini.splitjoin",
    config = function()
      require("mini.splitjoin").setup({
        -- mappings = {
        --   toggle = "<leader>cs",
        --   split = "<leader>cS",
        --   joint = "<leader>cj",
        -- },
      })
    end

  },
  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup({
        mappings = {
          -- add = '',            -- Add surrounding in Normal and Visual modes
          -- delete = 'ds',       -- Delete surrounding
          -- find = 'gs',         -- Find surrounding (to the right)
          -- find_left = 'gS',    -- Find surrounding (to the left)
          -- highlight = 'gh',    -- Highlight surrounding
          -- replace = 'cs',      -- Replace surrounding
          -- update_n_lines = '', -- Update `n_lines`
          --
          -- suffix_last = 'l',   -- Suffix to search with "prev" method
          -- suffix_next = 'n',   -- Suffix to search with "next" method
        },
      })
    end,
  },
}
