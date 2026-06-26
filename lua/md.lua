-- ============================================================================
-- MARKDOWN: a distinct theme (separate from the code colorscheme) + preview
-- ============================================================================
-- The @markup.* highlight groups only ever render in markup files (markdown,
-- etc.), so overriding them here gives markdown its own look without touching
-- how code is colored.

local M = {}

-- Warm / orange markdown palette.
local function apply_theme()
	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- emphasis
	hl("@markup.strong", { fg = "#ff8c42", bold = true }) -- **bold** -> orange
	hl("@markup.italic", { fg = "#ffcf9e", italic = true }) -- *italic* -> warm
	hl("@markup.strikethrough", { fg = "#8a8a8a", strikethrough = true })

	-- headings: warm descending palette (clearly different from code's cyan titles)
	hl("@markup.heading.1", { fg = "#ff8c42", bold = true })
	hl("@markup.heading.2", { fg = "#ffb454", bold = true })
	hl("@markup.heading.3", { fg = "#ffd479", bold = true })
	hl("@markup.heading.4", { fg = "#e0c097", bold = true })
	hl("@markup.heading.5", { fg = "#cdb292", bold = true })
	hl("@markup.heading.6", { fg = "#bba37f", bold = true })

	-- inline code / fenced code
	hl("@markup.raw", { fg = "#a3d9a5", bg = "#1c1c1c" }) -- `inline code`
	hl("@markup.raw.block", { fg = "#cfe8cf" })

	-- links / quotes / lists
	hl("@markup.link.label", { fg = "#87d7ff", underline = true })
	hl("@markup.link.url", { fg = "#6c8cff", underline = true })
	hl("@markup.quote", { fg = "#b0a0d0", italic = true })
	hl("@markup.list", { fg = "#ff8c42" })
	hl("@markup.list.checked", { fg = "#00d75f" })
	hl("@markup.list.unchecked", { fg = "#ff7700" })
end

local group = vim.api.nvim_create_augroup("MarkdownTheme", { clear = true })
-- (re)apply after any colorscheme load so it survives :ReloadTheme
vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = apply_theme })
-- and whenever a markdown buffer is entered (belt and suspenders)
vim.api.nvim_create_autocmd("FileType", { group = group, pattern = "markdown", callback = apply_theme })
apply_theme()

-- ----------------------------------------------------------------------------
-- Preview: render the current markdown file with `glow` in a floating window.
-- ----------------------------------------------------------------------------
function M.preview()
	if vim.bo.filetype ~= "markdown" then
		vim.notify("Not a markdown file", vim.log.levels.WARN)
		return
	end
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("Save the file first, then preview", vim.log.levels.WARN)
		return
	end
	if vim.fn.executable("glow") == 0 then
		vim.notify("glow not found on PATH", vim.log.levels.ERROR)
		return
	end

	local width = math.floor(vim.o.columns * 0.85)
	local height = math.floor(vim.o.lines * 0.85)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.b[buf].keep_on_exit = true -- don't let the global TermClose delete it
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " Markdown preview — j/k scroll, q/Esc close ",
		title_pos = "center",
	})

	local function close()
		pcall(vim.api.nvim_win_close, win, true)
	end

	-- Render (no pager) into this terminal buffer so the ANSI colors show. After
	-- glow exits, the buffer keeps the rendered text and is scrollable in normal
	-- mode (j/k, Ctrl-d/Ctrl-u, gg/G) -- glow's own pager doesn't work in Neovim's
	-- Windows terminal, which is why it was clipped/unscrollable before.
	vim.fn.jobstart({ "glow", "-s", "dark", "-w", tostring(width - 2), file }, {
		term = true,
		on_exit = function()
			vim.schedule(function()
				if not vim.api.nvim_win_is_valid(win) then
					return
				end
				vim.cmd("stopinsert") -- normal mode so j/k scroll the buffer
				pcall(vim.api.nvim_win_set_cursor, win, { 1, 0 })
			end)
		end,
	})

	-- closers (buffer-local <Esc> overrides the global terminal <Esc>)
	vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
	vim.keymap.set("t", "<Esc>", close, { buffer = buf, nowait = true })
end

vim.keymap.set("n", "<leader>v", M.preview, { desc = "Preview markdown (glow)" })

return M
