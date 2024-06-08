return {
  -- Marks for navigating your project
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = {},
    -- stylua: ignore
    keys = {
      { '<leader>ha', function() require('harpoon'):list():add() end,     desc = 'Add Location' },
      { '<C-n>',      function() require('harpoon'):list():next() end,    desc = 'Next Location' },
      { '<C-p>',      function() require('harpoon'):list():prev() end,    desc = 'Previous Location' },
      { '<Leader>hr', function() require('harpoon'):list():remove() end,  desc = 'Remove Location' },
      { '<C-1>',      function() require('harpoon'):list():select(1) end, desc = 'Harpoon to File 1' },
      { '<C-22',      function() require('harpoon'):list():select(2) end, desc = 'Harpoon to File 2' },
      { '<C-3',       function() require('harpoon'):list():select(3) end, desc = 'Harpoon to File 3' },
      { '<C-4>',      function() require('harpoon'):list():select(4) end, desc = 'Harpoon to File 4' },
      { '<C-5>',      function() require('harpoon'):list():select(5) end, desc = 'Harpoon to File 5' },

      {
        '<LocalLeader>hl',
        function()
          local harpoon = require('harpoon')
          local conf = require("telescope.config").values
          local file_paths = {}
          for _, item in ipairs(harpoon:list().items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          }):find()
        end,
        desc = 'List locations'
      },
    },
  },
}
