-- ============================================================================
-- PROSE / NOVEL WRITING helpers
-- ============================================================================
-- Spell checking + a persistent personal dictionary + autocorrect for common
-- typos, scoped to prose filetypes only (markdown / text / gitcommit) so it
-- never interferes with code. Dictionary + thesaurus *completion* is provided
-- separately by blink-cmp-words (configured in lua/lsp.lua).

-- Persistent personal word list: add words with `zg`, undo with `zw`.
-- Lives in the config so it can be version-controlled.
local spelldir = vim.fn.stdpath("config") .. "/spell"
vim.fn.mkdir(spelldir, "p")
vim.opt.spelllang = "en_us"
vim.opt.spellfile = spelldir .. "/en.utf-8.add"

-- Massive offline wordlist (dict/words_alpha.txt, ~370k words) for native
-- insert-mode dictionary completion (<C-x><C-k>). The same list also powers the
-- `bigdict` blink source configured in lua/lsp.lua. NOTE: this is used for
-- COMPLETION only -- it is intentionally NOT fed into spellcheck, so spell still
-- catches real typos instead of silently accepting obscure dictionary words.
local wordlist = vim.fn.stdpath("config") .. "/dict/words_alpha.txt"
if vim.fn.filereadable(wordlist) == 1 then
	vim.opt.dictionary:append(wordlist)
end

-- Common typo -> correction. Add your own freely.
local corrections = {
	teh = "the",
	adn = "and",
	recieve = "receive",
	seperate = "separate",
	definately = "definitely",
	occured = "occurred",
	untill = "until",
	wich = "which",
	thier = "their",
	alot = "a lot",
	becuase = "because",
	tommorow = "tomorrow",
	goverment = "government",
	neccessary = "necessary",
	wierd = "weird",
	acheive = "achieve",
	beleive = "believe",
	youre = "you're",
	dont = "don't",
	cant = "can't",
	wont = "won't",
	im = "I'm",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		-- buffer-local insert-mode abbreviations (expand on the next space/punct)
		for wrong, right in pairs(corrections) do
			vim.cmd(string.format("iabbrev <buffer> %s %s", wrong, right))
		end
	end,
})

return {}
