return {
  'nvimdev/dashboard-nvim',
  config = function()
    require('dashboard').setup({
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          '',
          '',
          '',
          '                                                                   ',
          '      ████ ██████           █████      ██                    ',
          '     ███████████             █████                            ',
          '     █████████ ███████████████████ ███   ███████████  ',
          '    █████████  ███    █████████████ █████ ██████████████  ',
          '   █████████ ██████████ █████████ █████ █████ ████ █████  ',
          ' ███████████ ███    ███ █████████ █████ █████ ████ █████ ',
          '██████  █████████████████████ ████ █████ █████ ████ ██████',
          '',
          '',
          '',
          '',
          '',
        },
        center = {
          {
            icon = '  ',
            desc = 'Open File          ',
            key = 'a',
            action = function()
              vim.ui.input({ prompt = 'File name: ' }, function(input)
                if input and input ~= '' then
                  vim.cmd('e ' .. input)
                end
              end)
            end,
          },
          {
            icon = '  ',
            desc = 'File Explorer      ',
            key = 'e',
            action = 'Neotree toggle'
          },
          {
            icon = '  ',
            desc = 'Find Files         ',
            key = 'f',
            action = 'Telescope find_files'
          },
          {
            icon = '  ',
            desc = 'Recent Files       ',
            key = 'r',
            action = 'Telescope oldfiles'
          },
          {
              icon = '  ',         -- Folder icon (or choose any icon you like)
              desc = 'Projects           ',
              key = 'p',
              action = 'Telescope project'
          },
          {
            icon = '  ',
            desc = 'Config             ',
            key = 'c',
            action = 'e ~/.dotfiles/nvim'
          },
          {
            icon = '  ',
            desc = 'Quit               ',
            key = 'q',
            action = 'qa'
          }
        },
        footer = {}
      },
    })
  end
}
