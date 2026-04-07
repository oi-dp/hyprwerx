return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Required to bridge LSP and Autocomplete
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
      window = {
        hover = { border = "rounded" },
        signature_help = { border = "rounded" },
      },
    })

    local servers = { "ts_ls", "cssls", "lua_ls", "pyright", "jsonls" }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    vim.diagnostic.config({
      float = { border = "rounded" },
    })
  end,
}
