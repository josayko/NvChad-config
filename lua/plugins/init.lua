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
        "prettierd",
        "eslint-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
        "pyright",
        "ruff",
        "isort",
        "yaml-language-server",
        "emmet-ls",
        "elixir-ls",
        "angular-language-server",
        "fantomas",
        "texlab",
        "gopls",
        "goimports-reviser",
        "denols",
        "pylint",
        "zls",
        "haskell-language-server",
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
        "zig",
        "rust",
        "haskell",
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
        -- typescript = { "deno" },
        -- javascriptreact = { "deno" },
        -- typescriptreact = { "deno" },
        -- vue = { "deno" },
        go = { "golangcilint" },
        python = { "ruff" },
      }
      -- lint.linters = {
      --   ruff = {
      --     -- Set ruff to work in virtualenv
      --     cmd = "python",
      --     stdin = false,
      --     args = { "-m", "ruff", "check" },
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
    lazy = true,
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "templ",
      "tmpl",
      "eex",
      "heex",
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
    lazy = true,
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
    lazy = true,
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            -- dialyzerEnabled = false,
            -- enableTestLenses = false,
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
    -- lazy = false,
    ft = { "tex", "latex", "markdown" },
    -- tag = "v2.15",
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
    ft = { "go", "gomod", "gotmpl", "tmpl" },
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
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "mfussenegger/nvim-dap",
      -- "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   lazy = false,
  --   config = function()
  --     require("supermaven-nvim").setup {
  --       keymaps = {
  --         accept_suggestion = "<Tab>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-x>",
  --       },
  --       -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
  --       -- color = {
  --       --   suggestion_color = "#ffffff",
  --       --   cterm = 244,
  --       -- },
  --       log_level = "info", -- set to "off" to disable logging completely
  --       disable_inline_completion = false, -- disables inline completion for use with cmp
  --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --       condition = function()
  --         return false
  --       end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
  --     }
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {}
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
