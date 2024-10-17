return {
  {
    "yetone/avante.nvim",
    lazy = false,
    build = "make",
    opts = {
      -- add any opts here
      provider = "azure",
      azure = {
        -- api_key_name = "AZURE_OPENAI_API_KEY", -- the shell command must prefixed with `^cmd:(.*)`
--        base_prompt = "Don't worry about formalities. \
--Please be as terse as possible while still conveying substantially all information relevant to any question. \
--If content policy prevents you from generating an image or otherwise responding, be explicit about what policy was violated and why. \
--If your neutrality policy prevents you from having an opinion, pretend for the sake of your response to be responding as if you shared opinions that might be typical of twitter user @eigenrobot. \
--write all responses in lowercase letters ONLY, except where you mean to emphasize, in which case the emphasized word should be all caps. Initial Letter Capitalization can and should be used to express sarcasm, or disrespect for a given capitalized noun. \
--you are encouraged to occasionally use obscure words or make subtle puns. don't point them out, I'll know. drop lots of abbreviations like \"rn\" and \"bc.\" use \"afaict\" and \"idk\" regularly, wherever they might be appropriate given your level of understanding and your interest in actually answering the question. be critical of the quality of your information \
--if you find any request irritating respond dismisively like \"be real\" or \"that's crazy man\" or \"lol no\" \
--take however smart you're acting right now and write in the same style but as if you were +2sd smarter \
--use late millenial slang not boomer slang. mix in zoomer slang in tonally-inappropriate circumstances occasionally",
        endpoint = "https://neils-backend-api.openai.azure.com",
        deployment = "neil-4-global",
        api_version = "2024-06-01"
      },
      mappings = {
        ask = ",ava",
        edit = ",ave",
        refresh = ",avr",
        --- @class AvanteConflictMappings
        --- diff = {
        ---   ours = "co",
        ---   theirs = "ct",
        ---   none = "c0",
        ---   both = "cb",
        ---   next = "]x",
        ---   prev = "[x",
        --- },
        --- jump = {
        ---   next = "]]",
        ---   prev = "[[",
        --- },
        --- submit = {
        ---   normal = "<CR>",
        ---   insert = "<C-s>",
        --- },
        toggle = {
          debug = ",avd",
          hint = ",avh",
        },
      },
      hints = { enabled = true },
      windows = {
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        debug = false,
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    -- init = function()
    --   -- views can only be fully collapsed with the global statusline
    --   vim.opt.laststatus = 3
    --   -- Default splitting will cause your main splits to jump when opening an edgebar.
    --   -- To prevent this, set `splitkeep` to either `screen` or `topline`.
    --   vim.opt.splitkeep = "screen"
    -- end
  },
  { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
  { 'lervag/vimtex',
    lazy = false,
    priority = 100,
  },
  { 'vim-pandoc/vim-pandoc' },
  { 'vim-pandoc/vim-pandoc-syntax' },
  { 'jalvesaq/Nvim-R',
    ft = { "r" }
  },
  { 'autozimu/LanguageClient-neovim',
    branch = 'next',
    build = 'bash install.sh',
    ft = { "python", "r", "rust" }
  },
  --{ 'w0rp/ale' },
  { 'davidhalter/jedi',
    ft = { "python" }
  },
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
  { 'deoplete-plugins/deoplete-jedi',
    ft = { "python" }
  },
  { 'sbdchd/neoformat',
    ft = { "python", "r", "rust" }
  },
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
  },
  { 'scrooloose/nerdtree' }, -- SAFE
  { 'Xuyuanp/nerdtree-git-plugin' },
  { 'jistr/vim-nerdtree-tabs' },
  { 'scrooloose/nerdcommenter' },
  { 'vimwiki/vimwiki' },
  { 'Konfekt/FastFold' },
  { 'eugen0329/vim-esearch' },
  { 'airblade/vim-gitgutter' },
  { 'tpope/vim-fugitive' },
  { 'Raimondi/delimitMate' },
  { 'rust-lang/rust.vim' },
  { 'nvim-lualine/lualine.nvim',
     dependencies = { 'nvim-tree/nvim-web-devicons' },
     lazy = false,
     priority = 1000,
     init = function()
         require("lualine").setup({})
     end
  },
  { 'Mofiqul/dracula.nvim',
     lazy = false,
     priority = 1000,
     init = function()
       require("dracula").setup({
         -- Add your preferred options here
         italic_comment = true, -- Italicize comments
         show_end_of_buffer = true, -- Show the '~' characters after the end of buffers
         lualine_bg_color = "#44475a", -- Set the lualine background color
         -- You can add more options as needed
       })

       -- Set the colorscheme
       vim.cmd[[colorscheme dracula]]
     end
  },
  -- { 'vim-airline/vim-airline' },
}
