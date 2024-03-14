local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    python = { "isort", "black" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    elixir = { "mix" },
    css = { "prettier" },
    fsharp = { "fantomas" },
    yaml = { "yamlfmt" },
    go = { "goimports-reviser", "gofmt" },
  },
}

return options
