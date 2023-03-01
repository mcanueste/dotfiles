return { 
  'kylechui/nvim-surround', 
  version = false,
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup()
  end,
}
