return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        vim.keymap.set('n', '<leader>gl', gitsigns.blame_line, { buffer = bufnr, desc = 'git [b]lame line' })
        vim.keymap.set('n', '<leader>gL', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = 'Toggle git show de[L]eted' })
      end,
    },
  },
}
