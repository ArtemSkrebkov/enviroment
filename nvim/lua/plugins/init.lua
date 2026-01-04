return {
  'scrooloose/nerdtree',
  'christoomey/vim-tmux-navigator',
  'tpope/vim-fugitive',
  'morhetz/gruvbox',
  'rust-lang/rust.vim',
  'mattn/webapi-vim',
  'tpope/vim-commentary',
  'tpope/vim-obsession',
  'rhysd/vim-clang-format',
  'skywind3000/asyncrun.vim',
  'rhysd/vim-llvm',
  'kamykn/spelunker.vim',
  'dbeniamine/cheat.sh-vim',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'ray-x/lsp_signature.nvim',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-fzy-native.nvim',
  'nvim-treesitter/nvim-treesitter',
  'simrat39/rust-tools.nvim',
  'ojroques/nvim-osc52',
  'aklt/plantuml-syntax',
  'tyru/open-browser.vim',
  'weirongxu/plantuml-previewer.vim',
  'vim-airline/vim-airline',
  'nvim-tree/nvim-web-devicons',
  'pwntester/octo.nvim',
  'github/copilot.vim',
  'nvim-neotest/nvim-nio',
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'polarmutex/git-worktree.nvim',
    version = '^2',
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
