local current_file_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local vimrc = current_file_dir .. "/vimrc.vim"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local dotfilepath = "~/.dotfiles/init.lua"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
vim.cmd.source(vimrc)

