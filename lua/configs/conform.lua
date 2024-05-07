local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    elixir = { "mix" },
    css = { "prettier" },
    fsharp = { "fantomas" },
  },
}

require("conform").setup(options)
