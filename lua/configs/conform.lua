local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    python = { "ruff_format" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    elixir = { "mix" },
    css = { "prettierd" },
    fsharp = { "fantomas" },
    yaml = { "yamlfmt" },
    go = { "goimports-reviser", "gofmt" },
    vue = { "prettierd" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
