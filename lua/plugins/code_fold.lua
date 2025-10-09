return  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' }
    ,
    opts = {
        filetype_exclude = {
            'help', 'alpha', 'dashboard', 'neo-tree',
            'Trouble', 'lazy', 'mason'
        },
    },
    
    config = function(_, opts)
        
        local ufo = require('ufo')
        ufo.setup({
            provider_selector = function (bufrn, filetype, buftype)
                return {'treesitter', 'indent'}
            end
        })

        vim.opt.foldlevelstart = 99
        vim.opt.foldlevel = 99
        vim.opt.foldenable = true
        vim.opt.foldcolumn = '1'
        vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        require('ufo').setup(opts)
    end,
}
