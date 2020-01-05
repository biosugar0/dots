function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> <f1> <plug>(lsp-rename)
  nmap <buffer> == <plug>(lsp-document-format)
  nmap <buffer> gD <plug>(lsp-references)
  nmap <buffer> gs <plug>(lsp-document-symbol)
  nmap <buffer> gS <plug>(lsp-workspace-symbol)
  vmap <buffer> = <plug>(lsp-document-range-format)
  nmap <buffer> gt <plug>(lsp-type-definition)
  imap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  nmap <buffer> K <Plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

autocmd BufWritePre <buffer> LspDocumentFormatSync
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

let g:lsp_settings = {
            \ 'workspace_config': {'gopls': {
            \ 'staticcheck': v:true,
            \ 'completeUnimported': v:true,
            \ 'caseSensitiveCompletion': v:true,
            \ 'usePlaceholders': v:true,
            \ 'completionDocumentation': v:true,
            \ 'watchFileChanges': v:true,
            \ 'hoverKind': 'SingleLine',
            \   }},
            \}
