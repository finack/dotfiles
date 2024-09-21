local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local function cmp_setup()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  -- require("luasnip.loaders.from_vscode").lazy_load()
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  -- initialize global var to false -> nvim-cmp turned off per default
  vim.g.cmptoggle = true
  vim.keymap.set(
    "n",
    "<leader><tab>",
    "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>",
    { desc = "toggle nvim-cmp" }
  )

  cmp.setup({
    enabled = function()
      return vim.g.cmptoggle
    end,
    -- snippet = {
    --   expand = function(args)
    --     require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    --   end,
    -- },
    view = {
      entries = "custom", -- custom, native, wildmenu
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- ["<leader><leader>"] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      -- ["<CR>"] = cmp.mapping({
      -- 	i = function(fallback)
      -- 		if cmp.visible() and cmp.get_active_entry() then
      -- 			cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      -- 		else
      -- 			fallback()
      -- 		end
      -- 	end,
      -- 	s = cmp.mapping.confirm({ select = true }),
      -- 	c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      -- }),
    }),
    sources = {
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" }, -- plugin excludes itself from non-lua buffers
      { name = "path" },
      -- { name = "luasnip" },
      -- { name = "cmdline" },
      -- { name = "ctags" },
      { name = "buffer",  keyword_length = 3 },
    },
    formatting = {
      format = lspkind.cmp_format({
        fields = { 'abbr', 'kind', 'menu' },
        expandable_indicator = '▾',
        mode = "symbol", -- show symbol + text annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        menu = {
          buffer    = "",
          nvim_lsp  = "",
          nvim_lua  = "󱂛",
          path      = "",
          gh_issues = "",
          ctags     = "",
        },
        symbol_map = { Copilot = "", Supermaven = "" },
      }),
    },
  })

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = "buffer" },
    }),
  })
end

return {
  -- Autocompletion
  { "hrsh7th/nvim-cmp",    config = cmp_setup },
  { "hrsh7th/cmp-buffer" },   -- completions from buffer
  { "hrsh7th/cmp-path" },     -- completions from paths
  { "hrsh7th/cmp-cmdline" },  -- completions from cmd line
  { "hrsh7th/cmp-nvim-lsp" }, -- completions from LSP
  -- { "hrsh7th/cmp-nvim-lua" }, -- neovim lua API
  -- { "delphinus/cmp-ctags" },  -- completions from Ctags

  -- Snippets
  -- { "L3MON4D3/LuaSnip" },
  -- { "saadparwaiz1/cmp_luasnip" },     -- LuaSnip completions
  -- { "rafamadriz/friendly-snippets" }, -- vscode-like snippes

  -- UI
  { "onsails/lspkind.nvim" }, -- add nerd icons to completion menu sources

  -- Signature
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
      vim.keymap.set("n", "<C-k>", function()
        require("lsp_signature").toggle_float_win()
      end, { silent = true, noremap = true, desc = "toggle signature" })
    end,
  },
}
