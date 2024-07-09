return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- version = "v0.22.5",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { -- treesitter to color delimiter pairs
        "HiPhish/rainbow-delimiters.nvim"
      },
      { -- Show code context (fixing scope lines to the top)
        "nvim-treesitter/nvim-treesitter-context",
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          -- "c",
          "diff",
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
}
