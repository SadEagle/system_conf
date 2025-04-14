return {
  "mfussenegger/nvim-dap",
  config = function()
    -- Signs styles, cattpuccin highlights
    -- TODO: add background color for DapStopped
    vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define("DapBreakpointCondition",
      { text = "⬤", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

    -- Python debug
    local dap = require 'dap'
    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      else
        cb({
          type = 'executable',
          -- Global debugpy package
          command = '/usr/bin/python',
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end

    dap.configurations.python = {
      {
        -- Nvim-dap options
        type = 'python',
        request = 'launch',
        name = "Launch file",

        -- Debugpy options
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = os.getenv("VIRTUAL_ENV") .. "/bin/python"
      },
    }
  end,
  keys = {
    { '<leader>wd', function() require 'dap'.continue() end,          desc = "Dap start/continue debug" },
    { '<leader>wt', function() require 'dap'.toggle_breakpoint() end, desc = "Dap toggle break point" },
    { '<leader>wp', function() require 'dap'.step_over() end,         desc = "Dap step over" },
    { '<leader>wn', function() require 'dap'.step_into() end,         desc = "Dap step into" },
    -- { '<leader>wR', function() require 'dap'.repl.open() end,         desc = "Dap repl UI" },
  }
}
