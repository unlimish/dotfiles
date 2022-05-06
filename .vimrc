"-------------------------------------------------------------------------------
" vim-plug

call plug#begin('~/.config/nvim/plug')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes


" ファイルをtree表示
Plug 'lambdalisue/fern.vim'

" indent for yaml
Plug 'chase/vim-ansible-yaml'

" 行コメント
" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" THEME (Color scheme)"
Plug 'dracula/vim', { 'as': 'dracula' }

" Wakatime "
Plug 'wakatime/vim-wakatime'

" SKK
Plug 'tyru/eskk.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

"-------------------------------------------------------------------------------
" airline

let g:airline_theme='violet'

"-------------------------------------------------------------------------------
" SKK config

let g:eskk#directory = "~/.config/skk"
let g:eskk#large_dictionary = {'path': "~/.config/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}
let g:eskk#directory = "~/.config/skk"

let g:eskk#keep_state = 0                    "ノーマルモードに戻るとeskkモードを初期値にする
let g:eskk#egg_like_newline = 1              "漢字変換を確定しても改行しない。

"-------------------------------------------------------------------------------
" 編集に関する設定:

" タブの画面上での幅
set tabstop=4
" 自動インデントでずれる幅
set shiftwidth=4
" タブの代わりに空白文字を指定する
set expandtab
" 新しい行のインデントを現在行と同じにする
set autoindent

"-------------------------------------------------------------------------------
" ファイル操作に関する設定:

" バックアップファイルの出力先ディレクトリを指定する
set backup
set backupdir=~/.vim/.backup
" スワップファイルの出力先ディレクトリを指定する
set swapfile
set directory=/tmp
" .viminfo(状態を復元するためファイル)の出力パス
" set viminfo+=n~/.vim/.viminfo
" UNDOファイルの出力先ディレクトリを指定する
set undofile
set undodir=~/.vim/.undo

"-------------------------------------------------------------------------------
" 表示に関する設定:

" 行番号の表示
se nu

" 全角スペースの表示:
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"-------------------------------------------------------------------------------
" その他設定:

" not ignore case.
se noic
" スペルチェック
set spell
set spelllang=en,cjk
" color
colorscheme dracula

"-------------------------------------------------------------------------------
" NERDTree:

" .ファイルの表示（1: 表示）
let NERDTreeShowHidden=1
" ブックマークを表示 (1:表示)
let g:NERDTreeShowBookmarks=1
" 引数なしで起動した場合、NERDTreeを開く
" autocmd vimenter * if !argc() | NERDTree | endif
" 表示・非表示切り替え
nmap <silent> <C-n><C-t>      :NERDTreeToggle<CR>

"-------------------------------------------------------------------------------
" map:

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
" 常にvery magicを利用
nnoremap / /\v
" タブ移動
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

"-------------------------------------------------------------------------------

set confirm
set whichwrap=h,l,b,s,<,>,[,]

" ----------------
" cursor
let &t_ti .= "\e[1 q"
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"
let &t_te .= "\e[0 q"
