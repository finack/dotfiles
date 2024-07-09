-- borrowed from https://gitlab.com/oinak/dot_config_nvim
local telescope_config = function()
  local actions = require("telescope.actions")
  local fb_actions = require("telescope").extensions.file_browser.actions

  -- This is your opts table
  require("telescope").setup({
    defaults = {
      layout_strategy = "flex",
      layout_config = {
        flex = {
          flip_columns = 120,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["n"] = {
            -- your custom normal mode mappings
            ["n"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
            ["\\"] = actions.close,
            ["|"] = actions.close,
          },
        },
      },
    },
  })

  require("telescope").load_extension("ui-select")
  require('telescope').load_extension('fzf')
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("noice")

  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")
  local Job = require("plenary.job")

  local vks = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { noremap = true, desc = desc })
  end

  local function grep_string()
    builtin.grep_string({ search = "", only_sort_text = true })
  end

  -- borrowed from ThePrimeagen/harpoon/utils.lua
  local function get_os_command_output(cmd, cwd)
    if type(cmd) ~= "table" then
      print("Harpoon: [get_os_command_output]: cmd has to be a table")
      return {}
    end
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = Job:new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    }):sync()
    return stdout, ret, stderr
  end

  local function project_files()
    local _, ret, _ = get_os_command_output({
      "git",
      "rev-parse",
      "--is-inside-wirk-tree",
    })
    if ret == 0 then
      builtin.git_files({ prompt_title = "Git Files", prompt_prefix = ">>" })
    else
      builtin.find_files()
    end
  end

  -- direct commands
  vks("n", "<leader>b", builtin.buffers, "search [b]uffers")
  -- vks("n", "<leader>g", builtin.grep_string, "References")
  vks("n", "<leader>F", project_files, "search git [F]iles")
  vks("n", "<leader>f", builtin.find_files, "search [f]iles")

  -- search submenu

  -- vks("n", "<leader>st", function() builtin.tags({ fname_width = 50, show_line = false }) end, "Tags")
  vks("n", "<leader>s:", builtin.command_history, "Command history")
  vks("n", "<leader>sT", builtin.builtin, "Telescope")
  vks("n", "<leader>sc", builtin.colorscheme, "Colorchemes")
  vks("n", "<leader>se", builtin.symbols, "[e]mojis & symbols")
  vks("n", "<leader>sg", builtin.live_grep, "Find/grep")
  vks("n", "<leader>sld", builtin.diagnostics, "Diagnostics ")
  vks("n", "<leader>sli", builtin.lsp_incoming_calls, "[i]ncoming calls ")
  vks("n", "<leader>slr", builtin.lsp_references, "References")
  vks("n", "<leader>sls", builtin.lsp_document_symbols, "Symbols - document")
  vks("n", "<leader>slt", builtin.lsp_type_definitions, "Types")
  vks("n", "<leader>slw", builtin.lsp_workspace_symbols, "Symbols - workspace")
  vks("n", "<leader>so", builtin.oldfiles, "Recent Opened files")
  vks("n", "<leader>sp", builtin.spell_suggest, "Spelling suggestions")
  vks("n", "<leader>vc", builtin.commands, "[c]ommands")
  vks("n", "<leader>vh", builtin.help_tags, "[V]i [H]elp")
  vks("n", "<leader>vk", builtin.keymaps, "Key mappings")
  -- vks("n", "<leader>vn", ":Telescope noice<cr>", "Noice (messages)")
  vks("n", "<leader>vr", builtin.registers, "Registers")
  vks("n", "<leader><cr>", builtin.resume, "Resume previous search")
  vks("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(themes.get_dropdown({ winblend = 20, previewer = false, }))
  end, "[/] Fuzzily search in current buffer")
  -- Also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vks("n", "<leader>s/", function()
    builtin.live_grep { grep_open_files = true, prompt_title = "Live Grep in Open Files", }
  end, "[S]earch [/] in Open Files")
  vks("n", "|", function()
    local function telescope_buffer_dir()
      return vim.fn.expand("%:p:h")
    end

    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 },
    })
  end, "Open File Browser with the path of the current buffer")
  vks("n", "\\", function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      respect_gitignore = true,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 },
    })
  end, "Open File Browswer")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>u", "<cmd>Telescope undo<cr>", "[u]ndo tree" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
    config = telescope_config,
  },
  -- {
  --   "gnfisher/nvim-telescope-ctags-plus",
  --   config = function()
  --     local telescope = require('telescope')
  --     telescope.load_extension('ctags_plus')
  --     vim.keymap.set('n', 'g]', function()
  --       telescope.extensions.ctags_plus.jump_to_tag()
  --     end, { desc = 'jump to tag (telescope)', noremap = true, silent = true }
  --     )
  --   end
  -- },
  -- { "xiyaowong/telescope-emoji.nvim" },
}
