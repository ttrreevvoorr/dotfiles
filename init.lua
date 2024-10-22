

-- Set options
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.paste = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cursorcolumn = true
vim.opt.statusline = "%F"
vim.opt.laststatus = 2
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldclose = "all"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.wildignore = { "*node_modules*" }
vim.opt.path:append(".,**")

-- Plugin management with lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-telescope/telescope.nvim', dependencies = { {'nvim-lua/plenary.nvim'} } },
		{ 'nvim-tree/nvim-tree.lua' },
		{ 'nvim-tree/nvim-web-devicons' },
    { 'vim-syntastic/syntastic' },
    {
        'neovim/nvim-lspconfig', -- LSP configurations
        config = function()
            -- Set up TypeScript LSP
            require('lspconfig').ts_ls.setup{
                on_attach = function(client, bufnr)
                    -- Key mappings for LSP functions
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                    -- Enable completion triggered by <c-x><c-o>
                    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                    -- Mappings.
                    local opts = { noremap=true, silent=true }
                    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                    buf_set_keymap('n', '<space>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
                    buf_set_keymap('n', '<space>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
                    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                end,
            }
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require'cmp'
            cmp.setup({
                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                },
            })
        end
    },
    {
        'sbdchd/neoformat',
        config = function()
            vim.g.neoformat_enabled_typescript = {'prettier'}
            vim.g.neoformat_enabled_javascript = {'prettier'}
        end
    }
}, {
    debug = true,
})

-- Auto format on save
vim.cmd [[
    autocmd BufWritePre *.ts Neoformat
]]

require'nvim-web-devicons'.get_icons()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Set colorscheme after plugins are loaded
vim.cmd.colorscheme "catppuccin"

-- Highlight settings
vim.cmd("hi Title ctermfg=White ctermbg=Black")
vim.cmd("hi TabLineFill ctermfg=Black ctermbg=White")
vim.cmd("hi TabLine ctermfg=Grey ctermbg=DarkGray")
vim.cmd("hi TabLineSel ctermfg=White ctermbg=DarkBlue")

-- Syntastic settings
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

-- Enable syntax highlighting
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")


local cmp = require'cmp'

cmp.setup({
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(), -- Move to the next suggestion
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- Move to the previous suggestion
        ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
        ['<C-e>'] = cmp.mapping.close(), -- Close completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Tab
    },
    sources = {
        { name = 'nvim_lsp' },
    },
})

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
