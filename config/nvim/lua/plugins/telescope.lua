-- borrowed from https://gitlab.com/oinak/dot_config_nvim
local telescope_config = function()
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
    },
  })

  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("noice")
  -- require("telescope").load_extension("emoji")

  -- Enable telescope fzf native, if installed
  pcall(require("telescope").load_extension, "fzf")

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
  vks("n", "<leader>b", builtin.buffers, "Buffers")
  vks("n", "<leader>g", builtin.grep_string, "References")
  vks("n", "<leader>F", project_files, "Paths")
  vks("n", "<leader>f", builtin.find_files, "Paths")
  vks("n", "<leader>c", builtin.commands, "Commands")
  -- project_files unifies git_files and find_files
  -- vks('n', '<leader>sf', builtin.git_files,              'Git files')
  -- vks('n', '<leader>sp', builtin.find_files,             'Paths' )

  -- search submenu
  vks("n", "<leader>sT", builtin.builtin, "Telescope")

  vks("n", "<leader>s:", builtin.command_history, "Command history")
  vks("n", "<leader>sc", builtin.colorscheme, "Colorchemes")
  vks("n", "<leader>ss", grep_string, "String (like ag)") -- Emulate fzf's Ag:
  vks("n", "<leader>sb", builtin.buffers, "Buffers")
  vks("n", "<leader>se", ":Telescope symbols<cr>", "[S] [E]mojis & symbols")
  vks("n", "<leader>sg", builtin.live_grep, "Find/grep")
  vks("n", "<leader>vh", builtin.help_tags, "[V]i [H]elp")
  vks("n", "<leader>vk", builtin.keymaps, "Key mappings")
  vks("n", "<leader>vn", ":Telescope noice<cr>", "Noice (messages)")
  vks("n", "<leader>vo", builtin.oldfiles, "Recent Opened files")
  vks("n", "<leader>vr", builtin.registers, "Registers")
  vks("n", "<leader>sl", builtin.lsp_references, "LSP References")
  vks("n", "<leader>sd", builtin.lsp_document_symbols, "Symbols - document")
  vks("n", "<leader>sw", builtin.lsp_workspace_symbols, "Symbols - workppace")
  vks("n", "<leader>st", function() builtin.tags({ fname_width = 50, show_line = false }) end, "Tags")
  vks("n", "<leader>sp", builtin.spell_suggest, "Spelling suggestions")
  -- vks("n", "<leader><leader>", builtin.resume, "Resume previous search")
  vks("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(themes.get_dropdown({ winblend = 20, previewer = false, }))
  end, "[/] Fuzzily search in current buffer")
  -- Also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vks("n", "<leader>s/", function()
    builtin.live_grep { grep_open_files = true, prompt_title = "Live Grep in Open Files", }
  end, "[S]earch [/] in Open Files")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but desired:
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = telescope_config,
  },
  {
    "gnfisher/nvim-telescope-ctags-plus",
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('ctags_plus')
      vim.keymap.set('n', 'g]', function()
        telescope.extensions.ctags_plus.jump_to_tag()
      end, { desc = 'jump to tag (telescope)', noremap = true, silent = true }
      )
    end
  },
  { "nvim-telescope/telescope-symbols.nvim" },
  -- { "xiyaowong/telescope-emoji.nvim" },
}
