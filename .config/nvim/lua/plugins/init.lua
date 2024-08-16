return {
  { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
  { 'jalvesaq/Nvim-R' },
  { 'autozimu/LanguageClient-neovim',
    branch = 'next',
    build = 'bash install.sh'
  },
  { 'sbdchd/neoformat' },
  {
    'google/yapf',
    -- add the runtime path configuration
    config = function()
      vim.cmd [[
        set runtimepath+=path/to/plugins/vim
        filetype plugin indent on
      ]]
      -- additional configuration if needed
    end,
    cond = function()
      return vim.bo.filetype == 'python'
    end,
  }
}
