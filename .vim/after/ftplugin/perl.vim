let perl_fold = 1
let perl_nofold_packages = 1
setlocal foldlevel=100
setlocal foldcolumn=1
compiler perl
let g:perl_compiler_force_warnings = 0
let b:ale_linters = ['perlcritic']
let b:ale_fixers = ['perltidy']
set tabstop=4 shiftwidth=4 softtabstop=4
setlocal expandtab
