"###############################################
"#                                             #
"#              ~/.vimrc                       #
"#           VIM config file                   #
"#                                             #
"###############################################
" vimconf is not vi-compatible
set nocompatible
" Automatically make needed files and folders on first run
call system("mkdir -p $HOME/.vim/{swap,undo}")
""" Vundle plugin manager {{{
    " -----------------------------------------------------------------------------
    " Brief help
    " :PluginList           - lists configured plugins
    " :PluginInstall        - installs plugins
    " :PluginUpdate         - Update Plugins
    " :PluginSearch foo     - searches for foo; append `!` to refresh local cache
    " :PluginClean          - confirms removal of unused plugins
    "
    " see :h vundle for more details or wiki for FAQ
    " -----------------------------------------------------------------------------
    """ Auto installing Vundle {{{
    """ taken from http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
          echo "Installing Vundle..."
          echo ""
          silent !mkdir -p $HOME/.vim/bundle
          silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
          let has_vundle=0
        endif
    """ }}}
    """ Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    """ }}}
    """ Install plugins from GitHub {{{
        " Vundle
        Plugin 'gmarik/Vundle.vim'
        Plugin 'chrisbra/SudoEdit.vim'          " Edit files using sudo/su
        Plugin 'nanotech/jellybeans.vim'        " Glorious colorscheme
        Plugin 'scrooloose/nerdcommenter'       " Super easy commenting, toggle comments etc
        Plugin 'PotatoesMaster/i3-vim-syntax'   " i3 syntax highlighting
        Plugin 'smancill/conky-syntax.vim'
        Plugin 'scrooloose/nerdtree'            " NERD Tree
        Plugin 'bling/vim-airline'              " Vim-airline statusbar
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'vim-scripts/ruscmd'             " RusMod
        Plugin 'ervandew/supertab'              " Autocomplete by <TAB>
        Plugin 'tpope/vim-fugitive'             " Git wrapper inside Vim
        Plugin 'airblade/vim-gitgutter'         " Displays the changes for a commits
        Plugin 'kien/ctrlp.vim'                 " Full path fuzzy file finder for Vim.
        Plugin 'mhinz/vim-startify'             " Start screen for Vim
        Plugin 'godlygeek/tabular'
        Plugin 'plasticboy/vim-markdown'        " Markdown highlighting.
        Plugin 'tpope/vim-surround'             " Text surrounding

        Plugin 'MarcWeber/vim-addon-mw-utils'   " Need for Snippets
        Plugin 'tomtom/tlib_vim'                " Need for Snippets
        Plugin 'garbas/vim-snipmate'            " Need for Snippets
        Plugin 'honza/vim-snippets'             " Snippets
    """ }}}
    " Finish Vundle stuff
    call vundle#end()
    """ Installing plugins the first time, quits when done  {{{
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    """ }}}
""" }}}
""" User's setting {{{
    set mouse=a                                 " enable mouse for scolling and resizing
    syntax on                                   " syntax highlighting
    colorscheme jellybeans                      " colorscheme from plugin
    set cursorline                              " hilight cursor line
    filetype plugin on                          " need for 'nerdcommenter'
    set number                                  " line numbers
    set scrolloff=3                             " lines above/below cursor
    set wildmenu                                " improved auto complete
    set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
                \*.jpeg,*.png,*.gif,*.pdf,*.git,
                \*.gif,*.jpg,*.JPG,*.xcf,*.JPEG,
                \*.tgz,*.zip,*.rar,
                \*.swp,*.swo                    " tab completion ignores
    set hlsearch                                " highlight search
    """ <Tab> settings {{{
        " http://habrahabr.ru/post/64224/
        " https://github.com/timss/vimconf/blob/master/.vimrc
        set expandtab           " replace tab characters with spaces
        set tabstop=4           " replace <TAB> w/4 spaces
        set shiftwidth=4        " default 8
        set smarttab            " the behavior tab in the beginning of the line
        set softtabstop=4       " "tab" feels like <tab>
    """ }}}
    """ Force behavior and filetypes, and by extension highlighting {{{
        augroup FileTypeRules
            autocmd!
            autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
            autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
            autocmd BufNewFile,BufRead *.lua set ft=lua tw=79
            autocmd BufNewFile,BufRead *.txt set ft=sh tw=0
            autocmd BufNewFile,BufRead *.sh set ft=sh tw=79
            autocmd BufNewFile,BufRead *.cpp set tw=79
            autocmd BufNewFile,BufRead *.c set tw=79
            autocmd BufNewFile,BufRead *.py set tw=79
        augroup END
    """ }}}
    """ Folding {{{
      set foldignore=					" don't ignore anything when folding
      set foldlevelstart=99				" no folds closed on open
      set foldmethod=marker				" collapse code using markers
      set foldnestmax=1					" limit max folds for indent and syntax methods
    " Folding rules
      autocmd FileType c,cpp,java,prg setlocal foldmethod=syntax foldnestmax=5
      autocmd FileType css,html,htmldjango,xhtml,xml
  	\ setlocal foldmethod=indent foldnestmax=20
      autocmd FileType markdown setlocal foldmethod=marker
    """ }}}
    """ Custom highlighting, where NONE uses terminal background {{{
        function! CustomHighlighting()
            highlight Normal ctermbg=NONE
            highlight NonText ctermbg=NONE
            highlight LineNr ctermbg=NONE
            highlight SignColumn ctermbg=NONE
            highlight SignColumn guibg=#151515
            highlight CursorLine ctermbg=237
        endfunction

        call CustomHighlighting()
    """ }}}
    """ Gvim {{{
        if has("gui_running")
            set guifont=Iosevka\ Custom\ 12
            " set guifont=Iosevka\ 12
            set guioptions-=m       " remove menubar
            set guioptions-=T       " remove toolbar
            set guioptions-=r       " remove right scrollbar
            set guioptions-=R       " remove right scrollbar
            set guioptions-=l       " remove left scrollbar
            set guioptions-=L       " remove left scrollbar
            set guioptions-=b       " remove bottom (horizontal) scrollbar
        endif
    """ }}}
    """ Highlight unwanted spaces {{{
        highlight ExtraWhitespace ctermbg=red guibg=red
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * redraw!
    """ }}}
