"======================================
"    Script Name:  vim-sync-on-save
"    Plugin Name:  AutoSyncOnSave
"        Version:  0.0.1
"======================================

if exists("g:sync_on_save_loaded")
  finish
else
  let g:sync_on_save_loaded = 1
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:sync_on_save")
  let g:sync_on_save = 0
endif

if g:sync_on_save >= 1
  if filereadable(".vim/vim-sync-on-save.vim")
    source .vim/vim-sync-on-save.vim
  endif
endif

if g:sync_on_save >= 1 && !exists("g:sync_on_save_prefix")
  echo 'Error: g:sync_on_save_prefix is undefined. Should be defined in .vim/vim-syn-on-save.vim'
  let g:sync_on_save = 0
endif

augroup sync_on_save
  autocmd!
  au BufWritePost * nested call SyncOnSave()
augroup END

function! SyncOnSave()
  if g:sync_on_save >= 1
    let g:sync_on_save = 0
    let l:from_path = fnamemodify(expand("%"), ":~:.")
    let l:to_path = g:sync_on_save_prefix . "/" . from_path
    echo "(Synced " . l:from_path . " => " . l:to_path .  " at " . strftime("%H:%M:%S") . ")"
    execute ':w!' . l:to_path
    let g:sync_on_save = 1
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

