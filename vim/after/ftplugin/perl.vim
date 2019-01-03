let perl_fold = 1
let perl_nofold_packages = 1
setlocal foldlevel=100
setlocal foldcolumn=1
compiler perl
let g:perl_compiler_force_warnings = 0
let b:ale_linters = ['perlcritic']
