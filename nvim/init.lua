-- Set leader key before any mappings
vim.g.mapleader = ' '

-- Lazy.nvim bootstrap (unchanged)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.keymap.set("n", "<C-r>", function()
  vim.cmd("write")

  local filepath = vim.fn.expand("%:p")   -- tam path (full absolute path)
  local filename_noext = vim.fn.expand("%:t:r") -- faylın adı, uzantsız

  -- Əgər binary-nin adında boşluq varsa problem yaşamamaq üçün
  -- onu eyni qovluqda, amma `_` əvəzinə boşluqları dəyişərək yazırıq
  local binary_name = filename_noext:gsub("%s+", "_")

  local bash_cmd = string.format(
    [[bash -lc %q]],
    string.format(
      'g++ -std=c++17 --debug -Wall -Wextra -O2 %q -o %q 2>&1 && echo "\\n✅ Compilation succeeded, running..." && ./%s || echo "\\n❌ Compilation failed."',
      filepath,
      binary_name,
      binary_name
    )
  )

  vim.cmd("split")
  vim.cmd("terminal " .. bash_cmd)
end, { noremap = true })


require('options')
require('keymaps')
require('lazy').setup({
  spec = { { import = 'plugins' } },
  ui = { border = 'rounded' },
})

