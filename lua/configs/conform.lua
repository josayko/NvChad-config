local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    javascriptreact = { "deno_fmt" },
    typescriptreact = { "deno_fmt" },
    python = { "isort", "black" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    elixir = { "mix" },
    css = { "prettierd" },
    fsharp = { "fantomas" },
    yaml = { "yamlfmt" },
    go = { "goimports-reviser", "gofmt" },
    vue = { "deno_fmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
