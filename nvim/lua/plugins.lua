local packer = require('packer')
local use = packer.use

packer.reset()
packer.init {
    git = {
        clone_timeout = -1
    }
}

use 'lukas-reineke/indent-blankline.nvim'
use 'tpope/vim-surround'
use 'wbthomason/packer.nvim'
use 'neovim/nvim-lspconfig'
use 'folke/tokyonight.nvim'
use {'ms-jpq/coq_nvim', branch = 'coq'}
use {'ms-jpq/chadtree', branch = 'chad'}
use {
  'nvim-lualine/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
}

