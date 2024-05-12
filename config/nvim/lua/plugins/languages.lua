return {
  {
    "ludovicchabant/vim-gutentags",           -- Automatic update of CTAGS
    config = function()
      vim.opt.tags = '.tags'                  -- vim `g]` and `c-]` will look at this file
      vim.g.gutentags_ctags_tagfile = '.tags' -- gutentags will write to the same file

      vim.g.gutentags_ctags_extra_args = {
        "--exclude=.git", "--exclude=log", "--exclude=tmp", "--exclude=.bundle"
      }
      vim.g.gutentags_define_advanced_commands = 1
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
