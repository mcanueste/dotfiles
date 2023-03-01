return { 
  'numToStr/Comment.nvim', 
  version = false,
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
  end,
}
