""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
"
" Shamelessly stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  if len(filenames) > 0
    exec "edit " . filenames[0]
    for filename in filenames[1:]
      exec "vsp " . filename
    endfor
  end
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

nnoremap ,ocf :OpenChangedFiles<CR>

function! OpenDiffAgainstDevelop()
  only " Close all windows, unless they're modified
  let filenames = split(system('git diff develop --name-only -- app'), "\n")

  if len(filenames) > 0
    exec "edit " . filenames[0]
    for filename in filenames[1:]
      exec "vsp " . filename
      exec "sp"
      exec "A"
      exec "normal \<c-k>"
      exec "normal \<c-l>"
    endfor
  end
  exec "normal Q"
endfunction
command! OpenDiffAgainstDevelop :call OpenDiffAgainstDevelop()

nnoremap ,od :OpenDiffAgainstDevelop<CR>
