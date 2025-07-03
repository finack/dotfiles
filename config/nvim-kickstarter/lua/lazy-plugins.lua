require('lazy').setup({
  require 'plugins.ai',
  require 'plugins.autopairs',
  require 'plugins.blink-cmp',
  require 'plugins.catppucin',
  require 'plugins.conform',
  require 'plugins.indent_line',
  require 'plugins.fzf-lua',
  require 'plugins.gitsigns',
  require 'plugins.indent_line',
  require 'plugins.lspconfig',
  require 'plugins.mini',
  require 'plugins.precognition',
  require 'plugins.todo-comments',
  require 'plugins.treesitter',
  require 'plugins.trouble',
  require 'plugins.which-key',
  require 'plugins.snacks',

  -- require 'plugins.debug',
  -- require 'plugins.lint',
  -- require 'plugins.neo-tree',
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
