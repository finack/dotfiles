require('lazy').setup({
  require 'plugins.autopairs',
  require 'plugins.catppucin',
  require 'plugins.conform',
  require 'plugins.gitsigns',
  require 'plugins.lspconfig',
  require 'plugins.mini',
  require 'plugins.todo-comments',
  require 'plugins.treesitter',
  require 'plugins.trouble',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.which-key',
  require 'plugins.snacks',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
