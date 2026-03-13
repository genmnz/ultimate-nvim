return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      -- Keymaps for telescope
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      -- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      -- vim.keymap.set("n", "<leader>fs", function()
      --   builtin.grep_string({ search = vim.fn.input("Grep > ") })
      -- end)

      require("telescope").load_extension("ui-select")
    end,
  },
}
