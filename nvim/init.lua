local fn = vim.fn
local g = vim.g
local cmd = vim.cmd

require('settings')    -- lua/settings.lua
require('maps')        -- lua/maps.lua

-- Configuration to load after loading plugins
function _G.load_post_plugin_config()
    require('plugins')
    require('maps')
end

-- If Packer is not installed, download it and all plugins and reload config
-- If Packer is installed, load configuration as usual
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_install_path)) > 0
then
    -- Download Packer and add it
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..packer_install_path)
    cmd('packadd packer.nvim')

    -- Load plugins
    require('plugins')
    package.loaded['plugins'] = nil

    -- Automatically sync packer and load the rest of the config
    cmd('PackerSync')
    require('utils').create_augroup({
        {'User', 'PackerComplete', '++once', 'call v:lua.load_post_plugin_config()'}
    }, 'load_post_plugin_config')
else
    _G.load_post_plugin_config()
end
