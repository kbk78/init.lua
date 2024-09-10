vim.opt.clipboard = 'unnamedplus'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autowriteall=true
vim.opt.wrap=false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.autochdir=true
vim.opt.hidden=true
vim.opt.laststatus=2



-- macro to remove commnnts in idf and change to single line string
-- let @e = ":s/,/,\\r/g\<CR>"
-- let @c = ":s/\\n//\<CR>"
vim.keymap.set('v', '<Leader>s', ":s/,.*/,<CR>gv:s/;.*/;<CR>gv:s/^ */<CR>gv:s/\\n/<CR>gv:s/^/'<CR>gv:s/$/'<CR>", {silent=true})
vim.keymap.set('v', '<Leader>r', ':s/,/,\\r/g<CR>', {silent=true})
vim.keymap.set('v', '<Leader>c', ':s/\\n//<CR>', {silent=true})

-- allow the . to execute once for each line of a visual selection
vim.keymap.set('v', '.', ':normal .<CR>')
-- "allow macro to execute once for each line of a visual selection
-- xnoremap Q :'<,'>:normal @q<CR>

-- save on focuslost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" },
	{ callback = function() 
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command('silent update') end
		end, })

-- navigate splits
vim.keymap.set('n', '<c-h>', '<c-w>h', {silent=true})
vim.keymap.set('n', '<c-j>', '<c-w>j', {silent=true})
vim.keymap.set('n', '<c-k>', '<c-w>k', {silent=true})
vim.keymap.set('n', '<c-l>', '<c-w>l', {silent=true})

-- resize with arrows
vim.keymap.set('n', '<up>', ':resize +2<cr>', {silent=true})
vim.keymap.set('n', '<down>', ':resize -2<cr>', {silent=true})
vim.keymap.set('n', '<left>', ':vertical resize -2<cr>', {silent=true})
vim.keymap.set('n', '<right>', ':vertical resize +2<cr>', {silent=true})

-- insert an empty line
vim.keymap.set('n', '<c-o>', 'i<cr><esc>0', {silent=true})

-- show list in buffer to select
vim.keymap.set('n', '<Leader>b', ':ls<CR>:b<Space>', {silent=true})
vim.keymap.set('n', '<Tab>',':b#<CR>', {silent=true})



-- Explore files
vim.keymap.set('n', '<Leader>e', ':E<CR>', {silent=true})

-- conflict with splitnavigation
-- vim.keymap.set('n', '<c-h>',':bn<CR>', {silent=true})
-- vim.keymap.set('n', '<c-j>',':bp<CR>', {silent=true})

-- replace current word/selection with contents of paste buffer
vim.keymap.set('n', '<c-p>', '"_cw"<esc>', {silent=true})
vim.keymap.set('v', '<c-p>', '"_c"<esc>', {silent=true})

-- Surround/brackets
vim.keymap.set('v', '"', 'c"<c-r>+"<esc>', {silent=true})
vim.keymap.set('v', "'", "c'<c-r>+'<esc>", {silent=true})
vim.keymap.set('v', '{', 'c{<c-r>+}<esc>', {silent=true})
vim.keymap.set('v', '[', 'c[<c-r>+]<esc>', {silent=true})
vim.keymap.set('v', '9', 'c(<c-r>+)<esc>', {silent=true})
vim.keymap.set('n', '<leader>9', 'i()<esc>ba', {silent=true})
vim.keymap.set('n', '<leader>"', 'i""<esc>ba', {silent=true})
vim.keymap.set('n', "<leader>'", "i''<esc>ba", {silent=true})
vim.keymap.set('n', '<leader>[', 'i[]<esc>ba', {silent=true})
vim.keymap.set('n', '<leader>{', 'i{}<esc>ba', {silent=true})



-- file shortcuts
vim.keymap.set('n', '<leader>v', '<cmd>e  ~/AppData/Local/nvim/init.lua<cr>', {silent=true})
vim.keymap.set('n', '<leader>wk', '<cmd>e ~/personal/career/google.md<cr>', {silent=true})
vim.keymap.set('n', '<leader>wj', '<cmd>e ~/personal/journal.md<cr>', {silent=true})

-- python comments
vim.keymap.set({'v','n'}, ',c', ':s/^/#<CR>:noh<CR>', {silent=true})
vim.keymap.set({'v','n'}, ',x', ':s/^#//<CR>:noh<CR>', {silent=true})




-- stay at current word when using star search
vim.keymap.set('n', '*', function() vim.fn.setreg('/', vim.fn.expand('<cword>')) end, {silent=true})

vim.keymap.set('v','//','y/<C-R>"<CR>', {silent=true})



-- Install lazy.Nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
------

-- Install plugins (colorscheme, neorg)

require("lazy").setup({
  "rebelot/kanagawa.nvim",  -- neorg needs a colorscheme with treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  }
})

vim.cmd.colorscheme('kanagawa')
