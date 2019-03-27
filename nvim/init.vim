let g:python3_host_prog = '/usr/local/bin/python3'

"set config dir
let $XDG_CONFIG_HOME = $HOME."/.config"

""キーバインド
"jjをescに
inoremap <silent> jj <ESC>
"

set runtimepath+=$XDG_CONFIG_HOME/nvim/rplugin
"-------補完設定
"=をファイル名の一部と認識させない
setlocal isfname-== isfname+=32
"補完時にpreview ウインドウを使わない
set completeopt=menuone
"deoplete設定
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:lsp_async_completion = 1

let mapleader = "\<Space>"
if executable('golsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'golsp',
        \ 'cmd': {server_info->['golsp', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif

"nmap <silent> <Leader>d :LspDefinition<CR>
"nmap <silent> <Leader>p :LspHover<CR>
"nmap <silent> <Leader>r :LspReferences<CR>
"nmap <silent> <Leader>i :LspImplementation<CR>
"nmap <silent> <Leader>s :split \| :LspDefinition <CR>
"nmap <silent> <Leader>v :vsplit \| :LspDefinition <CR>


""バックアップ設定
if isdirectory($XDG_CONFIG_HOME."/nvim/backup") == 0
    call mkdir($XDG_CONFIG_HOME."/nvim/backup")
endif
set directory=$XDG_CONFIG_HOME/nvim/backup
set backupdir=$XDG_CONFIG_HOME/nvim/backup
if has('persistent_undo')
    set undodir=$XDG_CONFIG_HOME/nvim/backup
    set undofile
endif

""画面設定
"ファイルをひらいたとき最後にカーソルがあった場所に移動
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
set breakindent            " インデントされた行の折り返しを綺麗に
"" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:%,eol:↲,extends:❯,precedes:❮
set encoding=utf-8
""移動設定
set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8                "上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
""ファイル処理関連
set confirm "保存されていないファイルがあるときは終了前に保存確認
set hidden "保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread "外部でファイルに変更がされた場合は読みなおす
""検索設定
set hlsearch "検索文字列をハイライトする
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan "最後尾まで検索を終えたら次の検索で先頭に移る
""タブ、インデント設定
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
""コピペ関連
""OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
"" マウスの入力を受け付ける
set mouse=
""コマンドライン関連
"" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
"" コマンドラインの履歴を1000件保存する
set history=1000
""ビープ音関連
""ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

"" ステータス
let g:airline_theme = 'badwolf'
" virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)
let g:airline#extensions#virtualenv#enabled = 1
" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0
" Lintツールによるエラー、警告を表示(ALEの拡張)
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'
let g:ale_fixers = {'python': ['autopep8', 'isort','yapf']}
let g:ale_linters = {'python': ['pycodestyle', 'pyflakes']}
let g:ale_fix_on_save = 1

set fileencoding=utf-8
""オートコメントアウト無効
au FileType * setlocal formatoptions-=ro
"
""ctags
nnoremap t  <Nop>
nnoremap tt  <C-]> " 飛ぶ
nnoremap tj  :<C-u>tag<CR>  " 「進む」
nnoremap tk  :<C-u>pop<CR>  " 「戻る」
nnoremap tl  :<C-u>tags<CR> " 履歴一覧
""プラグイン設定

"" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"" 設定開始

if isdirectory($XDG_CONFIG_HOME."/nvim") == 0
    call mkdir($XDG_CONFIG_HOME."/nvim")
endif
if filereadable($XDG_CONFIG_HOME."/nvim/"."dein.toml") == 0
    execute "redir > ".$XDG_CONFIG_HOME."/nvim/"."dein.toml"
endif
if filereadable($XDG_CONFIG_HOME."/nvim/"."dein_lazy.toml") == 0
    execute "redir > ".$XDG_CONFIG_HOME."/nvim/"."dein_lazy.toml"
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく

  let g:rc_dir    = expand($XDG_CONFIG_HOME."/nvim")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
"
"  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
"
  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"" カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>

""color
"colorscheme desert
autocmd ColorScheme * highlight Constant ctermfg=207
set t_Co=256
filetype plugin indent on
syntax enable
""保存時の設定
" 末尾の空白削除
autocmd BufWritePre * :%s/\s\+$//ge
