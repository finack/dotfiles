return {
  -- {
  --   -- "projekt0n/github-nvim-theme",
  --   "Mofiqul/dracula.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- require("github-theme").setup({})
  --     require("dracula").setup({
  --       show_end_of_buffer = true,
  --       italic_comment = true
  --     })
  --
  --     vim.opt.termguicolors = true
  --     vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
  --
  --
  --     -- local function set_light()
  --     --   vim.cmd("colorscheme github_light_high_contrast")
  --     -- end
  --     --
  --     -- local function set_dark()
  --     --   vim.cmd("colorscheme github_dark_high_contrast")
  --     -- end
  --     --
  --     -- set_dark()
  --
  --     -- vim.keymap.set("n", "<space>cl", set_light, { desc = "[L]ight [c]olorsheme" })
  --     -- vim.keymap.set("n", "<space>cd", set_dark, { desc = "[D]ark [c]olorsheme" })
  --   end,
  -- },
  {
    'maxmx03/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      ---@type dracula
      local dracula = require "dracula"

      dracula.setup({
        transparent = false,
        -- on_colors = function (colors, color)
        --   ---@type dracula.palette
        --   return {
        --     -- override or create new colors
        --     mycolor = "#ffffff",
        --   }
        -- end,
        -- on_highlights = function(colors, color)
        --   ---@type dracula.highlights
        --   return {
        --     ---@type vim.api.keyset.highlight Normal = { fg = colors.mycolor }
        --   }
        -- end,
        plugins = {
          ["nvim-treesitter"] = true,
          ["nvim-lspconfig"] = true,
          ["nvim-navic"] = true,
          ["nvim-cmp"] = true,
          ["indent-blankline.nvim"] = true,
          ["neo-tree.nvim"] = true,
          ["nvim-tree.lua"] = true,
          ["which-key.nvim"] = true,
          ["dashboard-nvim"] = true,
          ["gitsigns.nvim"] = true,
          ["neogit"] = true,
          ["todo-comments.nvim"] = true,
          ["lazy.nvim"] = true,
          ["telescope.nvim"] = true,
          ["noice.nvim"] = true,
          ["hop.nvim"] = true,
          ["mini.statusline"] = true,
          ["mini.tabline"] = true,
          ["mini.starter"] = true,
          ["mini.cursorword"] = true,
        }
      })
      vim.cmd.colorscheme 'dracula'
      -- vim.cmd.colorscheme 'dracula-soft'
    end
  },
}
