return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({})

      vim.opt.termguicolors = true
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })

      local function set_light()
        vim.cmd("colorscheme github_light_high_contrast")
      end

      local function set_dark()
        vim.cmd("colorscheme github_dark_high_contrast")
      end

      set_dark()

      vim.keymap.set("n", "<space>cl", set_light, { desc = "[L]ight [c]olorsheme" })
      vim.keymap.set("n", "<space>cd", set_dark, { desc = "[D]ark [c]olorsheme" })
    end,
  },
}
