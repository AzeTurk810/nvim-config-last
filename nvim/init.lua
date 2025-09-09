-- Set leader key before any mappings
vim.g.mapleader = ' '

-- cava
--
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

vim.o.termguicolors = true
vim.api.nvim_create_user_command("Stressbin", function()
  local solution = vim.fn.input("Solution file (name only, no .cpp): ") .. ".cpp"
  local brute    = vim.fn.input("Brute file (name only, no .cpp): ") .. ".cpp"
  local gen      = vim.fn.input("Generator file (name only, no .cpp): ") .. ".cpp"
  local rounds_s = vim.fn.input("Neçə test (tam ədəd): ")
  local rounds   = tonumber(rounds_s)

  if not rounds or rounds < 1 then
    print("Xətalı say: " .. (rounds_s or ""))
    return
  end

  local cmd = string.format([[
    g++ -std=c++17 -O2 %s -o solution && \
    g++ -std=c++17 -O2 %s -o brute && \
    g++ -std=c++17 -O2 %s -o gen && \
    i=1; \
    while [ $i -le %d ]; do \
      ./gen > in.txt || break; \
      ./solution < in.txt > out1.txt || break; \
      ./brute < in.txt > out2.txt || break; \
      if ! diff -q out1.txt out2.txt >/dev/null; then \
        echo "Mismatch test #$i"; \
        diff -u out1.txt out2.txt | sed -n '1,200p'; \
        break; \
      fi; \
      echo "OK $i"; \
      i=$((i+1)); \
    done
  ]], solution, brute, gen, rounds)

  vim.cmd("!" .. cmd)
end, {})

vim.api.nvim_create_user_command("Stress", function()
  local solution = vim.fn.input("Solution binary (name only): ")
  local brute    = vim.fn.input("Brute binary (name only): ")
  local gen      = vim.fn.input("Generator binary (name only): ")
  local rounds_s = vim.fn.input("Neçə test (tam ədəd): ")
  local rounds   = tonumber(rounds_s)

  if not rounds or rounds < 1 then
    print("Xətalı say: " .. (rounds_s or ""))
    return
  end

  local cmd = string.format([[
i=1; \
while [ $i -le %d ]; do \
  ./%s > in.txt || break; \
  ./%s < in.txt > out1.txt || break; \
  ./%s < in.txt > out2.txt || break; \
  if ! diff -q out1.txt out2.txt >/dev/null; then \
    echo "Mismatch test #$i"; \
    diff -u out1.txt out2.txt | sed -n '1,200p'; \
    break; \
  fi; \
  echo "OK $i"; \
  i=$((i+1)); \
done
]], rounds, gen, solution, brute)

  vim.cmd("!" .. cmd)
end, {})


require('options')
require('keymaps')
require('lazy').setup({
  spec = { { import = 'plugins' } },
  ui = { border = 'rounded' },
})

