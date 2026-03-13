return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,  -- Make loading lazy to avoid startup errors
    event = "VeryLazy",  -- Load after startup is complete
    build = function()
      -- Skip build if no compiler - we'll handle this differently
      if vim.fn.executable("gcc") == 0 and vim.fn.executable("clang") == 0 and vim.fn.executable("cl") == 0 and vim.fn.executable("zig") == 0 then
        return
      end
      vim.cmd(":TSUpdate")
    end,
    init = function()
      -- Set these globals early to prevent errors
      vim.g.ts_nocheck = true
      vim.g.loaded_treesitter = true  -- Prevent auto-loading
      vim.g.nvim_treesitter_no_c_compiler = true
    end,
    config = function()
      -- Only try to configure if the module exists
      local has_ts, config = pcall(require, "nvim-treesitter.configs")
      
      if not has_ts then
        vim.notify("Treesitter not available, skipping setup", vim.log.levels.INFO)
        return
      end
      
      -- Only basic features that don't need compiling
      config.setup({
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {},  -- Don't auto-install any parsers
        sync_install = false,   -- Don't try to install at startup
        prefer_git = false
      })
      
      -- Manual parser installation for specific languages
      -- This is a fallback for JS/TS support without compilation
      local parser_path = vim.fn.stdpath("data") .. "/site/parser"
      vim.fn.mkdir(parser_path, "p")
      
      -- Load pre-built parsers if they exist, but don't try to compile
      vim.opt.runtimepath:append(parser_path)
    end
  }
}
