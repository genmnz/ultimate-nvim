-- ============================================================================
-- Massive offline dictionary completion source for blink.cmp
-- ============================================================================
-- Serves prefix completions from dict/words_alpha.txt (~370k words, sorted).
-- The list is alphabetically sorted, so prefix matches form a contiguous range
-- we find with binary search -> fast with no external tools (no ripgrep needed).

local M = {}

local words = nil -- lazily-loaded sorted array

local function load_words()
	if words then
		return words
	end
	words = {}
	local path = vim.fn.stdpath("config") .. "/dict/words_alpha.txt"
	local f = io.open(path, "r")
	if not f then
		vim.notify("blink_dict: wordlist not found at " .. path, vim.log.levels.WARN)
		return words
	end
	local data = f:read("*a")
	f:close()
	for w in data:gmatch("[^\r\n]+") do
		words[#words + 1] = w
	end
	return words
end

-- first index i where list[i] >= key (1-based), or #list+1
local function lower_bound(list, key)
	local lo, hi = 1, #list + 1
	while lo < hi do
		local mid = math.floor((lo + hi) / 2)
		if list[mid] < key then
			lo = mid + 1
		else
			hi = mid
		end
	end
	return lo
end

function M.new(opts)
	return setmetatable({ opts = opts or {} }, { __index = M })
end

function M:enabled()
	return vim.tbl_contains({ "markdown", "text", "gitcommit", "" }, vim.bo.filetype)
end

function M:get_completions(ctx, callback)
	local before = ctx.line:sub(1, ctx.cursor[2])
	local prefix = before:match("[%a']+$") or ""
	local min = self.opts.min_keyword_length or 2
	local empty = { items = {}, is_incomplete_backward = false, is_incomplete_forward = false }

	if #prefix < min then
		callback(empty)
		return function() end
	end

	local list = load_words()
	if #list == 0 then
		callback(empty)
		return function() end
	end

	local key = prefix:lower()
	local n = #key
	local cap_first = prefix:sub(1, 1):match("%u") ~= nil
	local cap = self.opts.max_items or 100
	local kind = require("blink.cmp.types").CompletionItemKind.Text

	local items = {}
	local i = lower_bound(list, key)
	while i <= #list and #items < cap do
		local w = list[i]
		if w:sub(1, n) ~= key then
			break
		end
		local label = cap_first and (w:sub(1, 1):upper() .. w:sub(2)) or w
		items[#items + 1] = { label = label, insertText = label, kind = kind }
		i = i + 1
	end

	-- we capped results, so let blink re-query as the user types more
	callback({ items = items, is_incomplete_backward = true, is_incomplete_forward = true })
	return function() end
end

return M
