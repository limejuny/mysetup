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
  'majutsushi/tagbar',
  'jeetsukumaran/vim-markology',
  'junegunn/fzf',
  'junegunn/fzf.vim',

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

  -- Colorscheme
  'vim-scripts/wombat256.vim',
  -- 'folke/tokyonight.nvim',

  -- Autocomplete
  'github/copilot.vim',
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
})
-- }}}

-- {{{ Vim User Interface

-- Tagbar Toggle
vim.api.nvim_set_keymap('n', '<leader>t', '<ESC>:TagbarToggle<CR>', { noremap = true, silent = true })

-- }}}

-- Colors and Fonts{{{
vim.cmd[[colorscheme wombat256mod]]
-- vim.cmd[[colorscheme tokyonight]]
-- }}}

-- Files, backups and undo {{{

-- Turn backup off, since most stuff is in Git anyway...
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Show undo tree
vim.api.nvim_set_keymap('n', '<leader>u', '<ESC>:MundoToggle<CR>', { noremap = false, silent = true })

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

-- Customization {{{

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
  callback = function()
    -- vim.cmd([[syntax match Comment +\/\/.\+$+]])
    vim.opt_local.commentstring = '// %s'
  end,
})
-- }}}

