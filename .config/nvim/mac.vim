" let g:vimtex_view_method = "skim"
" let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'
"
" augroup vimtex_mac
"     autocmd!
"     autocmd User VimtexEventCompileSuccess call UpdateSkim()
"     autocmd FileType tex call SetServerName()
" augroup END
"
" function! UpdateSkim() abort
"     let l:out = b:vimtex.out()
"     let l:src_file_path = expand('%:p')
"     let l:cmd = [g:vimtex_view_general_viewer, '-r']
"
"     if !empty(system('pgrep Skim'))
"     call extend(l:cmd, ['-g'])
"     endif
"
"     call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
" endfunction
"
" function! SetServerName()
"   call system('echo ' . v:servername . ' > /tmp/curvimserver')
" endfunction
let g:tex_flavor='latex' " Default tex file format
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'skim' " Choose which program to use to view PDF file
let g:vimtex_view_skim_sync = 1 " Value 1 allows forward search after every successful compilation
let g:vimtex_view_skim_activate = 1 " Value 1 allows change focus to skim after command `:VimtexView` is given
