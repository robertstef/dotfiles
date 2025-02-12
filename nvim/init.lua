vim.g.mapleader = ','

require("config.lazy")

vim.cmd([[colorscheme gruvbox]])
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]])
vim.cmd([[nnoremap <leader>ct :!ctags --languages=Scheme,C,C++,Tcl,Lisp,Python -R  --exclude="*obj/*" src<CR>]])

vim.o.showmatch = true -- show matching
vim.o.mouse = "v" -- middle click paste
vim.o.hlsearch = true -- highlight search
vim.o.incsearch = true -- incremental search
vim.o.tabstop = 4  -- number of columns occupied by a tab
vim.o.softtabstop = 4 -- multiple spaces as tabstops
vim.o.expandtab = true -- convert tabs to whitespace
vim.o.shiftwidth = 4 -- width for autoindents
vim.o.autoindent = true -- indent newline same as line above
vim.o.number = true -- show line numbers
-- vim.o.cc = "80" -- column border at 80
vim.o.clipboard = "unnamedplus" -- use system clipboard
-- vim.o.colorscheme = "gruvbox" -- set color scheme
-- vim.o.background = "dark" -- background color for gruvbox

