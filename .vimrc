set nocompatible

" - - - - - - - - - - - - - - - - - - -
" vundle setup 
" - - - - - - - - - - - - - - - - - - -
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mileszs/ack.vim'
Bundle 'bronson/vim-visual-star-search'
"Bundle 'tpope/vim-surround'
Bundle 'groenewege/vim-less'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
Bundle 'kshenoy/vim-signature'
"Bundle 'marijnh/tern_for_vim'
Bundle 'tpope/vim-fugitive.git'
Bundle 'zfedoran/vim-gitgutter'
Bundle 'godlygeek/tabular'
Bundle 'digitaltoad/vim-jade'

"SuperTab + SnipMate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
"Bundle 'garbas/vim-snipmate'
"Bundle 'honza/vim-snippets'
"Bundle 'ervandew/supertab'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'

" colorschemes
Bundle 'Lokaltog/vim-distinguished'
Bundle 'zfedoran/vim-colors-solarized'
"Bundle 'flazz/vim-colorschemes'

" javascript bundles
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'nathanaelkane/vim-indent-guides'

Bundle 'Yggdroot/indentLine'

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles


filetype plugin indent on

" - - - - - - - - - - - - - - - - - - -
" color setup
" - - - - - - - - - - - - - - - - - - -
if !(has('win32') || has('win64'))
    if &term =~ "xterm"
        set t_Co=256
        if has("terminfo")
            let &t_Sf=nr2char(27).'[3%p1%dm'
            let &t_Sb=nr2char(27).'[4%p1%dm'
        else
            let &t_Sf=nr2char(27).'[3%dm'
            let &t_Sb=nr2char(27).'[4%dm'
        endif
    endif
endif

"colors monokai
"colors molokai
"colors distinguished

set background=dark
colorscheme solarized
" let g:solarized_termcolors=256

" - - - - - - - - - - - - - - - - - - -
" general setup
" - - - - - - - - - - - - - - - - - - -
syntax on
set history=1000
set undolevels=1000
set title
set nu
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cindent
set smartindent
set autoindent
set smartcase
set incsearch
set hlsearch
set nowrap
set backup
set backupdir=/private/tmp
set dir=/private/tmp
set autoread
set colorcolumn=80
set mouse=a
set clipboard=unnamed
set encoding=utf-8
set updatetime=1000 "default: 4000

" brew version of vim needs this
set bs=indent,eol,start

" indent line(s) using > or < in visual mode
vmap <TAB> >gv
vmap <S-TAB> <gv

" tab navigation, CTRL+l next tab, CTRL+h previous tab, CTRL+n new tab
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

" Map the keys jk to ESC
inoremap jk <ESC>

" Map the leader key to ','
let mapleader = ","

" Allow the . operator to function in visual mode
vnoremap . :norm.<CR>

" - - - - - - - - - - - - - - - - - - -
" YouCompleteMe setup
" - - - - - - - - - - - - - - - - - - -
let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<s-tab>', '<Up>']
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" - - - - - - - - - - - - - - - - - - -
" UltiSnips setup
" - - - - - - - - - - - - - - - - - - -
let g:UltiSnipsExpandTrigger       ="<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsSnippetDirectories  = ["snips"]

" Enable tabbing through list of results
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

" - - - - - - - - - - - - - - - - - - -
" nerdtree setup
" - - - - - - - - - - - - - - - - - - -

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd vimenter * if !argc() | NERDTree | endif

" open NERDTree
nnoremap <F6> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" - - - - - - - - - - - - - - - - - - -
" ctrl-p setup
" - - - - - - - - - - - - - - - - - - -

" force ctrlp to open new tabs by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v([\/](node_modules|lib|plato_report|tests|bin|dist)|[\/]\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|svg|jpg|jpeg|gif|png|zip|so|o)$'
  \ }

" - - - - - - - - - - - - - - - - - - -
" easymotion setup
" - - - - - - - - - - - - - - - - - - -

" disable EasyMotion shading
let g:EasyMotion_do_shade = 0

" typying \\ is too much work, may have to change this back if other plugins conflict
let g:EasyMotion_leader_key = '<Leader>'

" - - - - - - - - - - - - - - - - - - -
" tabular setup
" - - - - - - - - - - - - - - - - - - -
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>

" - - - - - - - - - - - - - - - - - - -
" supertab setup
" - - - - - - - - - - - - - - - - - - -
let g:SuperTabDefaultCompletionType = "<c-n>"

" - - - - - - - - - - - - - - - - - - -
" indentline setup
" - - - - - - - - - - - - - - - - - - -
let g:indentLine_color_term = 237
let g:indentLine_char = '◇'
let g:indentLine_faster = 1

" - - - - - - - - - - - - - - - - - - -
" gitgutter setup
" - - - - - - - - - - - - - - - - - - -
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1

" - - - - - - - - - - - - - - - - - - -
" powerline setup
" - - - - - - - - - - - - - - - - - - -

" grab the fancy font using this:
" cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git && cd ~
"let g:Powerline_symbols = 'fancy'

" https://github.com/bling/vim-airline/wiki/FAQ#vim-airline-doesnt-appear-until-i-create-a-new-split
set laststatus=2
"let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'

" vim-powerline symbols
let g:airline_powerline_fonts = 1

" - - - - - - - - - - - - - - - - - - -
" glsl file support
" - - - - - - - - - - - - - - - - - - -
au BufNewFile,BufRead *.glsl set syntax=c

