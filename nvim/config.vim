" toggle quickfix
function! ToggleQuickFix()
    let nr = winnr("$")
    cwindow
    let nr2 = winnr("$")
    if nr == nr2
        cclose
    endif
endfunc
nnoremap <leader>q :call ToggleQuickFix()<cr>
nnoremap <silent> <leader>T :!ctags.sh . &<cr>
