local neotest_ns = vim.api.nvim_create_namespace "neotest"

local animations = {
  clock = {
    "󱑋",
    "󱑌",
    "󱑍",
    "󱑎",
    "󱑏",
    "󱑐",
    "󱑑",
    "󱑒",
    "󱑓",
    "󱑔",
    "󱑕",
    "󱑖",
  },
  moon = {
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  },
}

local icons = {

  octocat = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    failed = "",
    passed = "",
    running = "",
    skipped = "",
    unknown = "",
    watching = "",
    running_animated = animations.moon,
  },

  md = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    failed = "󰅚",
    passed = "󰄴",
    running = "󱥸",
    skipped = "󰍷",
    unknown = "󰘥",
    watching = "󰛐",
    running_animated = animations.moon,
  },
}

-- vim.diagnostic.config({
--   virtual_text = false,
-- }, neotest_ns)
--
---@type NvPluginSpec[]
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("neotest").setup {
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest",
          unknown = "NeotestUnknown",
          watching = "NeotestWatching",
        },
        icons = icons.md,
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          open = "botright vsplit | vertical resize 50",
          mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            output = "o",
            short = "O",
            attach = "a",
            jumpto = "i",
            stop = "u",
            run = "r",
            debug = "d",
            mark = "m",
            run_marked = "R",
            debug_marked = "D",
            clear_marked = "M",
            target = "t",
            clear_target = "T",
            next_failed = "J",
            prev_failed = "K",
          },
        },
        status = {
          enabled = true,
          virtual_text = false,
          signs = true,
        },
        quickfix = {
          enabled = true,
          open = false,
        },
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
            args = { "--cov", "--cov-report=html" },
            pytest_discover_instances = false,
          },
          require "neotest-go" {
            experimental = {
              test_table = true,
            },
          },
          require "neotest-jest" {
            env = {
              TZ = "UTC",
            },
          },
          require "neotest-plenary",
          require "neotest-vim-test" {
            ignore_file_types = { "go", "python", "vim", "lua" },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        mode = "n",
        desc = "toggle test summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open()
        end,
        mode = "n",
        desc = "show test output",
      },
      {
        "<leader>tp",
        function()
          require("neotest").output_panel.toggle()
        end,
        mode = "n",
        desc = "toggle test output panel",
      },
      {
        "<leader>t<cr>",
        function()
          local neotest = require "neotest"
          neotest.run.run(vim.fn.expand "%")
          neotest.summary.open()
        end,
        mode = "n",
        desc = "run test file",
      },
      {
        "<leader>tn",
        function()
          local neotest = require "neotest"
          neotest.run.run()
          neotest.summary.open()
        end,
        mode = "n",
        desc = "run nearest test",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        mode = "n",
        desc = "run last test(s)",
      },
      {
        "<leader>tt",
        function()
          local neotest = require "neotest"
          neotest.run.run { suite = true }
          neotest.summary.open()
        end,
        mode = "n",
        desc = "run test suite",
      },
      {
        "<leader>tk",
        function()
          require("neotest").run.stop()
        end,
        mode = "n",
        desc = "stop running test(s)",
      },
      {
        "<leader>tb",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        mode = "n",
        desc = "debug nearest test",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        mode = "n",
        desc = "attach to nearest test",
      },
      {
        "<leader>twf",
        function()
          local neotest = require "neotest"
          neotest.watch.toggle(vim.fn.expand "%")
          neotest.summary.open()
        end,
        mode = "n",
        desc = "watch test file",
      },
      {
        "<leader>twn",
        function()
          local neotest = require "neotest"
          neotest.watch.toggle()
          neotest.summary.open()
        end,
        mode = "n",
        desc = "watch nearest test",
      },
      {
        "<leader>twt",
        function()
          local neotest = require "neotest"
          neotest.watch.toggle { suite = true }
          neotest.summary.open()
        end,
        mode = "n",
        desc = "watch test suite",
      },
      {
        "<leader>fn",
        function()
          require("neotest").jump.next { status = "failed" }
        end,
        mode = "n",
        desc = "jump to next failed test",
      },
      {
        "<leader>fp",
        function()
          require("neotest").jump.prev { status = "failed" }
        end,
        mode = "n",
        desc = "jump to previous failed test",
      },
    },
  },
}
