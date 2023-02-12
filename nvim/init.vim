let mapleader = "\<Space>"

call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'tpope/vim-fugitive'
    Plug 'morhetz/gruvbox'
    Plug 'rust-lang/rust.vim'
    Plug 'mattn/webapi-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-obsession'
    Plug 'rhysd/vim-clang-format'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'rhysd/vim-llvm'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'kamykn/spelunker.vim'
    Plug 'dbeniamine/cheat.sh-vim'
    " Plug 'puremourning/vimspector'
    " autocompletion
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'ray-x/lsp_signature.nvim'
    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    " telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-telescope/telescope-dap.nvim'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'Pocco81/DAPInstall.nvim'
    " rust-tools
    Plug 'simrat39/rust-tools.nvim'
    " try to enable copy-paste
    Plug 'ojroques/nvim-osc52', {'branch': 'main'}
    Plug 'aklt/plantuml-syntax'
    Plug 'tyru/open-browser.vim'
    Plug 'weirongxu/plantuml-previewer.vim'
call plug#end()
syntax enable
filetype plugin indent on
" source init.vim
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>
" telescope setup
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" vim rc edit remap
" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" " Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" rust.vim
let g:rustfmt_autosave = 1
" gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 120 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard+=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download
" language package)
" " set noswapfile            " disable creating swap file
" " set backupdir=~/.cache/vim " Directory to store backup files.
set hidden
" LSP setup
set completeopt=menu,menuone,noselect

function FormatBuffer()
if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
 let cursor_pos = getpos('.')
 :%!clang-format
 call setpos('.', cursor_pos)
endif
endfunction

" FIXME: freezes nvim
" autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
" cpp
" automatically open quickfix window when AsyncRun command is executed
" set the quickfix window 6 lines height.
let g:asyncrun_open = 6
" ring the bell to notify you job finished
let g:asyncrun_bell = 1
" F10 to toggle quickfix window
" For delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:}"
" vimspector
" let g:vimspector_enable_mappings = 'HUMAN'

syntax enable
filetype plugin indent on
" treesitter setup
lua << EOF
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "cpp", "rust" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }
EOF

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  -- Setup lspconfig.
  local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      --Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

      -- Get signatures (and _only_ signatures) when in argument lists.
      require "lsp_signature".on_attach({
        doc_lines = 0,
        handler_opts = {
          border = "none"
        },
      })
  end

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require'lspconfig'.clangd.setup{ 
    on_attach = on_attach,
    cmd = {"clangd-12", "--background-index", "--clang-tidy"}
  }
  require'lspconfig'.pylsp.setup{}
EOF

lua <<EOF

local rt = require("rust-tools")

 rt.setup({
    })

local extension_path = '/home/askrebko/workspace/repos/enviroment/nvim/extensions/codelldb-x86_64-linux/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local cpptools_path = '/home/askrebko/workspace/repos/enviroment/nvim/extensions/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
local opts = {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<Leader><F5>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      --Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      -- buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

      -- Get signatures (and _only_ signatures) when in argument lists.
      require "lsp_signature".on_attach({
        doc_lines = 0,
        handler_opts = {
          border = "none"
        },
      })
    end,
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path, liblldb_path)
  }
}

-- disable rust tools while debugging cpp config
-- require('rust-tools').setup(opts)

local dap = require('dap')
-- dap.adapters.codelldb = {
--  type = 'server',
--  port = "${port}",
--  executable = {
    -- CHANGE THIS to your path!
--    command = codelldb_path,
--    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
--  }
--}
--dap.configurations.cpp = {
--  {
--    name = "Launch file",
--    type = "codelldb",
--    request = "launch",
--    program = '${workspaceFolder}/bin/intel64/Debug/vpuxFuncTests',
--    cwd = '${workspaceFolder}',
--    stopOnEntry = true,
--    args = {"--gtest_filter=*MemoryLSTM*"},
--  },
--}
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cpptools_path,
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    miDebuggerPath = '/usr/bin/gdb',
    program = '${workspaceFolder}/bin/intel64/Debug/benchmark_app',
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    args = {' " -m /home/askrebko/workspace/tmp/conformance_dump/converted_models/public/bert-base-ner/FP16/bert-base-ner.xml -d VPUX.3720 -shape "[1,?]" -data_shape "[1,64]" " '}
  },
-- dap.configurations.cpp = {
--   {
--    name = "Launch file",
--    type = "cppdbg",
--    request = "launch",
--    miDebuggerPath = '/usr/bin/gdb',
--    program = '${workspaceFolder}/bin/intel64/RelWithDebInfo/vpuxFuncTests',
--    cwd = '${workspaceFolder}',
--    stopAtEntry = true,
--    args = {'"--gtest_filter=*MemoryLSTM*"'},
--  },
--  {
--    name = 'Attach to gdbserver :1234',
--    type = 'cppdbg',
--    request = 'launch',
--    MIMode = 'gdb',
--    miDebuggerServerAddress = 'localhost:1234',
--    miDebuggerPath = '/usr/bin/gdb',
--    cwd = '${workspaceFolder}',
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--    end,
--  },
}
require("dapui").setup()
EOF

lua <<EOF
    local function set_keymap(...) vim.api.nvim_set_keymap(...) end

    local opts = { noremap=true, silent=true }
    set_keymap("n", "<F2>", ":lua require('dapui').toggle()<CR>", opts)

    set_keymap("n", "<F5>", ":lua require('dap').continue()<CR>", opts)
    set_keymap("n", "<F3>", ":lua require('dap').terminate()<CR>", opts)

    set_keymap("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", opts)

    set_keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", opts)
    set_keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", opts)
    set_keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", opts)

    set_keymap("n", "<Leader>dsc", ":lua require('dap').continue()<CR>", opts)
    set_keymap("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>", opts)
    set_keymap("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>", opts)
    set_keymap("n", "<Leader>dso", ":lua require('dap').step_out()<CR>", opts)

    set_keymap("n", "<Leader>dk", ":lua require('dap').up()<CR>", opts)
    set_keymap("n", "<Leader>dj", ":lua require('dap').down()<CR>", opts)

    set_keymap("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>", opts)
    set_keymap("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>", opts)

    set_keymap("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>", opts)
    set_keymap("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", opts)

    set_keymap("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>", opts)
    set_keymap("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>", opts)

    set_keymap("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
    set_keymap("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>", opts)
    set_keymap("n", "<Leader>dtb", ":lua require('dap').toggle_breakpoint()<CR>", opts)

    set_keymap("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>", opts)
    set_keymap("n", "<Leader>di", ":lua require('dapui').toggle()<CR>", opts)

EOF

