return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
    -- config = function()
    --   require("mason").setup()
    -- end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local ensure_installed = {
        "biome",
        -- "eslint",
        "lua_ls",
        -- "rubocop",
        -- "rust_analyzer",
        -- "solargraph",
        -- "ruby_ls",
        "vtsls",
        "taplo",
        "tailwindcss",
        -- "hydra_lsp",
        -- "tsserver",
        -- "gopls",
      };

      local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          require("rust-tools").setup {}
        end
      };

      require("mason-lspconfig").setup({
        handlers = handlers,
        ensure_installed = ensure_installed,
      })
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({}) -- must happen BEFORE lspconfig
    end,
  },                              -- init.lua support
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufnewFile" },
    config = function()
      require("neodev").setup({}) -- must happen BEFORE lspconfig
      local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local RangeFormatting = function()
        local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
        local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
        vim.lsp.buf.format({
          range = {
            ["start"] = { start_row, 0 },
            ["end"] = { end_row, 0 },
          },
          async = true,
        })
      end

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local keymap = function(mode, key, action, desc)
            vim.keymap.set(mode, key, action, { buffer = ev.buf, remap = false, desc = desc })
          end

          keymap("n", "<leader>ld", vim.lsp.buf.definition, "go to [d]efinition")
          keymap("n", "<leader>lD", vim.lsp.buf.declaration, "go to [D]eclaration")
          keymap("n", "<leader>lr", vim.lsp.buf.references, "go to [r]eferences")
          keymap("n", "<leader>li", vim.lsp.buf.implementation, "goto [i]mplementation")
          keymap("n", "<leader>lk", vim.lsp.buf.hover, "[k] show info (also just [K])")
          keymap("n", "<leader>lr", vim.lsp.buf.rename, "[R]rename symbol")
          keymap("n", "<leader>l=", vim.lsp.buf.format, "[=]reformat (also <leader>o) ")
          keymap("v", "<leader>l=", RangeFormatting, "reformat")
          -- keymap("n", "<leader>ll", vim.lsp.diagnostic.get_line_diagnostics, "line diagnostic")
          keymap("n", "<leader>lg", vim.lsp.buf.signature_help, "si[g]nature help")
          keymap("n", "<leader>lt", vim.lsp.buf.type_definition, "[t]ype definition (LSP)")
          keymap({ "n", "v" }, "<space>la", function() vim.lsp.buf.code_action({ apply = true }) end, "code [a]ction")
          -- keymap("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "add workspace folder (LSP)")
          -- keymap("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder (LSP)")
          -- keymap("n", "<leader>lwl", function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, "(LSP) list workspace folders")
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    branch = "dev",
    opts = {},
    keys = {
      { "<leader>lx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "show Diagnostics" },
      { "<C-q>",      "<cmd>Trouble diagnostics toggle<cr>",                        desc = "show Diagnostics" },
      { "<leader>lX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "show Buffer Diagnostics" },
      { "<leader>ls", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "show Symbols" },
      { "<leader>ll", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "show LSP Definitions / references / ..." },
      { "<leader>lL", "<cmd>Trouble loclist toggle<cr>",                            desc = "show Location List" },
      { "<leader>lQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "show oQuickfix List" },
    },
  },
  {
    -- Autoformat on save,
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          javascript = { { "biome", "biome-check" } },
        },
      })
    end,
    keys = {
      { "<leader>o", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "Format buffer" },
    },
  },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("toggle_lsp_diagnostics").init()
      vim.keymap.set("n", "<leader>xd", ":ToggleDiag<cr>", { desc = "Toggle LSP diagnostics" })
    end,
  },
}
