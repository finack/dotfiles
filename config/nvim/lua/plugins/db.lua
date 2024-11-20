return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    -- vim.g.db_ui_disable_mappings = 1       -- Disable all mappings
    -- vim.g.db_ui_disable_mappings_dbui = 1  --  Disable mappings in DBUI drawer
    -- vim.g.db_ui_disable_mappings_dbout = 1      --  Disable mappings in DB output
    vim.g.db_ui_disable_mappings_sql = 1        --  Disable mappings in SQL buffers
    vim.g.db_ui_disable_mappings_javascript = 1 --  Disable mappings in Javascript buffers (for Mongodb)
  end,
  keys = {
    { "<leader>dd", ":tabnew <BAR> :DBUI<cr>",         desc = "Dadbod UI" },
    { "<leader>dr", "<Plug>(DBUI_ToggleResultLayout)", ft = "sql",        desc = "Toggle Results" },
    { "<leader>dw", "<Plug>(DBUI_SaveQuery)",          ft = "sql" },
    { "<leader>de", "<Plug>(DBUI_EditBindParameters)", ft = "sql" },
    { "<leader>ds", "<Plug>(DBUI_ExecuteQuery)",       ft = "sql",        mode = { "n", "v" } },
  }
}


-- call db_ui#utils#set_mapping('<C-]>', '<Plug>(DBUI_JumpToForeignKey)')
-- call db_ui#utils#set_mapping('vic', '<Plug>(DBUI_YankCellValue)')
-- call db_ui#utils#set_mapping('yh', '<Plug>(DBUI_YankHeader)')
-- call db_ui#utils#set_mapping('<Leader>R', '<Plug>(DBUI_ToggleResultLayout)')
-- call db_ui#utils#set_mapping('<Leader>W', '<Plug>(DBUI_SaveQuery)')
-- call db_ui#utils#set_mapping('<Leader>E', '<Plug>(DBUI_EditBindParameters)')
-- call db_ui#utils#set_mapping('<Leader>S', '<Plug>(DBUI_ExecuteQuery)')
-- call db_ui#utils#set_mapping('<Leader>S', '<Plug>(DBUI_ExecuteQuery)', 'v')
