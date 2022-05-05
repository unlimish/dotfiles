
"-------------------------------------------------------------------------------
" NeoBundle:

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " My Bundles here:
  " Refer to |:NeoBundle-examples|.
  " Note: You don't set neobundle setting in .gvimrc !

  " vimgrepの結果から置換
  NeoBundle 'thinca/vim-qfreplace'

  " Unite
  """NeoBundle 'Shougo/unite.vim'
  " git
  """NeoBundle 'kmnk/vim-unite-giti'
  """NeoBundle 'tpope/vim-fugitive'

  " previm
  NeoBundle 'kannokanno/previm'
  NeoBundle 'tyru/open-browser.vim'

  " コード補完
  """NeoBundle 'Shougo/neocomplete.vim'

  " 静的解析
  NeoBundle 'scrooloose/syntastic'

  " ドキュメント参照
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'yuku-t/vim-ref-ri'

  " メソッド定義元へのジャンプ
  NeoBundle 'szw/vim-tags'

  " ブロックのendを自動で挿入
  NeoBundle 'tpope/vim-endwise'

  " ファイルをtree表示
  NeoBundle 'scrooloose/nerdtree'

  " indent for yaml
  NeoBundle 'chase/vim-ansible-yaml'

  " Railsプロジェクトのナビゲーション
  " https://github.com/tpope/vim-rails
  NeoBundle 'tpope/vim-rails'

  " 行コメント
  " https://github.com/tpope/vim-commentary
  NeoBundle 'tpope/vim-commentary'


  " THEME (Color scheme)"
  NeoBundle 'dracula/vim'
  
  " Wakatime "
  NeoBundle 'wakatime/vim-wakatime'


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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
" matchit.vim
runtime macros/matchit.vim
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
" Previm:

let g:previm_open_cmd = 'open -a FirefoxDeveloperEdition'

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"-------------------------------------------------------------------------------
" neocomplete.vim:

"""let g:acp_enableAtStartup = 0
"""let g:neocomplete#enable_at_startup = 1
"""let g:neocomplete#enable_smart_case = 1
"""if !exists('g:neocomplete#force_omni_input_patterns')
"""  let g:neocomplete#force_omni_input_patterns = {}
"""endif
"""let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"-------------------------------------------------------------------------------
" rubocop:
" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時に syntastic を走らせるファイルタイプを指定する

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"-------------------------------------------------------------------------------
" refe:
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス

"-------------------------------------------------------------------------------
" map:

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
" 常にvery magicを利用
nnoremap / /\v
" タブ移動
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

" :ls + :buffer
cnoremap bb ls<CR>:buf
" 開いてるファイルのパスを表示 (Show Path)
cnoremap sp echo expand("%:p")<CR>
" 現在日時を入力 (yyyy/MM/dd)
cnoremap date <ESC>a<C-r>=strftime("%Y/%m/%d")<CR><ESC>
" 現在日時を入力 (yyyy/MM/dd hh:mm:ss)
cnoremap datetime <ESC>a<C-r>=strftime("%Y/%m/%d %H:%M:%S")<CR><ESC>

"-------------------------------------------------------------------------------
" Unite:
"""nnoremap <silent>gs :Unite giti/status <CR>
"""nnoremap <silent>gb :Unite giti/branch_all <CR>

set confirm
set whichwrap=h,l,b,s,<,>,[,]

" ----------------
" cursor
let &t_ti .= "\e[1 q"
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"
let &t_te .= "\e[0 q"
