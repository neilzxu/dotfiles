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

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- require("lazy").setup({
-- 	spec = {
-- 		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
-- 		{ "lervag/vimtex", lazy = false },
-- 	},
-- })


local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)


local function file_exists(name)
    local f = io.open(name, "r")
    if f then
        io.close(f)
        return true
    else
        return false
    end
end

local mac = vim.fn.stdpath("config") .. "/mac.vim"
if file_exists(mac) then
    vim.cmd.source(mac)
end
