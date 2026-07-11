return {
  {
    "nvim-neorg/neorg",
    ft = { "norg", "org" },
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/github/obsidian-main",
            },
            default_workspace = "notes",
          },
        },
        ["core.qol.toc"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.itero"] = {},
        ["core.norg.converter"] = {              -- convert .org files
          config = {
            extensions = { "org" },
          },
        },
        ["core.keybinds"] = {
          hook = function(keybinds)
            keybinds.map("norg", "n", "<C-s>", ":Neorg sync-parsers<CR>")
          end,
        },
      },
    },
    -- Also register .org as a Neorg filetype
    init = function()
      vim.filetype.add({
        extension = {
          org = "norg",
        },
      })
    end,
  },
}
