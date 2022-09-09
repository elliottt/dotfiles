
vim.cmd [[
    let mapleader = "\<space>"
    let maplocalleader = "\<bs>"
]]

vim.o.title = true

-- allow backspace beyond where insert started
vim.o.backspace = 'indent,eol,start'

-- search settings
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- slightly faster command timeout
vim.o.timeoutlen = 500

-- window settings
vim.o.scrolloff = 3
vim.o.ruler = true
vim.o.number = true

-- reload files that change outside of vim
vim.o.autoread = true

-- by default, assume 80 cols
vim.o.textwidth = 80
vim.o.colorcolumn = '+1'

-- highlight trailing space and tabs
vim.o.list = true
vim.o.lcs = 'tab:>-,trail:.'

-- spelling
vim.o.spelllang = 'en_us'

-- printing?
vim.o.printoptions = 'paper:letter'

-- completion options
vim.o.wildmode = 'longest:full,list:full'
vim.o.wildmenu = true
vim.o.wildignore = '*.o,*.hi,*.swp,*.bc,dist/*'

-- disable the visual bell
vim.o.errorbells = false

-- don't prompt to save when switching from a dirty buffer
vim.o.hidden = true

-- search upwards for tagfiles
vim.o.tags = './tags,tags;'

-- colors
vim.o.termguicolors = true
vim.cmd([[
    syntax enable
]])
