set nocompatible                "No vi support
set t_Co=256                    "256 terminal colors
syntax on                       "Turn on syntax
colorscheme molokai             "Molokai theme

set hidden                      "Allow having unsaved buffers
set autoindent                  "autoindent on
set copyindent                  "copy last line indentation
set showmatch                   "show matcing parenthesis
set nowrap                      "dont wrap lines
set backspace=indent,eol,start  "allow backspace in insert mode
set nobackup                    "Disable backup
set noswapfile                  "Disable Swap

"Tab specific option
set tabstop=4                   "A tab is 4 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs 

"Searching
set hlsearch                    "Highlight search
set smartcase                   "Ignore case is all lower case
set incsearch                   "Show search results as you type

"Whitespaces and Tabs display
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

"Vim ui
set pastetoggle=<F2>            "Paste mode disable autoinent
set autoread
set showcmd
set ruler
set number                      "Show line number
set laststatus=2
set scrolloff=3
set history=50
set equalalways
set mouse=a
