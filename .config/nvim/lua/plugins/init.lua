return {
  { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
  { 'lervag/vimtex',
    lazy = false,
    ft = { "tex" }
  },
  { 'vim-pandoc/vim-pandoc' },
  { 'vim-pandoc/vim-pandoc-syntax' },
  { 'jalvesaq/Nvim-R',
    ft = { "r" }
  },
  { 'autozimu/LanguageClient-neovim',
    branch = 'next',
    build = 'bash install.sh'
  },
  { 'w0rp/ale' },
  { 'davidhalter/jedi' },
  { 'Shougo/deoplete.nvim',
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g["python3_host_prog"] = vim.fn.system('printf $(which python3)')
      vim.g["deoplete#enable_at_startup"] = 1
    end,
    config = function()
      vim.fn["deoplete#custom#var"]("omni", "input_patterns", {
        tex = vim.g["vimtex#re#deoplete"],
      })
      --vim.fn["deoplete#custom#var"]("omni", "input_patterns", {
      --  pandoc = '@',
      --})
    end,
  },
  { 'deoplete-plugins/deoplete-jedi' },
  { 'sbdchd/neoformat' },
  { 'google/yapf',
    -- add the runtime path configuration
    config = function()
      vim.cmd [[
        set runtimepath+=path/to/plugins/vim
        filetype plugin indent on
      ]]
      -- additional configuration if needed
    end,
    ft = { "python" }
  }
}
