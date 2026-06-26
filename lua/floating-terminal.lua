-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function(args)
		-- keep buffers that want to stay (e.g. the markdown glow preview, so its
		-- rendered output remains visible and scrollable after glow exits)
		if vim.b[args.buf].keep_on_exit then
			return
		end
		if vim.v.event.status == 0 then
			pcall(vim.api.nvim_buf_delete, args.buf, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end
	if not has_terminal then
		-- Pick a real interactive shell and launch it with the LIST form so Neovim
		-- runs it DIRECTLY (no 'shell'/'shellcmdflag' wrapping). On this machine
		-- vim.o.shell is Git bash but shellcmdflag is cmd-style "/s /c", so the
		-- string form produced `bash.exe /s /c ...` -> exit 127. Avoid all that.
		local shell
		if vim.fn.has("win32") == 1 then
			-- Prefer Windows PowerShell 5.1 (pwsh 7 is broken on this machine:
			-- hostfxr.dll load error), fall back to cmd.exe.
			if vim.fn.executable("powershell") == 1 then
				shell = "powershell"
			else
				shell = "cmd.exe"
			end
		else
			shell = os.getenv("SHELL") or "bash"
		end
		-- jobstart({...}, {term=true}) is the modern, non-deprecated terminal API.
		vim.fn.jobstart({ shell }, { term = true })
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
	-- Also try to exit terminal mode and go back to normal
	vim.cmd("stopinsert")
	vim.keymap.set("n", "<Esc>", "", { buffer = terminal_state.buf })
end, { noremap = true, silent = true, desc = "Close floating terminal" })
