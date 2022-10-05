let mapleader = "\<Space>"

nnoremap Y y$
" １行が長すぎる時の表示

" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 左右分割
noremap <C-\> :vsplit<CR>

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" jjでエスケープ
inoremap <silent> jj <ESC>
