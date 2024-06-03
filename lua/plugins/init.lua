return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- format on save done with null-ls
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
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
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "yaml-language-server",
        "emmet-ls",
        "elixir-ls",
        "angular-language-server",
        "fsautocomplete",
        "fantomas",
        "texlab",
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
        "json",
        "c",
        "go",
        "elixir",
        "eex",
        "heex",
        "gleam",
        "angular",
      }
      return opts
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
}
