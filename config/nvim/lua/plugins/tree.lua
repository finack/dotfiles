return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      filters = {
        gitignore = false,
      },
      diagnostics = {
        enable = true,
      },
    }
    vim.keymap.set("n", "\\", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    vim.keymap.set("n", "|", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle file tree and show current file" })
  end,
}
