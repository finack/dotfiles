return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local ensure_installed = {
        "vtsls",
        "biome",
        "tailwindcss",
        "eslint",
        "lua_ls",
        -- "rubocop",
        -- "rust_analyzer",
        -- "solargraph",
        -- "ruby_ls",
        "taplo",
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
      };

      require("mason-lspconfig").setup({
        handlers = handlers,
        ensure_installed = ensure_installed,
      })
    end,
  },
  -- { -- show your current code context in topbar
  --   "SmiteshP/nvim-navic",
  --   dependencies = "neovim/nvim-lspconfig",
  --   lazy = true,
  --   config = function()
  --     local navic = require("nvim-navic")
  --     navic.setup({
  --       highlight = true,
  --       separator = " > ",
  --       depth_limit = 0,
  --       depth_limit_indicator = "..",
  --       lsp = {
  --         auto_attach = true,
  --       },
  --     })
  --   end,
  --
  -- },

  -- Lua / Neovim development helper
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufnewFile" },
    dependencies = {
      {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
      }
    },
    config = function()
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
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- Enable completion triggered by <c-x><c-o>
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          require("lsp_signature").on_attach({
            -- ... setup options here ...
          }, bufnr)

          -- require("twoslash-queries").attach(client, bufnr)

          local keymap = function(mode, key, action, desc)
            vim.keymap.set(mode, key, action, { buffer = args.buf, remap = false, desc = desc })
          end

          keymap("n", "gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
          keymap("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
          keymap("n", "gr", vim.lsp.buf.references, "[g]o to [r]eferences")
          keymap("n", "gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
          keymap("n", "?", vim.lsp.buf.hover, "[k] show info (also just [K])")
          keymap("n", "<leader>lr", vim.lsp.buf.rename, "[R]rename symbol")
          keymap("n", "<leader>l=", vim.lsp.buf.format, "[=]reformat (also <leader>o) ")
          keymap("v", "<leader>l=", RangeFormatting, "reformat")
          keymap("n", "<leader>ld", vim.lsp.buf.type_definition, "[t]ype definition (LSP)")
          keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "loc list")
          keymap("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", "show diagnostics")

          -- keymap("n", "<leader>ll", vim.lsp.diagnostic.get_line_diagnostics, "line diagnostic")
          keymap("n", "g?", vim.lsp.buf.signature_help, "si[g]nature help")
          keymap({ "n", "v" }, "<leader>la", function() vim.lsp.buf.code_action({ apply = true }) end, "code [a]ction")
          keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "next diagnostic")
          keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "previous diagnostic")
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
    opts = {},
    keys = {
      { "<leader>lx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "show Diagnostics" },
      -- { "<C-q>",      "<cmd>Trouble diagnostics toggle<cr>",                        desc = "show Diagnostics" },
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
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>o",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "biome", "biome-check" } },
        toml = { "taplo" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        taplo = {
          inherit = false,
          command = "taplo",
          args = {
            "format",
            "-",
            "--option",
            "indent_tables=true",
            "indent_entries=true",
            "align_entries=true"
          },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("toggle_lsp_diagnostics").init()
      vim.keymap.set("n", "<leader>lq", ":ToggleDiag<cr>", { desc = "Toggle diagnostics" })
    end,
  },
  {
    -- Extensible UI for Neovim notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        filter = vim.log.levels.INFO,
        history_size = 1024,
        override_vim_notify = true,
      }
      -- options
    },
  },
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      openai_model_id = "gpt-4o",
    },
    keys = {
      {
        "gw",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "[g]oto [w]tf : Analyze Diagnostics with GPT4"
      },
    },
  }
}
