vim.keymap.set("n", "<leader>e", ":Explore<CR>", {noremap = true, silent = true, desc = "Open Netrw" })

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
