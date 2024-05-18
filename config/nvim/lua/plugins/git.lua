return {
  {
    "tpope/vim-fugitive", -- Git integration
    cmd = "Git",
  },
  {
    "lewis6991/gitsigns.nvim", -- pure lua git decorations
    cmd = "Gitsigns",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      numhl = true,
      word_diff = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
      },
    }
  },
  {
    "NeogitOrg/neogit",
    branch = "nightly",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
}
