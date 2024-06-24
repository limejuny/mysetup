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
  'lewis6991/gitsigns.nvim',
  'rbong/vim-flog',
  'sindrets/diffview.nvim',
  {
    'NeogitOrg/neogit',
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- Bars, panels, and files
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  -- 'vim-airline/vim-airline',
  'nvim-lualine/lualine.nvim',
  {
    'akinsho/bufferline.nvim',
    version = '*',
    -- branch = 'main',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  'majutsushi/tagbar',
  -- 'jeetsukumaran/vim-markology',
  'chentoast/marks.nvim',

  'junegunn/fzf',
  'junegunn/fzf.vim',
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.3',
    branch = 'master',
    dependencies = 'nvim-lua/plenary.nvim',
  },

  -- Text manipulation
  'vim-scripts/Align',
  'simnalamburt/vim-mundo',
  -- 'tpope/vim-commentary',
  'godlygeek/tabular',
  -- 'michaeljsmith/vim-indent-object',
  'easymotion/vim-easymotion',
  'ggandor/lightspeed.nvim',
  'ConradIrwin/vim-bracketed-paste',
  'tpope/vim-surround',
  'matze/vim-move',
  'mattn/emmet-vim',
  'Raimondi/delimitMate',
  'tpope/vim-endwise',
  -- 'vim-scripts/HTML-AutoCloseTag',
  'othree/xml.vim',

  -- Colorscheme
  -- 'vim-scripts/wombat256.vim',
  -- 'folke/tokyonight.nvim',
  -- {
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       -- optional configuration here
  --     }
  --     require('bamboo').load()
  --   end,
  -- },
  'sainnhe/sonokai',

  -- Code Syntax
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'css',
          'dockerfile',
          'go',
          'gomod',
          'html',
          'javascript',
          'json',
          'lua',
          'python',
          'ruby',
          'terraform',
          'xml',
          'yaml',
        },
        sync_install = false,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  'nvim-treesitter/nvim-treesitter-context',

  -- Autocomplete
  'github/copilot.vim',
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'joshzcold/cmp-jenkinsfile',

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
-- vim.opt.whichwrap = vim.opt.whichwrap + '<,>,h,l'

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
vim.api.nvim_set_var('startify_session_persistence', 1)
vim.api.nvim_set_var('startify_disable_at_vimenter', 1)

-- Moving cursor in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Mark visualization
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}

-- }}}

-- Colors and Fonts{{{
local ok, _ = pcall(function()
  -- vim.cmd[[colorscheme wombat256mod]]
  -- vim.cmd[[colorscheme tokyonight]]
  vim.cmd[[colorscheme sonokai]]
end)
if not ok then
  vim.cmd[[colorscheme default]]
end

-- Adjust signscolumn to match wombat
vim.api.nvim_set_hl(0, 'SignColumn', { link = 'LineNr' })

-- Update default highlighting
local function update_hl(group, opts)
  local hl = vim.api.nvim_get_hl_by_name(group, true)
  for k, v in pairs(opts) do
    hl[k] = v
  end
  vim.api.nvim_set_hl(0, group, hl)
end
-- Use no italic for comments
update_hl('String', { italic = false })

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
-- if vim.g.airline_symbols == nil then
--   vim.g.airline_symbols = {}
-- end
-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline_symbols.space = '\\ua0'
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        path = 1,   -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'CocStatusChange',
  callback = function()
    vim.cmd[[redrawstatus]]
  end,
})

require('bufferline').setup{
  options = {
    numbers = 'buffer_id',
    indicator = {
      style = 'underline',
    },
    diagnostics = 'coc',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    -- show_tab_indicators = true,
    -- separator_style = 'thin',
    -- always_show_bufferline = true,
    -- sort_by = 'id',
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
vim.keymap.set('n', '<leader>x', builtin.grep_string, {})
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

-- Remember info about open buffers on close
vim.cmd[[set viminfo^=%]]

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

nvimtree = require('nvim-tree').setup({
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  sort_by = 'case_sensitive',
  view = {
    width = 40,
  },
  -- renderer = {
  --   group_empty = true,
  -- },
  filters = {
    dotfiles = true,
  },
  sync_root_with_cwd = true,
  -- update_cwd = true,
  update_focused_file = {
    enable = true,
    -- update_root = true,
  },
})

vim.api.nvim_set_keymap('n', '<leader>f', '<ESC>:NvimTreeToggle<CR>', { noremap = true, silent = true })

-- if no args, set cwd to current file directory, and one args, set cwd to arg
vim.api.nvim_create_user_command(
  'Cwd',
  function(opts)
    local args = opts.args or nil
    if args == nil or args == '' then
      vim.cmd('cd %:p:h')
    else
      vim.cmd('cd ' .. args)
    end
  end,
  {
    nargs = '?'
  }
)

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

require('gitsigns').setup {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}

-- Tagbar Toggle
vim.api.nvim_set_keymap('n', '<leader>N', '<ESC>:Neogit<CR>', { noremap = true, silent = true })

-- }}}

-- Completion {{{
vim.opt.completeopt = vim.opt.completeopt + 'longest'

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
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype({ "Jenkinsfile", "groovy" }, {
  sources = {
    {
      name = "jenkinsfile",
      option = {
        jenkins_url = "https://jenkins.co",
      },
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
})

vim.api.nvim_create_user_command(
  'CmpDisable',
  function(opts)
    require('cmp').setup({
      enabled = false,
    })
  end,
  {
    nargs = '?'
  }
)

vim.api.nvim_create_user_command(
  'CmpEnable',
  function(opts)
    require('cmp').setup({
      enabled = true,
    })
  end,
  {
    nargs = '?'
  }
)

-- }}}

-- Formatter {{{
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_keymap('n', '<leader>y', ':CocCommand editor.action.formatDocument<CR>', { noremap = true, silent = true })
  end,
})
-- }}}

-- Treesitter {{{
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
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

-- vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
--   pattern = '*Jenkinsfile*',
--   callback = function()
--     vim.opt.filetype = 'groovy'
--   end,
-- })

vim.api.nvim_set_var('copilot_filetypes', {
  Jenkinsfile = true,
  yaml = true,
})

-- }}}
