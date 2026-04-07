return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "cssls",
        "lua_ls",
        "pyright",
        "jsonls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
    dependencies = {
      "mason.nvim",
    },
  },
}
