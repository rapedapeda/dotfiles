local M = {}

local function notes_root()
    return vim.fn.resolve(vim.fn.expand('~/notes'))
end

-- Moves the current buffer's file from projects/ or areas/ into the
-- matching archive/projects/ or archive/areas/ folder, via `git mv`,
-- then reopens the buffer at its new location.
function M.archive_current_file()
    local root = notes_root()
    local filepath = vim.fn.resolve(vim.api.nvim_buf_get_name(0))

    if filepath == '' then
        print('Archive: buffer has no file')
        return
    end

    if filepath:sub(1, #root + 1) ~= root .. '/' then
        print('Archive: file is not inside ' .. root)
        return
    end

    local rel = filepath:sub(#root + 2)
    local category, filename = rel:match('^(projects)/([^/]+)$')
    if not category then
        category, filename = rel:match('^(areas)/([^/]+)$')
    end
    if not category then
        print('Archive: only files directly in projects/ or areas/ can be archived (got ' .. rel .. ')')
        return
    end

    local dest_rel = 'archive/' .. category .. '/' .. filename
    local dest_abs = root .. '/' .. dest_rel

    if vim.loop.fs_stat(dest_abs) then
        print('Archive: ' .. dest_rel .. ' already exists')
        return
    end

    if vim.bo.modified then
        vim.cmd('write')
    end

    -- git mv refuses untracked files, so make sure it's in the index first.
    vim.fn.system({ 'git', '-C', root, 'add', rel })

    local result = vim.fn.system({ 'git', '-C', root, 'mv', rel, dest_rel })
    if vim.v.shell_error ~= 0 then
        print('Archive: git mv failed: ' .. vim.trim(result))
        return
    end

    local old_buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)

    vim.cmd('edit ' .. vim.fn.fnameescape(dest_abs))
    pcall(vim.api.nvim_win_set_cursor, 0, cursor)
    vim.api.nvim_buf_delete(old_buf, { force = true })

    print('Archived to ' .. dest_rel)
end

return M
