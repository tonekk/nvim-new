local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

-- NvimTmuxNavigation
local nvim_tmux_nav = require("nvim-tmux-navigation")

map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Move left" })
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Move down" })
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Move up" })
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Move right" })

-- Bufferline
map("n", "<Left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<Right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- neotree
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle neotree" })
