" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
"入力中のコマンドをステータスに表示する
set showcmd
" 行番号を表示
set number
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
" 行末の一文字先までカーソルを移動できるように
set virtualedit=onemore
" 行頭、行末移動
nnoremap <S-h> 0
nnoremap <S-l> $

" -------------------------------------------
" タブ・インデント
" -------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が埋める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 開業時に前の行のインデントを継続する
set smartindent " 改行時に前の公文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅



"--------------------------------------------
" 文字列検索
"--------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>



"--------------------------------------------
" カラースキーム
"--------------------------------------------
syntax enable " 構文に色をつける
"set t_Co=256

" gruvbox
set background=dark
colorscheme gruvbox
"-------
" molokai
"colorscheme molokai
"-------
" solarized
"set background=dark
"colorscheme solarized
"-------
" hybrid
"set background=dark
"colorscheme hybrid
"-------
" atom-dark
"colorscheme atom-dark-256
"-------
" tender
"colorscheme tender
"-------
" lucario
"colorscheme lucario
"-------
" lucius
"colorscheme lucius
"set background=dark

"--------------------------------------------
"補完ウィンドウ表示
"--------------------------------------------
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"

inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
    call dein#begin(s:dein_path)
    let g:config_dir  = expand('~/.cache/userconfig')
    let s:toml        = g:config_dir . '/plugin.toml'
    let s:lazy_toml   = g:config_dir . '/plugin_lazy.toml'

    " TOML 読み込み
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif


" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

"-----------------------------------------
"プラグイン管理
"-----------------------------------------
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②

" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'

" インデントの可視化
NeoBundle 'Yggdroot/indentLine'

" コードの自動補完
NeoBundle 'Shougo/neocomplete.vim'

" 構文エラーチェック
NeoBundle 'scrooloose/syntastic'

" コードの自動補完
NeoBundle 'Shougo/neocomplete.vim'

" スニペットの補完機能
NeoBundle "Shougo/neosnippet"

" スニペット集
NeoBundle 'Shougo/neosnippet-snippets'

"----------------------------------------------------------
call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck



"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する1:



"----------------------------------------------------------
" Syntasticの設定
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
"let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
"let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを表示
"let g:syntastic_auto_loc_list = 1
" ファイルを開いた時に構文エラーチェックを実行する
"let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
"let g:syntastic_check_on_wq = 1
" 複数指定する場合はカンマ区切り
" let g:syntastic_python_flake8_args = '--ignore="E501,E302"'
"let g:syntastic_python_flake8_args = '--ignore="E225,E265,E302,E501,F401"'


"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif
