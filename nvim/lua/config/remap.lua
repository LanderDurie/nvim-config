vim.g.mapleader = " "

-- Open netrw/explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer (netrw)" })

-- Select & move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })

-- Keep cursor centered on page jump
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })

-- Keep cursor centered on search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match, center screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match, center screen" })

-- Paste over selection without yanking it
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without overwriting register" })
vim.keymap.set("x", "<leader>p", "<cmd>normal! p<CR>", { desc = "Paste normally with yank", noremap = true })

-- Remap Ctrl-C to Escape in insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl-C" })

-- Open a new tmux window with sessionizer
vim.keymap.set(
	"n",
	"<C-f>",
	"<cmd>silent !tmux neww tmux-sessionizer<CR>",
	{ desc = "Open new tmux sessionizer window" }
)

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item, center cursor" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item, center cursor" })

-- Location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item, center cursor" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item, center cursor" })

-- Replace all occurrences of current word
vim.keymap.set(
	"n",
	"<C-s>",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search & replace current word in buffer" }
)

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make current file executable", silent = true })

-- split windows
vim.keymap.set("n", "<leader>wj", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>wi", ":split<CR>", { desc = "Horizontal split" })

-- Move between windows using Ctrl + h/j/k/l
vim.keymap.set("n", "<C-b><C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-b><C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-b><C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-b><C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set("n", "<C-k>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-j>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>", { desc = "Increase window width" })
