"--------------------
"" 基本的な設定
"--------------------
"python設定
au! BufNewFile,BufRead *.jl setf julia
"vimgrep
autocmd QuickFixCmdPost *grep* cwindow
"let $PATH = "~/.pyenv/shims:".$PATH
"let $PYTHONHOME=$HOME."/.pyenv/versions/2.7.11"
"set pythondll=$HOME/.pyenv/versions/2.7.11/lib/libpython2.7.dylib
"py import sys
"let $PYTHONHOME=$HOME."/.pyenv/versions/3.5.2"
"set pythonthreedll=$HOME/.pyenv/versions/3.5.2/lib/libpython3.5m.dylib
"py3 import sys
"バックアップ設定
set directory=$HOME/vimbackup/tmp
set backupdir=$HOME/vimbackup/backupfile
:set noundofile
"画面設定
set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;
" 不可視文字の表示記号指定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
"移動設定
set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8                "上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
"ファイル処理関連
set confirm "保存されていないファイルがあるときは終了前に保存確認
set hidden "保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread "外部でファイルに変更がされた場合は読みなおす
"検索設定
set hlsearch "検索文字列をハイライトする
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan "最後尾まで検索を終えたら次の検索で先頭に移る
"タブ、インデント設定
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
"コピペ関連
"OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
" マウスの入力を受け付ける
set mouse=
"コマンドライン関連
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を1000件保存する
set history=1000
"ビープ音関連
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない
" ステータス
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=[%p%%]\ [LEN=%L]
set laststatus=2 
set fileencoding=utf-8
"オートコメントアウト無効
au FileType * setlocal formatoptions-=ro

nnoremap t  <Nop>
nnoremap tt  <C-]> "飛ぶ」
nnoremap tj  :<C-u>tag<CR>  " 「進む」
nnoremap tk  :<C-u>pop<CR>  " 「戻る」
nnoremap tl  :<C-u>tags<CR> " 履歴一覧
"------------------------------------------------------
""plugin設定
let g:jedi#force_py_version = 3
"" ---------- dein.vim 設定 ----------
"" ディレクトリ設定
"" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
"" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:rc_dir = expand('~/.vim/rc')
"" dein.vim がないときgit clone
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
        execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif
"" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
"
"  " プラグインリストを収めた TOML ファイル
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
"
"  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
"
"  " 設定終了
  call dein#end()
  call dein#save_state()
endif
"
"" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
""------------------------------------------------------------
""jedi-vim
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1

"  # 補完キーの設定この場合はCtrl+Space
let g:jedi#completions_command = "<C-Space>"  
let g:jedi#goto_assignments_command = "<C-g>"   " 変数の宣言場所へジャンプ（Ctrl + g)
let g:jedi#goto_definitions_command = "<C-d>"   " クラス、関数定義にジャンプ（Gtrl + d）
let g:jedi#documentation_command = "<C-k>"      " Pydocを表示（Ctrl + k）
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
""""""
""------------------------------------------------------------
"color
colorscheme desert
autocmd ColorScheme * highlight Constant ctermfg=207 
set t_Co=256
filetype plugin indent on
syntax enable   
