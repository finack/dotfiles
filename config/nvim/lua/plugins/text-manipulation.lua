return {
  {
    "ntpeters/vim-better-whitespace",
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
    end
  },
  {
    "AndrewRadev/splitjoin.vim", -- Split/Join ruby hashes, arglists, etc
    config = function()
      -- Splitjoin keymaps
      vim.keymap.set("n", "ss", vim.cmd.SplitjoinSplit, { desc = "[S]plitjoin [S]plit" })
      vim.keymap.set("n", "sj", vim.cmd.SplitjoinJoin, { desc = "[S]plitjoin [J]oin" })
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
    -- act on surrounding chars, like sr'"
    -- sa surround add
    -- sr surround replace
    -- sd surround delete
    -- sh surround highlight
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
      vim.keymap.set('n', '<leader>Sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        { desc = "Search current word" })
      vim.keymap.set('v', '<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',
        { desc = "Search current word" })
      vim.keymap.set('n', '<leader>Sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        { desc = "Search on current file" })
    end
  },
}
