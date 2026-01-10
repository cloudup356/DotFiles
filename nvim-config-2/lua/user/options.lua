vim.opt.number = true
vim.opt.relativenumber = true -- Start with relative numbers

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function() vim.opt.relativenumber = true end,
})
