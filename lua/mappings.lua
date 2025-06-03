require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })

map("n", "<leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add json struct tags" })
map("n", "<leader>gsy", "<cmd> GoTagAdd yaml <CR>", { desc = "Add yaml struct tags" })

-- Gisigns
local gitsigns = require "gitsigns"
map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
map("v", "<leader>gs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Stage hunk" })
map("v", "<leader>gr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset hunk" })
map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>gb", function()
  gitsigns.blame_line { full = true }
end, { desc = "Blame line" })
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
map("n", "<leader>gD", function()
  gitsigns.diffthis "~"
end, { desc = "Diff this ~" })
map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
-- Text object
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

-- Open diagnostics on cursor hold
map("n", "<leader>dd", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Toggle diagnostics float" })
