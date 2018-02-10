""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'handy1989/latest-taglist' " 最新版
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/EasyGrep'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mileszs/ack.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'bronson/vim-visual-star-search'
Plugin 'nelstrom/vim-qargs' " 将quickfix文件列表加入args, 快捷键:Qargs
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-scripts/ZoomWin' " 最大化当前窗口<C-w>o, 再按一次恢复原来窗口
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tomasr/molokai'
"Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'dgryski/vim-godef'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'davidhalter/jedi-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" base config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on " 语法高亮
"set autochdir " 自动改变vim的当前目录为打开的文件所在目录"
set nocp " 关闭兼容模式
set fileencodings=utf-8,gbk
set foldmethod=indent
set foldlevelstart=99
set shiftwidth=4 " 缩进4个空格
set tabstop=4
set expandtab " Tab键展开为4个空格，插入Tab键<ctl-v>tab
set softtabstop=4 " 每次退格删除4个空格
set autoindent
set cindent
set hls
set backspace=indent,eol,start
"set mouse=a " 激活鼠标
set number " 显示行号
set wildmode=longest,list " Ex命令自动补全采用bash方式
set incsearch " 在执行查找前预览第一处匹配

nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" 打开关闭quifkfix
function! ToggleQuickFix()
  if exists("g:qwindow")
    ccl
    unlet g:qwindow
  else
    try
      cw 10
      let g:qwindow = 1
    catch 
      echo "No Errors found!"
    endtry
  endif
endfunction
nmap <script> <C-q> :call ToggleQuickFix()<CR>

" 设置窗口预览参数，详见:help completeopt
"set completeopt=longest,menu,preview
set completeopt=longest,menu

" 设置预览窗口位置
augroup PreviewOnBottom
    autocmd InsertEnter * set splitbelow
    autocmd InsertLeave * set splitbelow!
augroup END

" 跳转到文件上次退出的光标所在处
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 快捷键
" 键盘映射
" 调整窗口大小
" for example: vertival resize +10 
let mapleader = ","
noremap <C-v>s :vertical resize 
noremap <C-s> :resize
nnoremap <leader>n :set number!<CR>
noremap <C-n> :NERDTreeTabsToggle<CR>
noremap <leader>p :set paste!<CR>:set paste?<CR>
noremap <silent> <F9> <ESC>:noh<CR>
nnoremap <silent> <leader>a :A<cr>
nnoremap <leader>vs :vertival resize 
nnoremap <leader>h :set hls!<cr>
"nnoremap <silent> <leader>T :silent exec "!(ctags.sh . &) >/dev/null"<cr>
nnoremap <silent> <leader>T :!ctags.sh . &<cr>
nnoremap * :set hls<cr>*
nnoremap # :set hls<cr>#
nnoremap <leader><leader>c :tabc<cr>
nnoremap <leader><leader>n :tabnew<cr>
nnoremap <leader><leader>r :so ~/.vimrc<cr>
nnoremap <C-LeftMouse> :tjump<cr>

" 高亮光标所在单词开关
function! HighlightCursorWordToggle()
    set hls
    let current_word = '\<'.expand('<cword>').'\>'
    if @/ == current_word
        let @/=''
    else
        let @/=current_word
    endif
endfunction
nnoremap <silent> <F8> :call HighlightCursorWordToggle()<cr>

"let g:molokai_original = 1
set background=dark
colorscheme solarized
" diff模式设置不同colors，防止对比色彩看不清
"if &diff  
"    colors torte
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" youcompleteme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = "$HOME/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项"
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = '<C-/>'
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <C-\> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
" <F5>清除缓存目录列表
"let g:ctrlp_root_markers = ['.'] " 设置根目录，如果为设置，默认为上层最近的.git .hg .svn .bzr所在的目录
"  c - the directory of the current file.
"  a - like "c", but only applies when the current working directory outside of
"      CtrlP isn't a direct ancestor of the directory of the current file.
"  r - the nearest ancestor that contains one of these directories or files:
"      .git .hg .svn .bzr _darcs
"  w - begin finding a root from the current working directory outside of CtrlP
"      instead of from the directory of the current file (default). Only applies
"      when "r" is also present.
let g:ctrlp_working_path_mode = "w"
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:40'
  "\ 'dir':  '\v([\/]\.(git|hg|svn))|CMakeFiles$',
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v([\/]\.(git|hg|svn))|CMakeFiles$',
  \ 'file': '\v\.(exe|so|dll|o|d|tar|gz)$',
  \ }
"let g:ctrlp_user_command = 'find %s -type f' "添加这样代码后g:ctrlp_custom_ignore不生效
let g:ctrlp_user_command = 'find -L %s -type f  -not -path "*/.*" -not -path "*/.*" -not -path "*CMakeFiles*" | grep -Ev "\.(exe|so|dll|o|d|tar|gz)$"'
" 查找剪贴板文件
function! FindUnderCursor(type)
    try
        let default_input_save = get(g:, 'ctrlp_default_input', '')
        let g:ctrlp_default_input = expand('<cword>')
        if a:type == "file"
            CtrlP
        elseif a:type == "tag"
            CtrlPTag
        endif
    finally
        if exists('default_input_save')
            let g:ctrlp_default_input = default_input_save
        endif
    endtry
endfu
nnoremap <leader>f :call FindUnderCursor("file")<cr>
"nnoremap <leader>t :call FindUnderCursor("tag")<cr>
" 搜索当前文件的tag，需要实现建立tags文件
"nnoremap <leader>@ :CtrlPBufTag<cr>
"nnoremap <leader>t :CtrlPTag<cr>

