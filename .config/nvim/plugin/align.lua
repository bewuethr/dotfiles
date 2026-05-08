local function align(char)
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local split = {}
  local max_cols = 0
  for i, line in ipairs(lines) do
    split[i] = vim.split(line, char, { plain = true })
    max_cols = math.max(max_cols, #split[i])
  end

  local widths = {}
  for col = 1, max_cols - 1 do
    widths[col] = 0
    for _, parts in ipairs(split) do
      if parts[col] then
        widths[col] = math.max(widths[col], #parts[col])
      end
    end
  end

  local result = {}
  for i, parts in ipairs(split) do
    for col = 1, #parts - 1 do
      parts[col] = parts[col] .. string.rep(' ', widths[col] - #parts[col])
    end
    result[i] = table.concat(parts, char)
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
end

vim.keymap.set('x', 'gl', function()
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)
  vim.schedule(function()
    align(vim.fn.getcharstr())
  end)
end)
