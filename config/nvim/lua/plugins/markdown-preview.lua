-- Markdown preview with Mermaid and complex content support
return {
  'iamcco/markdown-preview.nvim',
  ft = { 'markdown' },
  build = 'cd app && npm install',
  config = function()
    -- Configuration
    vim.g.mkdp_auto_start = 0 -- Don't auto start preview
    vim.g.mkdp_auto_close = 1 -- Auto close preview when switching buffers
    vim.g.mkdp_refresh_slow = 0 -- Refresh on save or leave insert mode
    vim.g.mkdp_command_for_global = 0 -- Only work in markdown files
    vim.g.mkdp_open_to_the_world = 0 -- Only accessible from localhost
    vim.g.mkdp_open_ip = '127.0.0.1'
    vim.g.mkdp_port = '8080'
    vim.g.mkdp_browser = '' -- Use system default browser
    vim.g.mkdp_echo_preview_url = 1 -- Echo preview URL
    vim.g.mkdp_browserfunc = '' -- Custom browser function
    
    -- Preview options
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {}, -- Enable PlantUML
      maid = {}, -- Enable Mermaid
      disable_sync_scroll = 0,
      sync_scroll_type = 'middle',
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = false,
      disable_filename = 0,
      toc = {}
    }
    
    -- Markdown CSS
    vim.g.mkdp_markdown_css = ''
    vim.g.mkdp_highlight_css = ''
    vim.g.mkdp_page_title = '「${name}」'
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_theme = 'dark'
    
    -- Keymaps (only in markdown files)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', vim.tbl_extend('force', opts, { desc = 'Markdown preview' }))
        vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', vim.tbl_extend('force', opts, { desc = 'Stop markdown preview' }))
        vim.keymap.set('n', '<leader>mt', '<cmd>MarkdownPreviewToggle<cr>', vim.tbl_extend('force', opts, { desc = 'Toggle markdown preview' }))
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et