local M = {}

function M.get_task_priority(status)
    local priorities = {
        ["NEXT"] = 1,
        ["TODO"] = 2, 
        ["DONE"] = 3,
        ["CLOSED"] = 4
    }
    return priorities[status] or 5
end

function M.parse_org_entry(lines, start_idx)
    local entry = {}
    local i = start_idx
    
    -- Get the main task line
    local task_line = lines[i]
    local status = task_line:match("^%* (%w+)")
    local title = task_line:match("^%* %w+ (.+)") or task_line:match("^%* (.+)")
    
    entry.status = status or ""
    entry.title = title or ""
    entry.lines = {task_line}
    entry.priority = M.get_task_priority(status)
    
    -- Collect associated lines (CLOSED, DEADLINE, dates, etc.)
    i = i + 1
    while i <= #lines and not lines[i]:match("^%*") do
        if vim.trim(lines[i]) ~= "" then
            table.insert(entry.lines, lines[i])
        end
        i = i + 1
    end
    
    entry.end_idx = i - 1
    return entry, i
end

function M.sort_current_buffer()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local entries = {}
    local i = 1
    
    while i <= #lines do
        if lines[i]:match("^%*") then
            local entry, next_i = M.parse_org_entry(lines, i)
            table.insert(entries, entry)
            i = next_i
        else
            i = i + 1
        end
    end
    
    -- Sort by priority
    table.sort(entries, function(a, b)
        return a.priority < b.priority
    end)
    
    -- Build new buffer content
    local new_lines = {}
    for _, entry in ipairs(entries) do
        for _, line in ipairs(entry.lines) do
            table.insert(new_lines, line)
        end
        table.insert(new_lines, "")
    end
    
    -- Remove last empty line if it exists
    if new_lines[#new_lines] == "" then
        table.remove(new_lines, #new_lines)
    end
    
    -- Replace buffer content
    vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
    print("Sorted " .. #entries .. " tasks")
end

function M.sort_org_file(filename)
    local file = io.open(filename, "r")
    if not file then
        print("Error: Could not open file " .. filename)
        return
    end
    
    local content = file:read("*all")
    file:close()
    
    local lines = {}
    for line in content:gmatch("[^\r\n]*") do
        table.insert(lines, line)
    end
    
    local entries = {}
    local i = 1
    
    while i <= #lines do
        if lines[i]:match("^%*") then
            local entry, next_i = M.parse_org_entry(lines, i)
            table.insert(entries, entry)
            i = next_i
        else
            i = i + 1
        end
    end
    
    -- Sort by priority
    table.sort(entries, function(a, b)
        return a.priority < b.priority
    end)
    
    -- Write sorted content back
    local output = io.open(filename, "w")
    for _, entry in ipairs(entries) do
        for _, line in ipairs(entry.lines) do
            output:write(line .. "\n")
        end
        output:write("\n")
    end
    output:close()
    
    print("Sorted " .. #entries .. " tasks in " .. filename)
end

return M