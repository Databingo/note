"for run plugins
""""""""""""""""""
"execute pathogen#infect()
syntax on " 开启语法高亮
filetype plugin indent on

" vim-easymotion plugin config
""""""""""""""""""
" let mapleader = \";" "easymotion map \ to ; for ;; into model
"map ww <Plug>(easymotion-w)
"map bb <Plug>(easymotion-b)

" accelerated-jk plugin config
""""""""""""""""""
"nmap j <Plug>(accelerated_jk_gj)
"nmap k <Plug>(accelerated_jk_gk)
"let g:accelerated_jk_acceleration_limit = 80
"let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

" 行号
"set nu
"set rnu "relativenumber

" 中文显示
set encoding=utf-8 " vim 内部字符编码
set termencoding=utf-8 " 屏幕显示编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,gb2312, " 读取文件解码时候探测顺序,先严后松

" 设置注释颜色
hi Comment ctermfg=6;

" 高亮当前行 set cursorcolumn 列: Magenta LightBlue 
"set cursorline
"hi Cursorline  cterm=NONE  guibg=#323232 ctermbg=Grey ctermbg=DarkGray
"hi Cursorline  cterm=NONE ctermbg=DarkBlue
" hi Cursorline ctermbg=Grey cterm=NONE

" 加速cursorlone
set lazyredraw
set ttyfast

" > 缩进4格
set shiftwidth=4

" 启用 256 位颜色
" set t_Co=256 

" 采用配色 seou1256
" colorscheme seou1256

" 向下打开新空间
" set splitbelow

" 默认在新空间打开目录
"augroup ProjectDrawer
"    autocmd!
""   autocmd VimEnter * :Vexplore
"    autocmd VimEnter * :Sexplore
"    autocmd VimEnter * :wincmd p
"augroup END
"
"" 配置文件目录
"  let g:netrw_banner=0 " 隐藏文件目录工具提示
"  let g:netrw_liststyle=1 "一行显示一个文件
"  let g:netrw_browse_split=4 "覆盖显示
"  let g:netrw_winsize=18 "目录占屏幕百分比
"" let g:netrw_list_hide='*\.swp$' "隐藏 .swp 文件

" 设置快捷键在上下 split 之间切换
map <C-j> <c-W>j
map <C-k> <c-W>k
map <C-h> <c-W>h
map <C-l> <c-W>l
   
" search
" set hlsearch "高亮搜索
set nohlsearch "取消高亮搜索
" set ignorecase

" fold  折叠
" set foldmethod=indent
" set foldlevelstart=0

" 无临时备份文件
set noswapfile
set nobackup

" fix vim-go warning
let g:go_version_warning = 0
let g:go_fmt_options =''

" English dictionary '"pronuncation and check"
" nmap <leader>w :<C-u>call system('say ' . expand('<cword>')) \| call SearchWord() \| wincmd l<CR>
" nmap <leader>w :call SearchWord() \| wincmd l<CR>
" nmap <leader>e :wincmd l<CR> 
" nmap <leader>s :<C-u>call system('say ' . expand('<cword>'))<CR> 

"run alias within vim 
set shellcmdflag=-ic 

let g:opengoogletranslate#openbrowsercmd= 'electron-open --without-focus'
let g:opengoogletranslate#default_lang='zh-CN'

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign) 
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" diable syntax highlight for md
autocmd BufRead, BufNewFile {*.md, *.mdown} set filetype=markdown
autocmd FileType markdown setlocal syntax=off

let g:gist_post_private=1

"set cursorcolumn
"hi CursorColumn guifg=NONE ctermfg=NONE guibg=#323232 ctermbg=236 gui=NONE cterm=NONE
"hi CursorColumn guifg=NONE ctermfg=white guibg=#323232 ctermbg=DarkGray gui=NONE cterm=NONE

"for mac read: v then \v
:vnoremap <leader>v :w<Home>silent <End> !say <CR>

" share clip content between progresses such like tmux vim instances
set clipboard=unnamed

"spell checking build in
"set spell!

" set K check dictionary
set keywordprg=:Sdcv
" English dictionary '"pronuncation"
nmap <leader>w :<C-u>call system('say ' . expand('<cword>')) <CR>

" use alias of bash in !
let $BASH_ENV = "~/.bashrc"

" remove color Error 
hi Error NONE
hi ErrorMsg NONE

let &t_SI = "\e[5 q" " set insert mode cursor to be a blinking vertical thin line
let &t_EI = "\e[2 q" " set else mode cursor to be a steady block

" compile latex & preview pdf
"map L :! xelatex %<CR><CR>
"map S :! open -a Preview $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
":command Latex :! xelatex % ; open -a Preview $(echo '%:p' | sed 's/tex$/pdf/') & disown<CR><CR>

" esay :
nnoremap ; :
vnoremap ; :

" paste yank after delete
nmap ,p "0p
nmap ,P "0P

" easy surround, <leader> is \
nmap <leader>' ysiw'
nmap <leader>" ysiw"

" show my namp
":nmap
":vmap







