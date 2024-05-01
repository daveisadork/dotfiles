local mason_nvim_dap = require "mason-nvim-dap"

return {
  ensure_installed = {},
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      mason_nvim_dap.default_setup(config)
    end,
    delve = function(config)
      table.insert(config.configurations, {
        type = "delve",
        name = "Delve: Debug with args",
        request = "launch",
        program = "${file}",
        args = function()
          local argument_string = vim.fn.input "Program arguments: "
          return vim.fn.split(argument_string, " ", true)
        end,
      })
      mason_nvim_dap.default_setup(config)
    end,
  }, -- sets up dap in the predefined manner
}
