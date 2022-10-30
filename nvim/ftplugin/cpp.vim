" nnoremap <F12> :call asyncrun#quickfix_toggle(6)<cr>
" nnoremap <silent> <F9> :AsyncRun clang++ -Wall -Wextra -O2 -DDEBUG "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" nnoremap <silent> <F7> :AsyncRun -cwd=<root>/build ninja <cr>
