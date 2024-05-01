return {
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup()
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  }

}
