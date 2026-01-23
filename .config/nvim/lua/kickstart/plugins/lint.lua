return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local markdownlint = require 'lint.linters.markdownlint'
      markdownlint.args = {
        '--config',
        '~/.config/markdownlint/markdown-lint.yml',
        '--stdin',
      }
      local buildifier = require 'lint.linters.buildifier'
      buildifier.args = {
        '-lint',
        'warn',
        '-mode',
        'check',
        '-warnings',
        '-module-docstring',
        '-format',
        'json',
        '-type',
        buildifier.args[#buildifier.args],
      }
      lint.linters_by_ft = {
        dockerfile = { 'hadolint' },
        ghaction = { 'actionlint' },
        html = { 'htmlhint' },
        markdown = { 'markdownlint' },
        ruby = { 'standardrb' },
        terraform = { 'tflint' },
        tiltfile = { 'buildifier' },
        yaml = { 'yamllint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only lint modifiable buffers
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