" 遍历窗口，找到名字不为NERD_tree的窗口，并在该窗口执行ctrlp
" 若窗口都为NERD_tree，则在靠右的窗口打开ctrlp
function! CtrlPCommand(cmd)
    let c = 0
    let wincount = winnr('$')
    while (expand("%") == "" || match(expand("%"), "NERD") >= 0) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    if c == wincount
        exec 'wincmd l'
    endif
    "exec 'CtrlP'
    exec a:cmd
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand("CtrlP")'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>z :FZF<cr>
nnoremap <leader>z :call CtrlPCommand("FZF")<cr>
nnoremap <leader>@ :call CtrlPCommand("BTags")<cr>
nnoremap <leader>t :call CtrlPCommand("Tags")<cr>
nnoremap <leader>B :call CtrlPCommand("Buffers")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeTabsToggle<CR>
"过滤文件
let NERDTreeIgnore=['\.o$', '\~$', '\.d$', '\.tar$', '\.gz$', '^core\.', '\.pyc$', '_debug_build$'] 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name" " 按名字排序 order: 按tag出现顺序排序
let Tlist_Auto_Highlight_Tag=1
nmap <C-t> :TlistToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyGrep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" *EasyGrepMode*  [default=0]
" Specifies the mode in which to start.
" 0 - All files
" 1 - Open Buffers
" 2 - Track the current extension
" 3 - User mode -- Use a custom, on demand set of extensions
let EasyGrepMode=0
"let EasyGrepDefaultUserPattern="*.h *.cc *.cpp *.c *.hpp *.hxx"
let EasyGrepCommand=1
let EasyGrepJumpToMatch=0
let EasyGrepSearchCurrentBufferDir=0
let EasyGrepExtraWarnings=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='name'        " Sort by name.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitBelow=1        " Split new window below current.
let g:bufExplorerHorzSize=20          " New split window is n rows high.
autocmd BufWinEnter \[Buf\ List\] setl nonumber


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ack.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SearchProj(type)
    let search_pattern = expand('<cword>')
    let cur_file = expand('%')
    if a:type == "file"
        if cur_file =~ "\.go$"
            exec 'Ack! -w --go '.search_pattern.' '.cur_file
        elseif cur_file =~ "\.h$" || cur_file =~ "\.cpp$" || cur_file =~ "\.c$"
            exec 'Ack! -w --cpp --cc '.search_pattern.' '.cur_file
        else
            exec 'Ack! -w '.search_pattern.' '.cur_file
        endif
    elseif a:type == "dir"
        if cur_file =~ "\.go$"
            exec 'Ack! -w --go '.search_pattern
        elseif cur_file =~ "\.h$" || cur_file =~ "\.cpp$" || cur_file =~ "\.c$"
            exec 'Ack! -w --cpp --cc '.search_pattern
        else
            exec 'Ack! -w '.search_pattern
        endif
    endif
endfun()

set grepprg=ack\ -s\ -H\ --nocolor\ --nogroup\ --column\ $*
let g:ack_default_options=" -s -H --nocolor --nogroup --column --follow"
"nnoremap <F12> :Ack! -w --cpp --cc <C-R>=expand("<cword>")<CR><CR>
"nnoremap <F11> :Ack! -w --cpp --cc <C-R><C-W> <C-R>%<CR>
nnoremap <F12> :call SearchProj("dir")<cr>
nnoremap <F11> :call SearchProj("file")<cr>
nnoremap <leader>/ :Ack! -w --cpp --cc 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 行级跳转
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><leader>l <Plug>(easymotion-lineforward)
nmap <leader><leader>s <Plug>(easymotion-s2)
nmap <leader><leader>t <Plug>(easymotion-t2)
map  <leader><leader>/ <Plug>(easymotion-sn)
omap <leader><leader>/ <Plug>(easymotion-tn)

"nnoremap <F6> :cd ../../build<bar>:make -j 24<bar>:cd -<cr>
"nnoremap <F7> :cd ../../build<bar>:make install<bar>:cd -<cr>

function! BuildCmakeProj(cmd)
    if getfsize("CMakeLists.txt") <= 0
        echo "CMakeListsx.txt not found in working directory!"
        return 
    endif
    if a:cmd == "build"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j 16
        cd -
    elseif a:cmd == "install"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j 16
        make install
        cd -
    elseif a:cmd == "clean"
        cd build
        make clean
        cd -
    elseif a:cmd == "rebuild"
        call system("rm -rf build")
        call mkdir("build")
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j 16
        cd -
    endif
endfu

au FileType cpp,cmake nnoremap <F6> :call BuildCmakeProj("build")<cr>
au FileType cpp,cmake nnoremap <F7> :call BuildCmakeProj("install")<cr>
au FileType cpp,cmake nnoremap <F9> :call BuildCmakeProj("clean")<cr>
au FileType cpp,cmake nnoremap <F10> :call BuildCmakeProj("rebuild")<cr>

" go
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
let g:godef_split=0

" vim-go custom mappings
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)

" vim-go settings
let g:go_fmt_command = "goimports"

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
        echo "mouse off"
    else
        " enable mouse everywhere
        set mouse=a
        echo "mouse on"
    endif
endfunc
nnoremap <leader>m :call ToggleMouse()<cr>

au FileType python nmap <leader>r :!python %<cr>

" ctrlsf
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_ackprg = 'ack'
let g:ackprg='ack -s -H --nocolor --nogroup --column --cc --cpp'
"let g:ctrlsf_debug_mode = 1
let g:ctrlsf_extra_backend_args = {
    \ 'ack': '--cc --cpp'
    \ }
"nmap <C-F> <Plug>CtrlSFPrompt

" toggle quickfix
function! ToggleQuickFix()
    let nr = winnr("$")
    cwindow
    let nr2 = winnr("$")
    if nr == nr2
        cclose
    endif
endfunc
nnoremap <leader>q :call ToggleQuickFix()<cr>
