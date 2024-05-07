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
        "eslint",
        "lua_ls",
        -- "rubocop",
        -- "rust_analyzer",
        -- "solargraph",
        -- "ruby_ls",
        "vtsls",
        "taplo",
        "tailwindcss",
        "hydra_lsp",
        "tsserver",
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

      --[[ lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                "vim",
                "require",
              },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities,
        init_options = { formatting = false },
        settings = {
          solargraph = {
            diagnostics = true,
          },
        },
      })
      lspconfig.ruby_ls.setup({
        capabilities = capabilities,
        init_options = { formatting = false }
      })
      lspconfig["gopls"].setup({
        capabilities = capabilities,
      })
      lspconfig["rubocop"].setup({
        capabilities = capabilities,
        init_options = { formatting = true },
        -- Aquí puedes agregar la configuración específica para RuboCop
        settings = {
          rubocop = {
            -- Esto hará que los nombres de los cops se muestren en los mensajes de advertencia
            displayCopNames = true,
          },
        },
      }) ]]

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

          keymap("n", "gd", vim.lsp.buf.definition, "go to definition (LSP)")
          keymap("n", "gD", vim.lsp.buf.declaration, "go to declaration (LSP)")
          keymap("n", "gr", vim.lsp.buf.references, "go to [r]eferences (LSP)")
          keymap("n", "gi", vim.lsp.buf.implementation, "goto implementation (LSP)")
          keymap("n", "K", vim.lsp.buf.hover, "show info (LSP)")
          keymap("n", "R", vim.lsp.buf.rename, "rename symbol (LSP)") -- default is <F2>
          keymap("n", "g=", vim.lsp.buf.format, "reformat (LSP)")
          keymap("v", "g=", RangeFormatting, "reformat (LSP)")
          keymap("n", "gl", vim.lsp.diagnostic.get_line_diagnostics, "line diagnostic (LSP)")
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, "signature help (LSP)")
          keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder (LSP)")
          keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder (LSP)")
          keymap("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "(LSP) list workspace folders")
          keymap("n", "<space>D", vim.lsp.buf.type_definition, "type definition (LSP)")
          keymap({ "n", "v" }, "<space>ca", function()
            vim.lsp.buf.code_action({ apply = true })
          end, "code action (LSP)")
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    branch = "dev",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    -- config = function()
    -- vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
    -- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
    -- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
    -- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
    -- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
    -- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
    -- end
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
      })
    end,
  },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("toggle_lsp_diagnostics").init()
      vim.keymap.set("n", "<leader>xd", ":ToggleDiag<cr>", { desc = "Toggle LSP diagnostics (warnings)" })
    end,
  },
}
