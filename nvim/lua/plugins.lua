-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()


-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        ---------------------------------------
        -- NOTE: PUT YOUR THIRD PLUGIN HERE --
        ---------------------------------------

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end

        use 'tanvirtin/monokai.nvim'
        use 'shaunsingh/solarized.nvim'
        use { 'williamboman/mason.nvim' }
        use { 'williamboman/mason-lspconfig.nvim'}
        use { 'neovim/nvim-lspconfig' }
        use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }
        use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' } -- buffer auto-completion
        use { 'hrsh7th/cmp-path', after = 'nvim-cmp' } -- path auto-completion
        use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' } -- cmdline auto-completion
        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'
        use {'junegunn/fzf', run = function()
            vim.fn['fzf#install']()
        end
        }
        use 'junegunn/fzf.vim'
        use 'vim-scripts/a.vim'
        use 'mileszs/ack.vim'
        use 'Lokaltog/vim-easymotion'
        use 'terryma/vim-multiple-cursors' -- 多光标操作，ctrl-m选择下一个，ctrl-p回到上一个，ctrl-x跳过当前
        use 'ntpeters/vim-better-whitespace'
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }}
        --use 'preservim/nerdtree'
        --use {'kevinhwang91/nvim-bqf', ft = 'qf'}
        use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
        use 'nvim-tree/nvim-web-devicons'
        use 'ryanoasis/vim-devicons'
        use {"akinsho/toggleterm.nvim", tag = '*', config = function()
            require("toggleterm").setup()
        end}
        use 'tpope/vim-fugitive'
        --use 'kablamo/vim-git-log'
        use {
            'lewis6991/gitsigns.nvim',
            tag = 'release',
        }
        use "sindrets/diffview.nvim"
        use 'simrat39/symbols-outline.nvim'
		use ({
			'nvimdev/lspsaga.nvim',
			after = 'nvim-lspconfig',
			config = function()
				require('lspsaga').setup({
					ui = {
						code_action = '', -- 替换小灯泡提示
					},
					outline = {
						layout = "float"
					},
                    use_saga_diagnostic_sign = true,
                    code_action_prompt = {
                        enable = true,
                        sign = true,
                        sign_priority = 40,
                        virtual_text = true
                    }
				})
			end,
		})
    end)

