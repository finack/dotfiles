local map = vim.keymap.set
local unmap = vim.keymap.del

-- quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit All (don't save)" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All (don't save)" })
unmap("n", "<leader>l")
