-- General {{{

-- Use indentation for folds
-- vim.opt.foldmethod = "indent"
vim.opt.foldmethod = 'marker'
vim.opt.foldnestmax = 5
-- vim.opt.foldlevelstart=99
vim.opt.foldcolumn = '0'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vim',
  callback = function()
    vim.opt.foldmethod = 'marker'
    vim.opt.foldlevel = 0
  end,
  group = vimrcFold
})

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file
if vim.mapleader == nil then
  vim.mapleader = ','
end

if vim.g.mapleader == nil then
  vim.g.mapleader = ','
end

-- Leader key timeout
vim.opt.timeoutlen = 2000

-------------------------------------------------------------------------------------------------------------------------- {{{
-- Allow the normal use of "," by pressing it twice
-- vim.api.nvim_buf_set_keymap(0, "n", ",,", ",")
-- noremap ,, ,
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
-- " Use par for prettier line formatting
-- set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"
-------------------------------------------------------------------------------------------------------------------------- }}}

-- " Kill the damned Ex mode.
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true })

-- Custom settings
-- filetype plugin indent on
vim.api.nvim_command('filetype plugin indent on')
-- }}}

-- lazy.nvim {{{
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Support bundles
  'ervandew/supertab',
  'moll/vim-bbye',
  'nathanaelkane/vim-indent-guides',
  'vim-scripts/gitignore',

  -- Git
  'tpope/vim-fugitive',
  'jreybert/vimagit',

  -- Bars, panels, and files
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'vim-airline/vim-airline',
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  'jeetsukumaran/vim-markology',
  'junegunn/fzf',
  'junegunn/fzf.vim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = 'nvim-lua/plenary.nvim',
  },

  -- -- Text manipulation
  'vim-scripts/Align',
  'simnalamburt/vim-mundo',
  'tpope/vim-commentary',
  'godlygeek/tabular',
  -- 'michaeljsmith/vim-indent-object',
  'easymotion/vim-easymotion',
  'ConradIrwin/vim-bracketed-paste',
  'tpope/vim-surround',
  'matze/vim-move',
  'mattn/emmet-vim',
  'Raimondi/delimitMate',
  'tpope/vim-endwise',
  -- 'vim-scripts/HTML-AutoCloseTag',
  'othree/xml.vim',

  -- Colorscheme
  'vim-scripts/wombat256.vim',
  -- 'folke/tokyonight.nvim',

  -- Autocomplete
  'github/copilot.vim',
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },

  -- Language support
  -- Go
  {
    'fatih/vim-go',
    cmd = 'GoUpdateBinaries',
  },
  -- Python
  -- Helm
  'towolf/vim-helm',
  -- Terraform
  'hashivim/vim-terraform',

  -- Custom bundles
  'mhinz/vim-startify',
})
-- }}}

-- Lua Plugins {{{
require('coc')
-- }}}

-- {{{ Vim User Interface

-- Set 7 lines to the cursor - when moving vertically using j/k
vim.opt.so = 7 -- scrolloff

-- Turn on the WiLd menu
vim.opt.wildmenu = true
-- Tab-complete files up to longest unambiguous prefix
vim.opt.wildmode = 'list:longest,full'

-- Always show current position,
vim.opt.ruler = true
vim.opt.number = true
vim.opt.title = true

-- Show trailing whitespace
vim.opt.list = true
-- But only interesting whitespace
if vim.o.listchars:match('eol:$') then
  vim.opt.listchars = 'tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+'
end

-- Height of the command bar
vim.opt.cmdheight = 1

-- Configure backspace so it acts as it should act
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap = vim.opt.whichwrap + '<,>,h,l'

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Makes search act like search in modern browsers
vim.opt.incsearch = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true

-- For regular expressions turn magic on
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.opt.mat = 2

-- No annoying sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- View registers
vim.api.nvim_set_keymap('n', '<leader>rr', '<ESC>:reg<CR>', { noremap = false, silent = true })

-- Turn mouse mode on
vim.api.nvim_set_keymap('n', '<leader>ma', '<ESC>:set mouse=a<CR>', { noremap = true, silent = true })

-- Turn mouse mode off
vim.api.nvim_set_keymap('n', '<leader>mo', '<ESC>:set mouse=<CR>', { noremap = true, silent = true })

-- Tagbar Toggle
vim.api.nvim_set_keymap('n', '<leader>t', '<ESC>:TagbarToggle<CR>', { noremap = true, silent = true })

-- Startify Shortcut
vim.api.nvim_set_keymap('n', '<leader>ss', '<ESC>:Startify<CR>', { noremap = true, silent = true })
-- nnoremap <leader>ss :Startify<cr>

-- Moving cursor in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- }}}

-- Colors and Fonts{{{
vim.cmd[[colorscheme wombat256mod]]
-- vim.cmd[[colorscheme tokyonight]]

--Adjust signscolumn to match wombat
vim.api.nvim_set_hl(0, 'SignColumn', { link = 'LineNr' })

-- Use pleasant but very visible search hilighting
vim.api.nvim_set_hl(
  0,
  'Search',
  {
    fg = '#ffffff', -- default: '#d787ff
    bg = '#e5786d', -- default: '#626262
    ctermfg = 'white',
    ctermbg = 'lightmagenta',
  }
)

-- Match wombat colors in nerd tree
vim.api.nvim_set_hl(0, 'Directory', { fg = '#8ac6f2' })

-- Searing red very visible cursor
vim.api.nvim_set_hl(0, 'Cursor', { bg = '#ff0000' })

-- Use same color behind concealed unicode characters
vim.api.nvim_set_hl(0, 'Conceal', {})

-- Use Unix as the standard file type
vim.opt.fileformats = 'unix,dos,mac'

-- Use powerline fonts for airline
if vim.g.airline_symbols == nil then
  vim.g.airline_symbols = {}
end

require('bufferline').setup{
  options = {
    numbers = 'buffer_id',
    diagnostics = 'coc',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    separator_style = 'thin',
    always_show_bufferline = true,
    sort_by = 'id',
  },
}
-- }}}

