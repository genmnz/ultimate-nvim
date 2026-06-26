-- PLUGINS (vim.pack)
vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
  	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
	-- Offline dictionary + thesaurus (synonyms) completion for prose/novel writing
	"https://github.com/archie-judd/blink-cmp-words",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("nvim-tree.lua")
-- LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")
packadd("blink-cmp-words")

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

-- nvim-treesitter (master branch): compiles parsers directly with a C compiler.
-- Force gcc, since tree-sitter's default cl.exe (MSVC) isn't installed on this machine.
require("nvim-treesitter.install").compilers = { "gcc" }
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- editor essentials
		"lua",
		"vim",
		"vimdoc",
		"r",
		"python",
		"typescript",
		"tsx",
		"javascript",
		"html",
		"css",
		"json",
		"bash",
		-- writing (book / scripts / editorial)
		"markdown",
		"markdown_inline",
		-- disabled for now — uncomment to re-enable:
		-- "rust",
		-- "c",
	},
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-- Compatibility shim for nvim-treesitter's FROZEN `master` branch on Neovim 0.12+.
-- Its markdown code-fence injection directives index a query match as a single
-- TSNode (registered with all=false), but Neovim 0.12 removed that compat so a
-- match capture is now a list (TSNode[]). The mismatch throws
--   "attempt to call method 'range' (a nil value)"
-- when opening markdown with ``` fenced code blocks. Re-register the affected
-- directives with all=true and pull the first node ourselves.
-- Refs: nvim-treesitter#8636, nvim-treesitter#8618, neovim#39032.
do
	local tsq = vim.treesitter.query
	local function first_node(v)
		if type(v) == "table" then return v[1] end
		return v
	end

	local injection_aliases = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }
	local function lang_from_info_string(alias)
		local m = vim.filetype.match({ filename = "a." .. alias })
		return m or injection_aliases[alias] or alias
	end

	tsq.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
		local node = first_node(match[pred[2]])
		if not node then return end
		local alias = vim.treesitter.get_node_text(node, bufnr):lower()
		metadata["injection.language"] = lang_from_info_string(alias)
	end, { force = true, all = true })

	tsq.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
		local id = pred[2]
		local node = first_node(match[id])
		if not node then return end
		local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
		if not metadata[id] then metadata[id] = {} end
		metadata[id].text = string.lower(text)
	end, { force = true, all = true })
end

require("nvim-tree").setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		group_empty = true,
	},
})
vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })

vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-- Minimal fzf-lua: the "default" profile gives sensible fuzzy defaults.
-- Two pickers cover the ask: `files()` = filename search, `live_grep()` = fuzzy content search.
require("fzf-lua").setup({
	"default",
	winopts = { height = 0.85, width = 0.85, preview = { layout = "vertical" } },
})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})
-- Let plugins that look for nvim-web-devicons (e.g. nvim-tree) use mini.icons,
-- so the file tree shows the same per-filetype/language icons as the statusline.
require("mini.icons").mock_nvim_web_devicons()
require("mini.indentscope").setup({
	draw = {
	options = {border = 'both',
    indent_at_cursor = true,
    try_as_border = true,
  },
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" }, -- green  (GitSignsAdd)
		change = { text = "~" }, -- blue   (GitSignsChange)
		delete = { text = "_" }, -- red    (GitSignsDelete)
		topdelete = { text = "‾" }, -- red    (GitSignsTopdelete)
		changedelete = { text = "~" }, -- blue   (GitSignsChangedelete)
		untracked = { text = "┆" }, -- muted  (GitSignsUntracked)
	},
	signcolumn = true,
	current_line_blame = false,
})

require("mason").setup({})

vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })


-- luasnip
local luasnip = require("luasnip")

require("blink.cmp").setup({
	-- highlight = {
	-- 	bg = "#FF03F7",	
	-- },
	snippet = {
		-- blink passes the snippet as a string (not a table); pass it straight to luasnip
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},
	keymap = {
		preset = "default",
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},
})

-- luasnip keymaps (after plugins are loaded)
vim.keymap.set({ "i", "s" }, "<Tab>", function() luasnip.jump(1) end, { silent = true, desc = "Jump forward" })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function() luasnip.jump(-1) end, { silent = true, desc = "Jump backward" })
vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true, desc = "Jump forward" })
vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true, desc = "Jump backward" })
vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true, desc = "Expand snippet" })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, { silent = true, desc = "Change choice" })
