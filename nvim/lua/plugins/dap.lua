local icons = {
  cod = {},
}

return { -- dap debugging {{{
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    {
      "mfussenegger/nvim-dap-python",
      opts = { console = "integratedTerminal" },
      config = function(_, opts)
        require("dap-python").setup(nil, opts)
      end,
    },
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
    },
  },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      mode = "",
      desc = "Toggle breakpoint",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      mode = "",
      desc = "Continue debugging",
    },
  },
  config = function()
    local dap, dapui = require "dap", require "dapui"
    -- require("dap.ext.vscode").load_launchjs(nil)
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "",
      texthl = "DapBreakpointRejected",
      linehl = "",
      numhl = "",
    })

    dap.defaults.fallback.terminal_win_cmd = "tabnew"
    dap.defaults.fallback.focus_terminal = true

    dapui.setup {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = "",
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = "",
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "console",
              size = 0.5,
            },
            {
              id = "repl",
              size = 0.5,
            },
          },
          position = "right",
          size = 88,
        },
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      require("dapui").close()
    end
    dofile(vim.g.base46_cache .. "dap")
  end,
}
