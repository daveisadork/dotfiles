return {
  defaults = require("nvchad.configs.telescope").defaults,
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = false,
    },
  },
  extensions_list = {
    "fzf",
    "fzy_native",
    "terms",
    "themes",
  },
}
