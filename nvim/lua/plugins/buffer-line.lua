return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- for file icons
    },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers", -- or "tabs"
                numbers = "none", -- "ordinal" | "buffer_id" | "both" etc.
                close_command = "bdelete! %d", -- close buffer
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,

                indicator = {
                    icon = "▎", -- or '|' or anything else
                    style = "icon",
                },

                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",

                max_name_length = 30,
                max_prefix_length = 30,
                tab_size = 25,

                diagnostics = "nvim_lsp", -- show LSP diagnostics in tab
                diagnostics_update_in_insert = false,

                offsets = {
                    {
                        filetype = "neo-tree", -- for Neo-tree
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                    {
                        filetype = "NvimTree", -- for nvim-tree
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    }
                },

                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,

                persist_buffer_sort = true,

                separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' }
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                sort_by = "id", -- or "extension" | "relative_directory" | "directory" | function(buffer_a, buffer_b) end
            },
        })
    end
}

