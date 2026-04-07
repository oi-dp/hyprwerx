function ll --description 'substitution for ls -l, just nicer'
  eza --classify=auto --icons auto --group-directories-first --sort=extension -A $argv
end

