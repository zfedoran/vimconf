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
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mileszs/ack.vim'
Bundle 'bronson/vim-visual-star-search'
Bundle 'tpope/vim-surround'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

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

let g:molokai_original = 1
colors monokai
"colors molokai
"colors inkpot

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
set nobackup
set noswapfile
set autoread
set colorcolumn=80
set mouse=a
set clipboard=unnamed

" brew version of vim needs this
set bs=indent,eol,start

" indent line(s) using > or < in visual mode
vmap <TAB> >gv
vmap <S-TAB> <gv

" tab navigation, CTRL+l next tab, CTRL+h previous tab, CTRL+n new tab
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

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
  \ 'dir':  '\v([\/](node_modules|lib)|[\/]\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|svg|jpg|jpeg|gif|png|zip|so|o|css)$'
  \ }

" - - - - - - - - - - - - - - - - - - -
" easymotion setup
" - - - - - - - - - - - - - - - - - - -

" disable EasyMotion shading
let g:EasyMotion_do_shade = 0

" typying \\ is too much work, may have to change this back if other plugins conflict
let g:EasyMotion_leader_key = '<Leader>'

" - - - - - - - - - - - - - - - - - - -
" powerline setup
" - - - - - - - - - - - - - - - - - - -

" grab the fancy font using this:
" cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git && cd ~
set laststatus=2
let g:Powerline_symbols = 'fancy'

" - - - - - - - - - - - - - - - - - - -
" css & less file support
" - - - - - - - - - - - - - - - - - - -
au BufEnter *.css set nocindent
au BufLeave *.css set cindent
au BufEnter *.less set nocindent
au BufLeave *.less set cindent

au BufNewFile,BufRead *.less set filetype=less

" - - - - - - - - - - - - - - - - - - -
" disable the arrow keys
" - - - - - - - - - - - - - - - - - - -
nnoremap <Left> :noh<CR>
nnoremap <Right> :noh<CR>
nnoremap <Up> :noh<CR>
nnoremap <Down> :noh<CR>

" - - - - - - - - - - - - - - - - - - -
" use the same symbols as textmate for tabstops and eols
" - - - - - - - - - - - - - - - - - - -
set list
set listchars=tab:▸\ ,eol:¬

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
nnoremap <C-j> mz:m+<cr>`z
nnoremap <C-k> mz:m-2<cr>`z
vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

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
    let l:excludeDirs = 'node_modules .git .svn'

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
nnoremap <leader>= :%!js-beautify -j -q -B -f -<CR>
