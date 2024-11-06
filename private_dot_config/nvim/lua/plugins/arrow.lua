return {
  'otavioschwanck/arrow.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    show_icons = true,
    index_keys = 'asdfgqwert',
    leader_key = '<leader>h',
    buffer_leader_key = '<leader>m',
    mappings = {
      quit = 'esc',
      toggle = 'h',
      edit = 'z',
      remove = 'x',
      delete_mode = 'X',
      clear_all_items = 'C',
      open_vertical = 'v',
      open_horizontal = 'S',
      next_item = ']',
      prev_item = '[',
    },
  },
}
