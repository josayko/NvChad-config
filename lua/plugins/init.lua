return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "eslint",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "pyright",
        "black",
        "isort",
        "yaml-language-server",
        "emmet-ls",
        "elixir-ls",
        "angular-language-server",
        "volar",
        "fsautocomplete",
        "fantomas",
        "texlab",
        "gopls",
        "goimports-reviser",
        "denols",
        "pylint",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "nvchad.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "vim",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "json",
        "python",
        "c",
        "go",
        "gotmpl",
        "templ",
        "elixir",
        "eex",
        "heex",
        "gleam",
        "angular",
        "yaml",
      }
      return opts
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "VeryLazy",
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        vue = { "eslint" },
        go = { "golangcilint" },
        python = { "pylint" },
      }
      -- lint.linters = {
      --   eslint_d = {
      --     -- dynamically enable/disable linters based on the context.
      --     cmd = "eslint",
      --     condition = function(ctx)
      --       return vim.fs.find(
      --         { "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs" },
      --         { path = ctx.filename, upward = true }
      --       )[1]
      --     end,
      --   },
      -- }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "templ",
      "tmpl",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },
  {
    "vim-crystal/vim-crystal",
    ft = "crystal",
    config = function()
      vim.g.crystal_auto_format = 1
    end,
  },
  {
    "gleam-lang/gleam.vim",
    ft = "gleam",
  },
  { "ionide/Ionide-vim", ft = "fsharp" },
  {
    "echasnovski/mini.animate",
    version = false,
    lazy = false,
    open = { enable = false },
    config = function()
      require("mini.animate").setup()
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    is_block_ui_break = true,
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  {
    "b0o/schemastore.nvim",
    ft = {
      "yaml",
      "yml",
      "json",
    },
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension "yaml_schema"
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        nextls = { enable = true },
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "oflisback/obsidian-bridge.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian-bridge").setup {
        obsidian_server_address = "http://localhost:27123",
        scroll_sync = true,
      }
    end,
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
    },
    lazy = true,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_indent_enabled = 1
      -- vim.g.vimtex_compile_latexmk_engines = {
      --   ["_"] = "-pdfdvi",
      -- }
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    lazy = false,
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
  {
    "catgoose/vue-goto-definition.nvim",
    event = "BufReadPre",
    opts = {
      filters = {
        auto_imports = true,
        auto_components = true,
        import_same_file = true,
        declaration = true,
        duplicate_filename = true,
      },
      filetypes = { "vue", "typescript" },
      detection = {
        nuxt = function()
          return vim.fn.glob ".nuxt/" ~= ""
        end,
        vue3 = function()
          return vim.fn.filereadable "vite.config.ts" == 1 or vim.fn.filereadable "src/App.vue" == 1
        end,
        priority = { "nuxt", "vue3" },
      },
      lsp = {
        override_definition = true, -- override vim.lsp.buf.definition
      },
      debounce = 200,
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enhanced_diff_hl = true,
    hooks = {
      diff_buf_win_enter = function(bufnr, winid, ctx)
        if ctx.layout_name:match "^diff2" then
          if ctx.symbol == "a" then
            vim.opt_local.winhl = table.concat({
              "DiffAdd:DiffviewDiffAddAsDelete",
              "DiffDelete:DiffviewDiffDelete",
            }, ",")
          elseif ctx.symbol == "b" then
            vim.opt_local.winhl = table.concat({
              "DiffDelete:DiffviewDiffDelete",
            }, ",")
          end
        end
      end,
    },
    lazy = false,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
}
