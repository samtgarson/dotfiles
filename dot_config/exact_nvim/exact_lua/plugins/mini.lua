return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require('mini.comment').setup()
      require('mini.surround').setup()
    end
  }
}
