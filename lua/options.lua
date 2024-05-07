require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.swapfile = false
o.colorcolumn = "80"
o.pumblend = 15 -- pseudo-transparency of popup-menu
o.pumheight = 25

local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.fs,*.fsx,*.fsi",
  command = [[set filetype=fsharp]],
})
