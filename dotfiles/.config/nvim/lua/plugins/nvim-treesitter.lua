return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  build = ":TSUpdate",
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "typescript",
      "python",
      "fish",
      "css",
      "vim",
      "toml",
    },
  },
  config = function(_, opts)
    local ts = require("nvim-treesitter")
    ts.setup(opts)

    -- Install parsers and wait for completion
    ts.install(opts.ensure_installed):wait(300000)
  end,
}
