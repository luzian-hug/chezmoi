-- keymaps.lua

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>g", function() require("telescope.builtin").live_grep() end)

-- toggleterm
vim.keymap.set("n", "<F12>", function() require("toggleterm").toggle() end)
vim.keymap.set("t", "<F12>", function() require("toggleterm").toggle() end)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")


-- window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- save / exit shortcuts
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>x", ":x<CR>")

-- access clipboard
vim.keymap.set("n", "<C-S-c>", '"+y')
vim.keymap.set("n", "<C-S-v>", '"+p')
vim.keymap.set("i", "<C-S-v>", '<Esc>"+pa')

-- lsp
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float)


-- build and run
vim.keymap.set("n", "<F5>", function()
    if vim.g.project_run_cmd then
        vim.cmd("!" .. vim.g.project_run_cmd)
    else
        print("No run command set for this project")
    end
end)
