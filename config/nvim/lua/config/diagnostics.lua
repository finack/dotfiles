vim.keymap.set("n", "gx", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<C-q>", vim.diagnostic.setloclist)
vim.keymap.set("n", "gl", vim.lsp.diagnostic.get_line_diagnostics)
vim.diagnostic.config({
  underline = true,
  -- virtual_text = true,
  virtual_text = {
    source = true, -- Or "if_many"
    spacing = 15,
    prefix = "", -- Could be '■', '▎', 'x'
  },
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    source = "always", -- Or "always"
  },
})
