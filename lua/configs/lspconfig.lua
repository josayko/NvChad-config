local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
  "lua_ls",
  "ts_ls",
  "emmet_ls",
  "eslint",
  "volar",
  "gopls",
  "texlab",
  "denols",
  "angularls",
  "fsautocomplete",
  "templ",
  "tailwindcss",
  "rust_analyzer",
  "pyright",
  "gleam",
  "yamlls",
}

vim.lsp.enable(servers)

lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
}

lspconfig.eslint.setup {
  root_dir = util.root_pattern "eslint.config.js",
}

lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/Users/josayko/.asdf/installs/nodejs/22.11.0/lib/node_modules/@vue/language-server/",
        languages = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_dir = util.root_pattern "package.json",
  single_file_support = false,
}

-- You must make sure volar is setup
-- e.g. require'lspconfig'.volar.setup{}
-- See volar's section for more information
local function get_typescript_server_path(root_dir)
  local global_ts = "/Users/josayko/.asdf/installs/nodejs/22.11.0/lib/node_modules/typescript/lib"
  -- Alternative location if installed as root:
  -- local global_ts = "/usr/local/lib/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup {
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    new_config.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
  end,
}

lspconfig.emmet_ls.setup {
  filetypes = {
    "css",
    "html",
    "javascriptreact",
    "sass",
    "scss",
    "typescriptreact",
    "vue",
    "htmlangular",
    "heex",
    "tmpl",
    "templ",
    "template",
  },
}

lspconfig.denols.setup {
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    lint = true,
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
}
