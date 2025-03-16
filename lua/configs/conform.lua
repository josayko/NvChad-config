local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
    python = { "ruff_format" },
    html = { "eslint" },
    markdown = { "eslint" },
    elixir = { "mix" },
    css = { "eslint" },
    fsharp = { "fantomas" },
    yaml = { "yamlfmt" },
    go = { "goimports-reviser", "gofmt" },
    vue = { "eslint" },
    zig = { "zigfmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
