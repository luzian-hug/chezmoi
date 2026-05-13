return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function () require("lualine").setup() end
    },

    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("nvim-tree").setup({
            view = {
                side = "left",
                width = 30,
            },
        })
        end,
    },

    {
        "nvim-tree/nvim-web-devicons"
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "python", "javascript", "typescript", "rust", "lua" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim"}
    },

}

