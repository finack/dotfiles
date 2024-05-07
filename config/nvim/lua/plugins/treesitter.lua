return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = "v0.22.5",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          -- "c",
          "html",
          "javascript",
          "lua",
          "markdown",
          "query",
          "ruby",
          "vim",
          "vimdoc",
        },
        sync_install = false,
        modules = { "highlight", "incremental_selection", "indent", "rainbow" },
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags
          max_file_lines = nil,
        },
      })
    end,
  },
  {
    -- treesitter to color delimiter pairs
    -- "mrjones2014/nvim-ts-rainbow",
    "HiPhish/rainbow-delimiters.nvim"
  },
  {
    -- Show code context (fixing scope lines to the top)
    "nvim-treesitter/nvim-treesitter-context",
  },
}
