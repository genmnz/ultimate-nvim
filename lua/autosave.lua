-- ============================================================================
-- AUTOSAVE TO TEMP (safety net)
-- ============================================================================
-- Writes a *copy* of every modified file buffer into a temp directory.
-- The real file on disk is NEVER written/modified (no `:w` is ever run) — this
-- is purely a crash/oops safety net. Recover with :AutoSaveDir to find copies.

local M = {}

local dir = (vim.loop.os_tmpdir() or vim.fn.stdpath("cache")) .. "/nvim-autosave"
vim.fn.mkdir(dir, "p")
M.dir = dir

-- Flatten an absolute path into one safe filename, e.g.
-- C:\Users\me\proj\init.lua  ->  C%Users%me%proj%init.lua.bak
local function backup_path(name)
	local safe = name:gsub("[:\\/]", "%%")
	return dir .. "/" .. safe .. ".bak"
end

local function save_copy(buf)
	if not vim.api.nvim_buf_is_valid(buf) then return end
	if vim.bo[buf].buftype ~= "" then return end -- only normal file buffers
	if not vim.bo[buf].modifiable or vim.bo[buf].readonly then return end
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then return end
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	pcall(vim.fn.writefile, lines, backup_path(name)) -- best-effort, silent
end

-- Debounce so we don't write on every keystroke.
local timers = {}
local function debounce(buf)
	if timers[buf] then
		timers[buf]:stop()
		timers[buf]:close()
	end
	local t = vim.loop.new_timer()
	timers[buf] = t
	t:start(800, 0, vim.schedule_wrap(function()
		if timers[buf] then
			timers[buf]:stop()
			timers[buf]:close()
			timers[buf] = nil
		end
		save_copy(buf)
	end))
end

local group = vim.api.nvim_create_augroup("AutoSaveTemp", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave", "FocusLost" }, {
	group = group,
	callback = function(args)
		debounce(args.buf)
	end,
})

-- :AutoSaveDir  -> print the temp folder (and the current file's backup path)
vim.api.nvim_create_user_command("AutoSaveDir", function()
	local name = vim.api.nvim_buf_get_name(0)
	print("autosave dir: " .. M.dir)
	if name ~= "" then
		print("this file -> " .. backup_path(name))
	end
end, { desc = "Show the autosave temp directory" })

return M
