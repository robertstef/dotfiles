return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvim_tree = require('nvim-tree')
    local keymap = vim.keymap

    keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<CR>')
    keymap.set('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
    keymap.set('n', '<leader>f!', '<cmd>NvimTreeFindFile!<CR>')

    nvim_tree.setup({
        view = { adaptive_size = true }
    })
  end,
}
