return {
  defaults = require("nvchad.configs.telescope").defaults,
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    fzf_native = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = false,
      case_mode = "smart_case",
    },
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
  extensions_list = {
    -- "fzf",
    -- "fzf_native",
    "fzy_native",
    "terms",
    "themes",
  },
}
