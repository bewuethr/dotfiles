let b:ale_linters = ['shellcheck']
let b:ale_fixers = ['shfmt']
let b:ale_sh_shellcheck_options = '-x'
let b:ale_sh_shfmt_options = '-bn -ci -sr -ln bats'
