-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.has("nvim-0.12") == 1 and vim.fn.has("nvim-0.11") == 0 then
  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      xpcall(function()
        require("vim._extui").enable({})
      end, function() end)
    end,
  })
end
