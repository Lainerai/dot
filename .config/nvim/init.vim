set encoding=utf8
set termguicolors
set mouse=a
set ruler
set number
set mouse=a
syntax enable
set ai
set si
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set hlsearch
set incsearch
set nobackup
filetype plugin on
filetype indent on

autocmd StdinReadPre * let s:std_in=1

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'scrooloose/nerdtree'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gko/vim-coloresque'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'voldikss/vim-floaterm'
Plug 'dart-lang/dart-vim-plugin'
Plug 'turbio/bracey.vim'

call plug#end()

let g:lsc_auto_map = v:true
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_auto_open = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_ignore = [ ".cache", ".git", "node_modules", "data" ]
let g:gruvbox_material_background = "hard"
colorscheme gruvbox-material

inoremap jj <Esc>
nmap <C-n> :NvimTreeToggle<CR>
nmap <F6> :NvimTreeRefresh<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Make new window
nmap <C-a> :vsplit<CR>
nmap <C-s> :split<CR>
" Open terminal
nmap <S-w>a :vsplit term://zsh<CR>
nmap <S-w>s :split term://zsh<CR>

" nvim-bufferline.lua
nmap <TAB> :BufferLineCyclePrev<CR>
nmap <S-TAB> :BufferLineCycleNext<CR>

nmap <C-x> :Denite file/rec<CR>

" Define mappings
command! -nargs=0 Prettier :CocCommand prettier.formatFile

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

lua << EOS
require('bufferline').setup{
    options = {
        indicator_icon = "▋",
        max_name_length = 14,
        separator_style = "thin"
    },
    highlights = {
        -- Focused Window
        buffer_selected = {
            guibg = "#282828",
            gui = "bold"
        },
        modified_selected = {
            guibg = "#282828"
        },
    }
}

EOS

lua << EOS
local gl = require("galaxyline")
local gls = gl.section

local colors = {
    bg = "#1d2021",
    fg = "#f1fdc7",

    bgAlt = "#282828",

    red = "#EA6962",
    green = "#A9B665",
    yellow = "#FFC745",
    cyan = "#7DAEA3"
}

gl.short_line_list = { "NvimTree" }

gls.left[1] = {
    StartBorder = {
        provider = function()
            return "▋"
        end,
        highlight = { colors.cyan, colors.bgAlt }
    }
}

gls.left[2] = {
    ViMode = {
        provider = function()

            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
                c = 'COMMAND',
                V = 'VISUAL',
                [''] = 'VISUAL',
                v = 'VISUAL',
                R = 'REPLACE',
            }

            local mode = alias[vim.fn.mode()]

            if mode == nil then
                return "  TERM "
            else
                return "  " .. mode .. " "
            end

        end,
        separator = "",
        separator_highlight = { colors.bgAlt, colors.bgAlt },
        highlight = { colors.fg, colors.bgAlt }
    }
}

gls.left[3] = {
    Separator = {
        provider = function()
            return " "
        end,
        highlight = { colors.bg, colors.bg }
    }
}

gls.right[1] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = { colors.yellow, colors.bg }
    }
}

gls.right[2] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = { colors.red, colors.bg }
    }
}

gls.right[3] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = { colors.red, colors.bg }
    }
}


gls.right[4] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = { colors.yellow, colors.bg }
    }
}

gls.right[5] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        separator = " ",
        separator_highlight = { colors.bgAlt, colors.bgAlt },
        highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bgAlt }
    }
}

gls.right[6] = {
    FileName = {
        provider = "FileName",
        condition = buffer_not_empty,
        highlight = { colors.fg, colors.bgAlt }
    }
}

gls.right[7] = {
    LineColumn = {
        provider = "LineColumn",
        condition = buffer_not_empty,
        separator = " ",
        separator_highlight = { colors.bg, colors.bg },
        highlight = { colors.fg, colors.bg }
    }
}

gls.right[8] = {
    EndBorder = {
        provider = function()
            return "▋"
        end,
        highlight = { colors.cyan, colors.bg }
    }
}

-- Short Line

gls.short_line_left[1] = {
    Space = {
        provider = function()
            return " "
        end,
    }
}

gls.short_line_left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
    }
}

gls.short_line_left[3] = {
    FileName = {
        provider = "FileName",
        condition = buffer_not_empty,
        separator = " "
    }
}

EOS

" colorscheme
highlight LineNr guibg=#1d2021
highlight SignColumn guibg=#1d2021

" coc.nvim
highlight CocErrorSign guifg=#EA6962
highlight CocWarningSign guifg=#FFC745
highlight CocInfoSign guifg=#7DAEA3

" floaterm
highlight FloatermBorder guibg=#1d2021

" bufferline
highlight BufferLineFill guibg=NONE

" nvim-tree
highlight NvimTreeFileDirty guifg=#EA6962
highlight NvimTreeGitDirty guifg=#EA6962
highlight NvimTreeRootFolder guifg=#7DAEA3

