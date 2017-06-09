let g:setting_company = filereadable(expand('~/vimfiles/.company'))

let mapleader = ' '

let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repos_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('Shougo/vimproc.vim')
	call dein#add('Shougo/vimfiler.vim')
	call dein#add('itchyny/lightline.vim')
	call dein#add('ctrlpvim/ctrlp.vim')
	call dein#add('embear/vim-localvimrc')
	call dein#add('junegunn/vim-easy-align')
	call dein#add('ntpeters/vim-better-whitespace')
	call dein#add('wesQ3/vim-windowswap')
	call dein#add('rking/ag.vim')
	call dein#add('thinca/vim-quickrun')
	call dein#add('osyo-manga/shabadou.vim')
	call dein#add('osyo-manga/vim-watchdogs')
	call dein#add('tyru/restart.vim')
	call dein#add('davidhalter/jedi-vim')
	call dein#add('simeji/winresizer')
	call dein#add('SirVer/ultisnips')
	call dein#add('easymotion/vim-easymotion')

	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/unite-outline')
	call dein#add('osyo-manga/unite-quickfix')

	call dein#add('tepp91/molokaifork')
	call dein#add('tepp91/DoxygenToolkit.vim')

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

" vimproc
let g:vimproc#download_windows_dll = 1

" Vimfiler
let g:vimfiler_as_default_explorer = 1
nnoremap <C-e> :VimFiler -simple<CR>

augroup vimfiler
	autocmd!
	autocmd FileType vimfiler nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
	autocmd FileType vimfiler nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
augroup END

" unite
nnoremap <Leader>o :Unite -vertical outline<CR>

" lightline
let g:lightline = {
	\ 'colorscheme' : 'wombat',
	\ }

let g:lightline.inactive = {
	\ 'left' : [
	\	['filename', 'modified'],
	\ ],
	\ 'right' : [
	\	['lineinfo'],
	\	['percent'],
	\	['fileformat', 'fileencoding', 'filetype'],
	\ ],
	\ }

" vim-localvimrc
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

" DoxygenToolKit
let g:DoxygenToolkit_briefTag_pre = ''
let g:DoxygenToolkit_returnTag = '@return	'
let g:DoxygenToolkit_paramTag_pre = '@param	'
let g:DoxygenToolkit_compactDoc = 'yes'

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ctrlp対策
set wildignore+=*.obj,*.sdf,*.smp,*.ipch,*.idb,*.pdb

" quick-run
let g:quickrun_config = {
	\	'python/watchdogs_checker' : {
	\		'type' : 'watchdogs_checker/flake8',
	\	},
	\
	\ 	'cpp/watchdogs_checker' : {
	\		'type' : 'watchdogs_checker/msvc',
	\ 	},
	\
	\	'watchdogs_checker/msvc' : {
	\		'command' : 'C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe',
	\		'hook/output_encode/encoding' : 'sjis',
	\		'cmdopt' : '/Zs ',
	\	},
	\ }


" watchdog
if g:setting_company
	let g:watchdogs_check_BufWritePost_enables = {
		\ 'cpp' : 0,
		\ 'python' : 1,
		\ }
else
	let g:watchdogs_check_BufWritePost_enables = {
		\ 'cpp' : 1,
		\ 'python' : 1,
		\ }
endif

call watchdogs#setup(g:quickrun_config)

" restart
let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'

" jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" winresizer
let g:winresizer_start_key = '<C-w><C-e>'

" UltiSnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger='<C-k>'
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

if g:setting_company
	let g:UltiSnipsSnippetDirectories = ['ultisnippets_com']
else
	let g:UltiSnipsSnippetDirectories = ['ultisnippets']
endif

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" ファイルタイプ
au BufNewFile,BufRead *.xaml setf xaml

" タブ
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

autocmd FileType python setlocal expandtab
autocmd FileType python setlocal softtabstop=4

" 検索
set ignorecase
set smartcase

" その他
set nobackup
set noswapfile
set noundofile
set clipboard=unnamed
set shortmess+=I
set whichwrap=b,s,h,l,<,>,[,],~
set completeopt=preview
set autoread

" 行末ヤンク
nnoremap Y y$

" ノーマルモードでも改行
nnoremap <CR> :exec "normal o"<CR>
nnoremap <S-CR> :exec "normal O"<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>

" 改行時にコメントを続けない
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" xml、htmlなどのタグジャンプ
source $VIMRUNTIME/macros/matchit.vim

" C++インデント
au BufNewFile,BufRead *.cpp,*.h,*.inl set cindent
au BufNewFile,BufRead *.cpp,*.h,*.inl set cino=g0:0

" コメント行を書く
let s:comment_prefix = {
\	'cpp' : '//',
\	'python' : '# ',
\	'vim' : '"',
\	}

let s:comment_line_default_length = 79

let s:comment_line_length = {
\	'python' : 72,
\	}

function! WriteCommentLine()
	let prefix = get(s:comment_prefix, &filetype, '')
	if prefix == ''
		return ''
	endif

	let indent = (virtcol('.')-1)
	let length = get(s:comment_line_length, &filetype, s:comment_line_default_length)
	let comment = prefix . repeat('-', length-indent-strdisplaywidth(prefix))
	return comment
endfunction

inoremap <expr><C-l> WriteCommentLine()

" vimrcを開く
com! Openrc tabnew $HOME/vimfiles/vimrc
" gvimrcを開く
com! Opengrc tabnew $HOME/vimfiles/gvimrc


"pythonで書かれたvim script
python3 import vim
py3file <sfile>:h/vimrc.py

" C++名前空間を出力
function! WriteCppNamespace(...)
	python3 write_cpp_namespace(vim.eval('a:000'))
endfunction

com! -nargs=+ NS call WriteCppNamespace(<f-args>)