" - - - - - - - - - - - - - - - - - - -
" css & less file support
" - - - - - - - - - - - - - - - - - - -
"au BufEnter *.css set nocindent
"au BufLeave *.css set cindent
"au BufEnter *.less set nocindent
"au BufLeave *.less set cindent

"au BufNewFile,BufRead *.less set syntax=css

" - - - - - - - - - - - - - - - - - - -
" disable the arrow keys
" - - - - - - - - - - - - - - - - - - -
"nnoremap <Left> :noh<CR>
"nnoremap <Right> :noh<CR>
"nnoremap <Up> :noh<CR>
"nnoremap <Down> :noh<CR>

" - - - - - - - - - - - - - - - - - - -
" use the same symbols as textmate for tabstops and eols
" - - - - - - - - - - - - - - - - - - -
set list
set listchars=tab:▸\ ,eol:¬
"set lcs=tab:>-,trail:-,space:.,extends:>,precedes:<
"set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&,eol:¬

" - - - - - - - - - - - - - - - - - - -
" make * and # work on visual mode
" - - - - - - - - - - - - - - - - - - -
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" - - - - - - - - - - - - - - - - - - -
" move lines of text
" - - - - - - - - - - - - - - - - - - -
"nnoremap <C-j> mz:m+<cr>`z
"nnoremap <C-k> mz:m-2<cr>`z
"vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
"vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" - - - - - - - - - - - - - - - - - - -
" search and replace in current document
" - - - - - - - - - - - - - - - - - - -

" EscapeRegex will escape strings that are to be searched
" against within a regex, preventing characters with special
" meaning from interfering with the search
fun! EscapeRegex(sub)
    let l:sub = substitute(a:sub,"\\.","\\\\.",'g')
    let l:sub = substitute(l:sub,"\[","\\\\[",'g')
    let l:sub = substitute(l:sub,"\n","\\n",'g')
    let l:sub = substitute(l:sub,"\/","\\\\/",'g')
    let l:sub = substitute(l:sub,"\*","\\\\*",'g')
    return l:sub
endfun

" string substitution for currently visually selected text
vmap <leader>r "sy:%s/<C-R>=EscapeRegex(@s)<CR>/

" - - - - - - - - - - - - - - - - - - -
" search recusively for visually selected text
" - - - - - - - - - - - - - - - - - - -
vnoremap <leader>s y :call GrepSearch("v",@")<cr>

" recursively vimgrep for word under cursor or selection if you hit leader-star
"nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
"vmap <leader>* :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

fun! GrepSearch(mode,sub)

    " specify which directories to exclude from searches
    let l:excludeDirs = 'node_modules .git .svn dist test'

    " escape any regex chars with special meaning
    let l:subject = EscapeRegex(a:sub)

    " if the search was done with the cursor over a word
    " which in normal mode, we want to set word boundaries
    " on either side of the word
    let l:wrapper = l:subject
    if a:mode == 'n'
        let l:wrapper = '\b' . l:subject . '\b'
    endif

    " format excluded directories list for grep command
    let l:excludeDirs = substitute(l:excludeDirs,' ',',','g')

    " prepare grep command
    let l:grepCmd = 'grep -Rn --exclude-dir={'.l:excludeDirs.'} '.shellescape(l:wrapper).' .'

    " set error/quickfix format (corresponds to output from grep command)
    setlocal errorformat=%f:%l:%m

    " populate quickfix list with output from grep command but don't jump to first error/item
    cgetexpr system(l:grepCmd)

    " open quick fix list
    copen

endfun

" - - - - - - - - - - - - - - - - - - -
" pretty print minified JS
" - - - - - - - - - - - - - - - - - - -
map <leader>= :%!js-beautify -j -q -B -f -<CR>

" - - - - - - - - - - - - - - - - - - -
" setup syntastic
" - - - - - - - - - - - - - - - - - - -
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_check_on_open=1
let g:syntastic_quiet_warnings=0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }


" - - - - - - - - - - - - - - - - - - -
" generate doc comment template
" - - - - - - - - - - - - - - - - - - -
map <leader>/ :call GenerateDOCComment()<cr>

function! GenerateDOCComment()
    let l:jsDocregex = '\s*\([a-zA-Z]*\)\s*[:=]\s*function\s*(\s*\(.*\)\s*).*'
    let l:jsDocregex2 = '\s*function \([a-zA-Z]*\)\s*(\s*\(.*\)\s*).*'
 
    let l:line = getline('.')
    let l:indent = indent('.')
    let l:space = repeat(" ", l:indent)
 
    if l:line =~ l:jsDocregex
        let l:flag = 1
        let l:regex = l:jsDocregex
    elseif l:line =~ l:jsDocregex2
        let l:flag = 1
        let l:regex = l:jsDocregex2
    else
        let l:flag = 0
    endif
 
    let l:lines = []
    let l:desc = input('Description :')
    call add(l:lines, l:space. '/**')
    call add(l:lines, l:space . '* ' . l:desc)
    if l:flag
        let l:funcName = substitute(l:line, l:regex, '\1', "g")
        let l:arg = substitute(l:line, l:regex, '\2', "g")
        let l:args = split(l:arg, '\s*,\s*')
        for l:arg in l:args
            call add(l:lines, l:space . '* @param {Object} ' . l:arg)
        endfor
        call add(l:lines, l:space . '* @returns {undefined}')
        call add(l:lines, l:space . '* @memberOf')
        call add(l:lines, l:space . '* @example')
    endif
    call add(l:lines, l:space . '*/')
    call append(line('.')-1, l:lines)
endfunction
