# Neovim Manual (offline copy)

These `.txt` files are Neovim's built-in help (vimdoc format), copied from
`~/scoop/apps/neovim/current/share/nvim/runtime/doc/`. They are plain text —
open any of them directly, or better, read them *inside* Neovim where tags and
links are highlighted and clickable.

---

## Reading help INSIDE Neovim (recommended — always in sync, hyperlinked)

| Command | What it does |
|---|---|
| `:help` | Open the main help table of contents |
| `:help <topic>` | Jump to a topic, e.g. `:help guicursor` |
| `:help 'option'` | Help for an **option** (quotes), e.g. `:help 'number'` |
| `:help i_CTRL-W` | Help for a key in **insert mode** (`i_` prefix) |
| `:help v_o` | Help for a key in **visual mode** (`v_` prefix) |
| `:help :w` | Help for an **ex command** (`:` prefix) |
| `:help fnamemodify()` | Help for a **function** (parentheses) |
| `<C-]>` | Follow the `|tag|` under the cursor (jump to link) |
| `<C-t>` or `<C-o>` | Jump back |
| `:q` | Close the help window |

### Searching across the WHOLE manual
| Command | What it does |
|---|---|
| `:helpgrep <pattern>` | Full-text search every help file (regex). e.g. `:helpgrep cursor shape` |
| `:cnext` / `:cprev` | Move to next / previous match |
| `:copen` | Open the quickfix list of all matches |
| `<Tab>` after `:help wor` | Auto-complete help tags (cycles through matches) |
| `:help <topic>` then `<C-d>` | List all tags matching what you've typed |

In **this repo** you also have fzf-lua wired up: `:FzfLua help_tags` (or your
`<leader>fh`) gives you a fuzzy-searchable picker over every help tag.

### Tip: open these offline files as proper help
```vim
:set filetype=help
```
on any of the `.txt` files here turns on the help highlighting/links.

---

## Most useful files to peek into

| File | Topic |
|---|---|
| `quickref.txt` | One-page cheat sheet of the most common commands |
| `usr_toc.txt` | Table of contents of the **User Manual** (tutorial-style, `usr_01`–`usr_45`) |
| `index.txt` | Every default key mapping, grouped by mode |
| `options.txt` | Every `:set` option explained |
| `motion.txt` | Moving the cursor (`w`, `b`, `}`, `f`, text objects) |
| `change.txt` | Editing/changing text (`d`, `c`, `y`, registers) |
| `pattern.txt` | Search patterns / regex |
| `map.txt` | Defining your own keymaps |
| `autocmd.txt` | Autocommands (run code on events) |
| `lua.txt` | Lua API (`vim.*`) — config in this repo is all Lua |
| `lua-guide.txt` | Friendly intro to configuring Neovim in Lua |
| `vim_diff.txt` | How Neovim differs from Vim |
| `lsp.txt` | Built-in LSP client |
| `treesitter.txt` | Treesitter (highlighting/folding) |

### Learning path (the User Manual)
Read these in order for a guided tour — `:help usr_01` and onward, or open the
files directly:
`usr_01.txt` (about the manuals) → `usr_02.txt` (the basics) →
`usr_03.txt` (moving around) → `usr_04.txt` (making small changes) → … →
`usr_45.txt`. The full list is in `usr_toc.txt`.

---

## Searching this folder from the shell
```sh
# find which help file covers a topic
grep -ril "guicursor" docs/nvim-help/

# read it in your pager
less docs/nvim-help/options.txt
```
