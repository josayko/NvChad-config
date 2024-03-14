local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- local servers = { "html", "cssls" }

-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   }
-- end

local yamlCompanionCfg = require("yaml-companion").setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
    -- detect k8s schemas based on file content
  builtin_matchers = {
    kubernetes = { enabled = true }
  },

  -- schemas available in Telescope picker
  schemas = {
    -- not loaded automatically, manually select with
    -- :Telescope yaml_schema
    {
      name = "Argo CD Application",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
    },
    {
      name = "SealedSecret",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"
    },
    -- schemas below are automatically loaded, but added
    -- them here so that they show up in the statusline
    {
      name = "Kustomization",
      uri = "https://json.schemastore.org/kustomization.json"
    },
    {
      name = "GitHub Workflow",
      uri = "https://json.schemastore.org/github-workflow.json"
    },
  },

  lspconfig = {
    settings = {
      yaml = {
        validate = true,
        schemaStore = {
          enable = false,
          url = ""
        },

        -- schemas from store, matched by filename
        -- loaded automatically
        schemas = require('schemastore').yaml.schemas {
          select = {
            'kustomization.yaml',
            'GitHub Workflow',
          }
        }
      }
    }
  }
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml")
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true
    }
  }
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.yamlls.setup(yamlCompanionCfg)

lspconfig.gleam.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
    'xml',
    'sass',
    'eex',
    'heex',
  };
}

lspconfig.angularls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
