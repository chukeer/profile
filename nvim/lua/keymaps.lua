-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.mapleader = ','

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

vim.keymap.set('n', '<leader>n', ':set number!<CR>', opts)
vim.keymap.set('n', '<leader>p', ':set paste!<CR>:set paste?<CR>', opts)
vim.keymap.set('n', '<leader>a', ':A', opts)
vim.keymap.set('n', '<leader><leader>c', ':tabc<CR>', opts)
vim.keymap.set('n', '<leader>T', ':!ctags.sh . &<cr>', opts)

vim.cmd[[
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
]]

vim.cmd[[
function! BuildCmakeProj(cmd)
    if getfsize("CMakeLists.txt") <= 0
        echo "CMakeListsx.txt not found in working directory!"
        return
    endif
    if a:cmd == "build"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j
        cd -
    elseif a:cmd == "install"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j
        make install
        cd -
    elseif a:cmd == "clean"
        cd build
        make clean
        cd -
    elseif a:cmd == "rebuild"
        call system("rm -rf build")
        call mkdir("build")
        cd build
        silent exec "!cmake .. -DCMAKE_BUILD_TYPE=Debug"
        make -j 1
        cd -
    endif
endfu

au FileType cpp,cmake nnoremap <F6> :call BuildCmakeProj("build")<cr>
au FileType cpp,cmake nnoremap <F7> :call BuildCmakeProj("install")<cr>
au FileType cpp,cmake nnoremap <F9> :call BuildCmakeProj("clean")<cr>
au FileType cpp,cmake nnoremap <F10> :call BuildCmakeProj("rebuild")<cr>
]]

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

---- FZF
vim.keymap.set('n', '<leader>z', ':FZF<CR>', opts)
vim.keymap.set('n', '<leader>@', ':BTags<CR>', opts)
vim.keymap.set('n', '<leader>t', ':Tags<CR>', opts)
vim.keymap.set('n', '<leader>B', ':Buffers<CR>', opts)

---- a.vim
vim.keymap.set('n', '<leader>a', ':A<CR>', opts)

---- nvim-tree
vim.keymap.set('n', '<leader>N', ':NvimTreeToggle<CR>', opts)

---- bufferline
vim.keymap.set('n', '<leader>bn', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<leader>bp', ':BufferLineCycleNext<CR>', opts)

---- fugitive
vim.keymap.set('n', '<leader><leader>B',  ':G blame<CR>', opts)
vim.keymap.set('n', '<leader><leader>g',  ':G log --graph --pretty=format:"%Cred%h%Creset %Cgreen(%cd) -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset" --date=iso %<CR>', opts)

---- gitsigns
vim.keymap.set('n', 'gb',  ':Gitsigns blame_line<CR>', opts)

---- symbols-outline
vim.keymap.set('n', '<leader>so', ':SymbolsOutline<CR>', opts)

---- lspsaga
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'go', '<cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
