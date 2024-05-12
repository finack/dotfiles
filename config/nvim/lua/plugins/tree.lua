return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
          mappings = {
            ["v"] = "open_vsplit",
            ["s"] = "open_split",
          },
        },
      })
      vim.keymap.set("n", "\\", "<cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })
      vim.keymap.set("n", "|", "<cmd>Neotree toggle dir=%:p:h<CR>")
      vim.keymap.set("n", "<leader>G", "<cmd>Neotree float git_status git_base=main<CR>", { desc = "[G]it Status" })
    end
  }
}
