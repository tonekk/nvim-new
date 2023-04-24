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
vim.keymap.del("i", "<Tab>")

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

-- fugitive
local function showFugitiveGit()
  if vim.fn.FugitiveHead() ~= "" then
    vim.cmd([[
    Git
    " wincmd H  " Open Git window in vertical split
    " setlocal winfixwidth
    " vertical resize 31
    " setlocal winfixwidth
    setlocal nonumber
    setlocal norelativenumber
    ]])
  end
end
function ToggleFugitiveGit()
  if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
    vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
  else
    showFugitiveGit()
  end
end

map("n", "<leader>gg", showFugitiveGit, { desc = "Toggle fugitive" })

-- substitute
local substitute = require("substitute")
map("n", "s", substitute.operator, { desc = "   substitute the text object" })
map("n", "ss", substitute.line, { desc = "   substitute the current line" })
map("n", "S", substitute.eol, { desc = "   substitute until eol" })
map("v", "s", substitute.visual, { desc = "   substitute visual selection" })

-- testing
map(
  "n",
  "<leader>rf",
  ':let @+ = "bundle exec rspec " . expand("%") <CR>',
  { desc = "ﭧ copy test file with rspec cmd" }
)
map(
  "n",
  "<leader>rn",
  ':let @+ = "bundle exec rspec " . expand("%") . ":" . line(".") <CR>',
  { desc = "ﭧ copy nearest test for rspec" }
)
map("n", "<leader>tf", ':let @+ = expand("%") <CR>', { desc = "ﭧ copy test file" })
map("n", "<leader>tn", ':let @+ = expand("%") . ":" . line(".") <CR>', { desc = "ﭧ copy nearest test [file:line]" })

-- executing
map("n", "<leader>re", ":!ruby % <CR>", { desc = "  execute current file with ruby" })
map("n", "<leader>ee", ":!elixir % <CR>", { desc = "💧 execute current file with elixir" })

local telescope = require("telescope")
map("n", "<leader>nh", telescope.extensions.notify.notify, { desc = "Notification history" })

-- Closing buffers
map("n", "<leader>X", ":bd<CR>", { desc = "(X) close current buffer" })

map("n", "<Esc>", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss notifications" })
