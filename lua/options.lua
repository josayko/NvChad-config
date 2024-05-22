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

local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = group_cdpwd,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_current_dir(vim.fn.expand "%:p:h")
  end,
})
