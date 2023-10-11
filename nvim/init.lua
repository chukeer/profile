require('options')
require('keymaps')
require('plugins')
require('colorscheme')
require('lsp')
require('config.plugin-nvim-treesitter')
require('config.git')
require("nvim-tree").setup()
require("toggleterm").setup{}
require("symbols-outline").setup()
--require('lspsaga').setup({
--    ui = {
--        code_action = '', -- 替换小灯泡提示
--    },
--    outline = {
--        layout = "float"
--    },
--    use_saga_diagnostic_sign = true,
--    code_action_prompt = {
--        enable = true,
--        sign = true,
--        sign_priority = 40,
--        virtual_text = true
--    }
--})
