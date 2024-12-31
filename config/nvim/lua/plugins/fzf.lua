return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep FOO" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>sw", LazyVim.pick("grep_cword", { root = false }), desc = "Grep Word (cwd)" },
      { "<leader>sw", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_cword"), desc = "Grep Word (Root Dir)" },
      { "<leader>sW", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    },
  },
}
