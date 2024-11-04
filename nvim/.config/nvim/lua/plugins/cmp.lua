return {
    "saghen/blink.cmp",
    version = "0.*",
    opts_extend = { "sources.completion.enabled_providers" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",

    opts = {
      fuzzy = {
        prebuilt_binaries = {
          download = true,
          force_version = "v0.5.0",
        },
      },
      highlight = {
        use_nvim_cmp_as_default = false,
      },
      nerd_font_variant = "mono",
      windows = {
        autocomplete = {
          draw = "reversed",
        },
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } }
      sources = {
        completion = {
          -- remember to enable your providers here
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
      },

      keymap = {
        preset = "super-tab",
      },
    },
  }
