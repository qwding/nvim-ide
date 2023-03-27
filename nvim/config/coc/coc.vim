" Conquer of completion configuration.
"
" @author Maciej Bedra

" Do not pass messages to ins-completion-menu
set shortmess+=c

" Do not shift text with sign column
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Code completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Key binding used to trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" Confirm completion
"inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
"      \: "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Key bindings used to scroll pop ups content
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"


nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>


" Highlight symbol and references on cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Key binding used to format code
nmap <leader>cf <Plug>(coc-format)

" Key binding for code action (optimize imports, generate code, etc.)
nmap <leader>ca <Plug>(coc-codeaction)

" Key binding for quick fix
nmap <leader>cq <Plug>(coc-fix-current)

" Key binding used to show code errors, warnings, etc.
nmap <leader>ce :CocList diagnostics<CR>

" Key binding for code outline
nmap <M-7> :CocList outline<CR>

" Key binding used to find symbol
nmap <leader>cs :CocList -I symbols<CR>
