"-------------------------------------------------------------------------------
" vim-plug

call plug#begin()
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
Plug 'lambdalisue/fern-hijack.vim'
let g:fern_disable_startup_warnings = 1
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

" indent for yaml
Plug 'chase/vim-ansible-yaml'

" 行コメント
" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" THEME (Color scheme)"
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Mofiqul/dracula.nvim' "for nvim

" Wakatime "
Plug 'wakatime/vim-wakatime'

" SKK
Plug 'tyru/eskk.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 自動補完
Plug 'sheerun/vim-polyglot'
" Plug 'ervandew/supertab'

" Scroll
Plug 'yuttie/comfortable-motion.vim'

" Discord Presence
if has("mac") || has("linux")
    Plug 'andweeb/presence.nvim'
endif

"markdown preview
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

" intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" Initialize plugin system
call plug#end()

"-〠_〠 ------------------------------------------------------------------------------
" airline

let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
	\ 'n'  : '¯\_(ツ)_/¯',
	\ 'i'  : 'ʕ•ᴥ•ʔ',
	\ 'R'  : 'Replace',
	\ 'c'  : 'Command',
	\ 'v'  : 'ʕʘ‿ʘʔ',
	\ 'V'  : '〠_〠',
	\ '⌃V' : 'V-Block',
	\ }

"-------------------------------------------------------------------------------
"▼慣性スクロール
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
"
" SuperTab
let g:SuperTabDefaultCompletionType = "context"
"-------------------------------------------------------------------------------
" SKK config

let g:eskk#directory = "~/.config/skk"
let g:eskk#large_dictionary = {'path': "~/.config/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}
let g:eskk#directory = "~/.config/skk"

let g:eskk#keep_state = 0                    "ノーマルモードに戻るとeskkモードを初期値にする
let g:eskk#egg_like_newline = 1              "漢字変換を確定しても改行しない。

"-------------------------------------------------------------------------------
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
"Fern

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#default_hidden=1

autocmd FileType javascript nested Fern . -reveal=% -drawer

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
set mouse=a
set list
set listchars=eol:¬,tab:>-,extends:>,precedes:<,space:.

" ----------------
" cursor
let &t_ti .= "\e[1 q"
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"
let &t_te .= "\e[0 q"

" WSL yank
augroup Yank
  au!
  autocmd TextYankPost * :call system('clip.exe', @")
augroup END

" UNIX yank
set clipboard=unnamed

"------------------------------------------------
" Discord Rich Presence
" General options
if has("mac") || has("linux")
    let g:presence_auto_update         = 1
    let g:presence_neovim_image_text   = "nvim"
    let g:presence_main_image          = "neovim"
    let g:presence_client_id           = "1086316041879162901"
    let g:presence_debounce_timeout    = 10
    let g:presence_enable_line_number  = 0
    let g:presence_blacklist           = []
    let g:presence_buttons             = 0
    let g:presence_file_assets         = {}
    let g:presence_show_time           = 1

    " Rich Presence text options
    let g:presence_editing_text        = "Editing"
    let g:presence_file_explorer_text  = "Browsing"
    let g:presence_git_commit_text     = "Committing changes"
    let g:presence_plugin_manager_text = "Managing plugins"
    let g:presence_reading_text        = "Reading"
    let g:presence_workspace_text      = "Working"
    let g:presence_line_number_text    = "Line %s out of %s"
endif

" テキスト背景色
au ColorScheme * hi Normal ctermbg=none
" 括弧対応
au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
" スペルチェック
au Colorscheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none

set background=dark