""" }}}
""" Plugins settings {{{
    """ Settings for Vim-Airline {{{
        set laststatus=2
        " let g:airline_theme='angr'
        let g:airline_theme='angr'
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
    """ }}}
    """ Settings for NERDTree {{{
        let NERDTreeShowLineNumbers=0
        let NERDTreeShowHidden=1
        let g:Tlist_Show_One_File = 1
        let NERDTreeQuitOnOpen=1
        let NERDTreeIgnore = [
                    \'\.DS_Store$',
                    \'\.bundle$','\.git$'
                    \]
        let NERDTreeShowBookmarks=1
        let NERDTreeBookmarksFile=expand("$HOME/.vim/.NERDTreeBookmarks")
        let g:NERDTreeWinSize=35
        let NERDTreeChDirMode=2
    """ }}}
    """ Settings for NERDCommenter {{{
        " Number of spaces after comment character (s)
        let g:NERDSpaceDelims = 1
    """ }}}
    """ Settings for CtrlP {{{
        let g:ctrlp_by_filename = 1
        let g:ctrlp_working_path_mode = 'wr'
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|tmp)$',
            \ }
        " Don't split in Startify
        let g:ctrlp_reuse_window = 'startify'
    """ }}}
    """ Settings for Snippets{{{
        " assuming you want to use snipmate snippet engine
        "ActivateAddons vim-snippets snipmate
    """ }}}
""" }}}
""" Keybindings {{{
    " Remap <leader>
    let mapleader=","
    " Quickly edit/source .vimrc
    noremap <leader>ve :edit $HOME/.vimrc<CR>
    noremap <leader>vs :source $HOME/.vimrc<CR>
    " Yank(copy) to system clipboard
    noremap <leader>y "+y
    " Paste from clipboard
    noremap <leader>p "+p
    " Treat wrapped lines as normal lines
    nnoremap j gj
    nnoremap k gk
    " Open/close NERDTree window
    noremap <F4> :NERDTreeToggle<CR>
    " Open markdown files with Chrome.
    " autocmd BufEnter *.md exe 'noremap <F5> :!start C:\Program Files (x86)\Google\Chrome\Application\chrome.exe %:p<CR>'
    " Buffers, preferred over tabs now with bufferline.
    nnoremap gn :bnext<CR>
    nnoremap gN :bprevious<CR>
    nnoremap gd :bdelete<CR>
    nnoremap gb :buffer
    " previous open buffer
    nnoremap gf <C-^>
    " Press F8 to toggle highlighting on/off, and show current value.
    noremap <F8> :set hlsearch! hlsearch?<CR>
    " Figitive keybinding
    noremap <leader>ga :Gwrite<CR>
    noremap <leader>gs :Gstatus<CR>
    noremap <leader>gp :Gpush<CR>
    noremap <leader>gc :Gcommit<CR>
    " Toggle folding
    nnoremap <space> za
    " Open help
    noremap <F1> :vert help
"" }}}

    " colors lena
    " SOURCE $HOME/dotfiles/vim/statusline.vim
