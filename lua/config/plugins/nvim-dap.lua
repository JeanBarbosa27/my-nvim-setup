return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- installs the `delve` debug adapter via mason:
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve", "codelldb" } },
      },

      -- Go-specific dap plugin:
      { "leoluz/nvim-dap-go",              opts = {} },

      -- Rust-specific dap plug-in:
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    keys = {
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "Debug: Start/Continue"
      },
      {
        "<F10>",
        function() require("dap").step_over() end,
        desc = "Debug: Step Over"
      },
      {
        "<F11>",
        function() require("dap").step_into() end,
        desc = "Debug: Step Into"
      },
      {
        "<F12>",
        function() require("dap").step_out() end,
        desc = "Debug: Step Out"
      },
      {
        "<S-F5>",
        function() require("dap").terminate() end,
        desc = "Debug: Stop"
      },
      {
        "<space>dbb",
        function() require("dap").toggle_breakpoint() end,
        desc = "Debug: Toggle Breakpoint"
      },
      {
        "<space>dbu",
        function() require("dapui").toggle() end,
        desc = "Debug: Toggle UI"
      },
      {
        "<space>dbt",
        function() require("dap-go").debug_test() end,
        desc = "Debug: Nearest Go test"
      },
      {
        "<space>dbc",
        function() require("dap").run_last() end,
        desc = "Debug: Restart / Run last"
      },
      {
        "<space>dbB",
        function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
        desc = "Debug: Conditional breakpoint"
      }
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Define breakpoint sign when debugging
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
    end,
  },
}
