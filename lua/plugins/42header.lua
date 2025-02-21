local config = require("plugins.configheader42")
local utils = require("plugins.utilsheader42")

local M = {}

function M.setup(opts)
    local custom = vim.api.nvim_create_augroup("custom_header_group", {})

    config.set(opts)
    vim.api.nvim_create_user_command("Stdheader", utils.stdheader, {})

    if config.opts.auto_update == true then
        vim.api.nvim_create_autocmd("BufWritePre", {
            nested = true,
            group = custom,
            callback = function()
                local header = utils.gen_header()
                if utils.has_header(header) then
                    utils.update_header(header)
                end
            end,
        })
    end

    if config.opts.default_map == true then
        vim.keymap.set("n", "<F13>", ":Stdheader<CR>", { silent = true, noremap = true })
        --vim.keymap.set("n", "<F13>", "<Nop>", { noremap = true, silent = true })
    end
end

return M
