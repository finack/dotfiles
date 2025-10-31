return {
  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    keys = {
      { '<leader>du', '<cmd>DBUIToggle<cr>', desc = '[D]atabase [U]I Toggle' },
      { '<leader>db', '<cmd>%DB<cr>', desc = '[D]atabase Execute [B]uffer' },
      { '<leader>dp', '<cmd>.DB<cr>', desc = '[D]atabase Execute [P]aragraph/Line' },
      { '<leader>dp', ":'<,'>DB<cr>", mode = 'v', desc = '[D]atabase Execute [P]aragraph/Selection' },
      { '<leader>df', '<cmd>DBUIFindBuffer<cr>', desc = '[D]atabase [F]ind Buffer' },
      { '<leader>da', '<cmd>DBUIAddConnection<cr>', desc = '[D]atabase [A]dd Connection' },
      { '<leader>ds', function() require('snacks').scratch.select() end, desc = '[D]atabase [S]cratch Select' },
    },
    init = function()
      -- Database UI settings
      vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font and 1 or 0
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/db_ui'
      vim.g.db_ui_execute_on_save = 0
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod', 'saghen/blink.cmp' },
    ft = { 'sql', 'mysql', 'plsql' },
    config = function()
      -- Setup completion for SQL files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          -- Add dadbod completion to blink.cmp
          local blink = require('blink.cmp')
          local config = blink.config
          
          -- Add dadbod to sources if not already present
          if not vim.tbl_contains(config.sources.default, 'dadbod') then
            table.insert(config.sources.default, 'dadbod')
          end
          
          -- Configure dadbod provider
          config.sources.providers.dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
            enabled = true,
          }
          
          -- Update blink configuration
          blink.setup(config)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et