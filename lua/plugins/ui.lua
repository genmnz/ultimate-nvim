return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      local logo = [[
    ██╗    ███╗███████╗██╗      █████╗ ██████╗ 
    ████╗ ████║██╔════╝██║     ██╔══██╗██╔══██╗
    ██╔████╔██║█████╗  ██║     ███████║██║  ██║
    ██║╚██╔╝██║██╔══╝  ██║     ██╔══██║██║  ██║
    ██║ ╚═╝ ██║███████╗███████╗██║  ██║██████╔╝
    ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═════╝ 
      ]]
      opts.config = opts.config or {}
      opts.config.header = vim.split(logo, "\n")
      opts.config.disable_move = true
      vim.opt.scrolloff = 0
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function()
          vim.opt_local.scrolloff = 0
          vim.opt_local.cursorline = false
          vim.opt_local.modifiable = false
        end,
      })
      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#ff0000", bold = true })
      opts.config.highlight = { 
      header = "DashboardHeader",
      }
      
      opts.config.center = {
        { action = "Telescope find_files", desc = " Find File", icon = "󰈞 ", key = "f" },
        { action = "ene | startinsert", desc = " New File", icon = "󰈔 ", key = "n" },
        { action = "Telescope oldfiles", desc = " Recent Files", icon = "󰋚 ", key = "r" },
        { action = "Telescope live_grep", desc = " Find Text", icon = "󰈢 ", key = "g" },
        --{ action = "qa", desc = " Quit", icon = "󰅚 ", key = "q" },
      }
    end,
  },
} 
