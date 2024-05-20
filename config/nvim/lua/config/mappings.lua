

-- Function to search selected text in Google
local function search_in_google()
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg('"')
  local escaped_text = vim.fn.escape(text, ' ')
  local search_url = "https://www.google.com/search?q=" .. escaped_text
  os.execute('echo -n "' .. text .. '" | pbcopy && open "' .. search_url .. '"')
end

vim.keymap.set('v', '<leader>gs', search_in_google, { noremap = true, silent = false })
