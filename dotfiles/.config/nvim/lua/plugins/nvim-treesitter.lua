return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  build = ":TSUpdate",
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "fish",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "toml",
      "typescript",
      "vim",
    },
  },
  config = function(_, opts)
    local ts = require("nvim-treesitter")

    if opts.ensure_installed and #opts.ensure_installed > 0 then
      ts.install(opts.ensure_installed, { summary = false }):wait(300000)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        plang(vim.treesitter.start, buf, lang)

        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Enable treesitter folding
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end,
}
