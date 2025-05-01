" ~/.vim/colors-profiles.vim

function! SetColorProfile(profile)
  if a:profile ==# 'everforest-light'
    set background=light
    colorscheme everforest
  elseif a:profile ==# 'iceberg-light'
    set background=light
    colorscheme iceberg
  elseif a:profile ==# 'everforest-dark'
    set background=dark
    colorscheme everforest
  elseif a:profile ==# 'rosepine-moon'
    set background=dark
    colorscheme rosepine_moon
  elseif a:profile ==# 'peachpuff'
    set background=light
    colorscheme peachpuff

  else
    echo "Unknown theme: " . a:profile
  endif
endfunction

