
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "pyright",
          "rust_analyzer",
          "lua_ls",
        },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        clangd = {},
        pyright = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
          },
        },
      }

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.enable(name)

      end
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
  {
        "jglasovic/venv-lsp.nvim",
        config = function()
            require("venv-lsp").setup()
        end,
    }
}

