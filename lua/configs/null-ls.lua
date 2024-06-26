local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
  sources = {
    null_ls.builtins.formatting.prettierd.with {
      filetypes = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "html",
        "md",
      },
    },
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.fantomas,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          require("conform").format { bufnr = bufnr }
        end,
      })
    end
  end,
}
return opts
