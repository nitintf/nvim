-- Import the plugins array from plugins.lua
local myPlugins = require("nitintf.plugins")

-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(myPlugins, {
  install =  {
    colorschem = { "primer_dark", "habamax" },
    ui = {
      border = "rounded"
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
  }
})