-- Files, backups and undo {{{

-- Turn backup off, since most stuff is in Git anyway...
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Open file prompt with current path
vim.api.nvim_set_keymap('n', '<leader>e', '<ESC>:e <C-R>=expand("%:p:h") . "/"<CR>', { noremap = false, silent = true })

-- Show undo tree
vim.api.nvim_set_keymap('n', '<leader>u', '<ESC>:MundoToggle<CR>', { noremap = false, silent = true })

-- -- Fuzzy find files
-- vim.api.nvim_set_keymap('n', '<leader><space>', '<ESC>:Files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>R', '<ESC>:Rg<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>r', '<ESC>:Rg <C-R><C-W>', { noremap = false, silent = true })

-- Telescope
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, {})
vim.keymap.set('n', '<leader>R', builtin.live_grep, {})
vim.keymap.set('n', '<leader>r', builtin.grep_string, {})
vim.keymap.set('n', '<leader>b<space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

-- }}}

-- Text, tab and indent related {{{

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- 1 tab == 2 spaces, unless the file is already
-- using tabs, in which case tabs will be inserted.
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Linebreak on 500 characters
vim.opt.linebreak = true
vim.opt.textwidth = 500

vim.opt.autoindent = true -- Auto indent
vim.opt.smartindent = true -- Smart indent
vim.opt.wrap = true -- Wrap lines

-- delimitMate
vim.g.delimitMate_expand_cr = 1

-- }}}

-- Moving around, tabs, windows and buffers {{{

-- Treat long lines as break lines (useful when moving around in them)
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- Move between windows with Ctrl + hjkl
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Disable highlight when <leader><cr> is pressed
-- but preserve cursor coloring
vim.api.nvim_set_keymap('n', '<leader><cr>', ':noh<CR>:hi Cursor guibg=#e5786d<CR>', { noremap = true, silent = true })

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line('$') then
      vim.api.nvim_command('normal! g`"')
    end
  end,
})

-- don't close buffers when you aren't displaying them
vim.opt.hidden = true

-- previous buffer, next buffer
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':bn<CR>', { noremap = true, silent = true })

-- delete buffer without closing pane
vim.api.nvim_set_keymap('', '<leader>bd', ':Bd<CR>', { noremap = true, silent = true })

-- -- fuzzy find buffers
-- vim.api.nvim_set_keymap('', '<leader>b<space>', ':Buffers<CR>', { noremap = true, silent = true })

-- }}}

-- Status line {{{

-- Always show the status line
vim.opt.laststatus = 2

-- }}}

-- nvim-tree {{{

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require('nvim-tree').setup({
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  sort_by = 'case_sensitive',
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

vim.api.nvim_set_keymap('n', '<leader>f', '<ESC>:NvimTreeToggle<CR>', { noremap = true, silent = true })

-- }}}

-- Alignment {{{

-- Stop Align plugin from forcing its mappings on us
vim.g.loaded_AlignMapsPlugin=1
-- Align on equal signs
vim.api.nvim_set_keymap('', '<leader>a=', '<ESC>:Align =<CR>', { noremap = false, silent = true })
-- Align on commas
vim.api.nvim_set_keymap('', '<leader>a,', '<ESC>:Align ,<CR>', { noremap = false, silent = true })
-- Align on pipes
vim.api.nvim_set_keymap('', '<leader>a|', '<ESC>:Align <bar><CR>', { noremap = false, silent = true })
-- Align on colons
vim.api.nvim_set_keymap('', '<leader>a:', '<ESC>:Align :<CR>', { noremap = false, silent = true })
-- Prompt for align character
vim.api.nvim_set_keymap('', '<leader>ap', '<ESC>:Align', { noremap = false, silent = true })

-- }}}

-- Git {{{
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gg', ':copen<CR>:Ggrep', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log<CR>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<CR>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = false, silent = true })
-- }}}

-- Completion {{{
vim.opt.completeopt = vim.opt.completeopt + 'longest'
-- }}}

-- Formatter {{{
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'python' then
      vim.api.nvim_set_keymap('n', '<leader>y', ':CocCommand editor.action.formatDocument<CR>', { noremap = true, silent = true })
    end
  end,
})
-- }}}

-- Customization {{{
vim.opt.clipboard = 'unnamedplus'

vim.opt.fileencodings = 'utf-8,euc-kr,default'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
  callback = function()
    -- vim.cmd([[syntax match Comment +\/\/.\+$+]])
    vim.opt_local.commentstring = '// %s'
  end,
})

vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
  pattern = '*Jenkinsfile*',
  callback = function()
    vim.opt.filetype = 'groovy'
  end,
})

vim.api.nvim_set_var('copilot_filetypes', {
  Jenkinsfile = true,
  yaml = true,
})

-- }}}

