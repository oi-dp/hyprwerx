return {
  {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    config = function()
      require("autoclose").setup({
        keys = {
          -- enable $ in markdown files
          ["$"] = {
            escape = true,
            close = true,
            pair = "$$",
            enabled_filetypes = { "markdown" },
          },
          ["<"] = {
            escape = false,
            close = true,
            pair = "<>",
            disable_command_mode = true,
          },
          ["'"] = {
            escape = true,
            close = false,
          },
        },
        options = {
          pair_spaces = true,
        },
      })

      local function smart_quote_pair()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ""

        -- notice that col is 0-based, string is 1-based
        local prev_char = col > 0 and current_line:sub(col, col) or ""
        local next_char = col < #current_line and current_line:sub(col + 1, col + 1) or ""
        -- if next_char is ', always skip it
        if next_char == "'" then
          return "<Right>"
          -- otherwise, if prev_char is a letter, no close
        elseif prev_char:match("[a-zA-Z]") then
          return "'"
        else
          return "''<Left>"
        end
      end

      vim.keymap.set("i", "'", smart_quote_pair, { expr = true, noremap = true, silent = true })
    end,
  },
}
