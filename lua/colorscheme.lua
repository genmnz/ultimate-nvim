-- vim.opt.cursorline = true

local c = {
    float_bg = (vim.fn.has("nvim-0.11") == 0 or vim.o.winborder == "none") and "#000000"
        or "#000000",
    windiv_bg = "#3d3d3d",
    function_fg = "#87d7ff",
    function_call_fg = "#ffc1e2", -- function/method CALLS (distinct from declarations)
    title_fg = "#00d7ff",
    normal_fg = "#dadada",
    -- normal_fg = "#5fafff", -- #B0B5B9 gray for normal text, also used for cursor foreground
    error_bg = "#ff0000",
    warn_fg = "#ff7700",
    info_fg = "#a3ff3a",
    hint_fg = "#2bffff",
    numbers_fg = "#ff0000", -- for cursor line number 
    pink = "#ff5f87", -- for keywords and such, also used for cursor line number highlight
    bright_blue = "#5fafff",
    yellowish = "#ffff5f",
    bluish = "#87d7ff",
    sky = "#00ffff",
    black = "#000000"
}

local colors = {
    Normal = { fg = c.normal_fg, bg = c.black },
    Boolean = { fg = "#ff875f" },
    Comment = { fg = "#62628A"}, -- afafff
    Conditional = { fg = "#ffff87" },
    Constant = { fg = "#d7ffd7" },
    Cursor = { fg = c.black, bg = "#5fafff", bold = true },
    CursorColumn = { bg = "#262626" },
    DiffAdd = { fg = c.yellowish, bg = "#005f00" },
    DiffChange = { fg = c.yellowish, bg = "#5f5f00" },
    DiffDelete = { fg = c.yellowish, bg = "#870000" },
    DiffText = { fg = "#ffff00", bg = "#870000" },
    Directory = { fg = "#00afff" },
    Emphasis = { italic = true },
    EndOfBuffer = { fg = "#0000af" },
    Error = { fg = "#ffffff", bg = "#ff0000" },
    Exception = { fg = "#eecc00" },
    Folded = { fg = c.sky, bg = c.windiv_bg },
    Function = { fg = c.function_fg },
    Identifier = { fg = "#5fffd7" },
    Ignore = { fg = "#6c6c6c" },
    Include = { fg = "#ffafff" },
    Keyword = { fg = "#d7ffaf" },
    Label = { fg = "#F85656" },
    Method = { fg = c.function_fg, italic = true },
    FunctionCall = { fg = c.function_call_fg },
    MethodCall = { fg = c.function_call_fg, italic = true },
    MoreMsg = { fg = "#00af87" },
    NonText = { fg = "#545476" }, -- rainbow region
    NormalFloat = { fg = c.normal_fg, bg = c.float_bg },
    Number = { fg = "#ffd7af" },
    Operator = { fg = "#ff8700" },
    Pmenu = { fg = "#b2b2b2", bg = c.float_bg },
    PmenuSbar = { bg = c.windiv_bg },
    PmenuSel = { fg = "#eeeeee", bg = c.float_bg },
    PmenuThumb = { bg = "#767676" },
    PreProc = { fg = "#ff5fff" },
    QuickFixLine = { fg = "#ffffff", bg = "#005f5f" },
    Quote = { fg = "#ffffc0" },
    Repeat = { fg = "#d7ff87" },
    Search = { fg = "#ffffff", bg = "#5f5f00" },
    SignColumn = { fg = c.yellowish, bg = c.windiv_bg },
    Special = { fg = "#ffd75f" },
    SpecialKey = { fg = c.sky },
    SpellBad = { sp = "#ff0000", undercurl = true },
    SpellCap = { sp = c.sky, undercurl = true },
    SpellLocal = { sp = "#00ff00", undercurl = true },
    SpellRare = { sp = "#ff00ff", undercurl = true },
    Statement = { fg = "#ffff00" },
    StatusLine = { fg = c.black, bg = "#4e4e4e" },
    StatusLineNC = { fg = "#838383", bg = "none" },
    LineNr = { bg = c.black },
    CursorLineNr = { fg = c.numbers_fg, bg = "none", bold = true },

    StorageClass = { fg = "#87d75f" },
    String = { fg = "#ffffb9" },
    Strong = { bold = true },
    Structure = { fg = "#5fd7af" }, -- as {{/}}
    TabLineFill = { fg = c.black, bg = "#262626" },
    TabLineSel = { fg = c.black, bg = "#808080" },
    Title = { bold = true, fg = c.title_fg },
    Title2 = { fg = c.title_fg },
    Title3 = { fg = "#00b7df" },
    Title4 = { fg = "#0097bf" },
    Todo = { fg = c.black, bg = "#ffff00" },
    Type = { fg = "#5fd75f" },
    -- Typedef = { fg = "#87d7af" },
    TypeBuilt = { fg = "#f0ded0" },
    Typedef = { fg = "#ffa35c" },
    Underlined = { underline = true },
    Variable = { fg = "#bffce8" },
    -- Visual = { fg = "#a8a8a8", bg = "#3a3a3a" },
    VisualNOS = { bold = true, underline = true },
    WarningMsg = { fg = c.warn_fg },
    WinSeparator = { fg = c.windiv_bg, bg = c.black },
    MiniIndentscopeSymbol = { fg = "#808080" },
    MiniIndentscopePrefix = { fg = "#d7ffaf" },

    -- html
    htmlLink = { underline = true, fg = "#97b7ff" },
    htmlBold = { bold = true },
    htmlBoldItalic = { bold = true, italic = true },
    htmlBoldUnderline = { bold = true, underline = true },
    htmlBoldUnderlineItalic = { bold = true, underline = true, italic = true },
    htmlItalic = { italic = true },
    htmlUnderlineItalic = { underline = true, italic = true },

    -- mail
    mailQuoted1 = { fg = "#00ff87" },
    mailQuoted2 = { fg = "#00ffff" },
    mailQuoted3 = { fg = "#00afff" },
    mailQuoted4 = { fg = "#0087ff" },
    mailQuoted5 = { fg = "#005fff" },
    mailQuoted6 = { fg = "#0000ff" },

    -- diff
    diffAdded = { fg = "#238aff" },
    diffRemoved = { fg = "#ff4c4c" },
    diffFile = { fg = c.bluish },
    diffOldFile = { fg = c.bluish },
    diffNewFile = { fg = c.bluish },
    diffLine = { fg = "#ff00dd" },

    -- gitsigns (left sign column): green added, blue changed, red deleted
    GitSignsAdd = { fg = "#00d75f", bg = "none" },
    GitSignsChange = { fg = c.bright_blue, bg = "none" },
    GitSignsDelete = { fg = "#ff2a2a", bg = "none" },
    GitSignsTopdelete = { fg = "#ff2a2a", bg = "none" },
    GitSignsChangedelete = { fg = c.bright_blue, bg = "none" },
    GitSignsUntracked = { fg = "#4a4a4a", bg = "none" },

    -- Vim help
    helpHyperTextEntry = { fg = "#00afff" },

    -- LSP
    LspReferenceText = { bg = "#446600" },
    LspReferenceRead = { bg = "#004444" },
    LspReferenceWrite = { bg = "#440000" },
    LspReferenceTarget = { bg = "#443300" },
    LspSignatureActiveParameter = { bg = "#007700", bold = true },
    LspInlayHint = { bg = "#3a3a3a", fg = c.hint_fg },
    LspInfoBorder = { fg = "#00ff00", bg = "#ff0000" },
    ComplHint = { fg = c.hint_fg },

    -- diagnostics
    DiagnosticError = { fg = c.error_bg, bg = c.float_bg },
    DiagnosticWarn = { fg = c.warn_fg, bg = c.float_bg },
    DiagnosticInfo = { fg = c.info_fg, bg = c.float_bg },
    DiagnosticHint = { fg = c.hint_fg, bg = c.float_bg },
    DiagnosticVirtualTextInfo = { fg = c.info_fg },
    DiagnosticVirtualTextHint = { fg = c.hint_fg },
    DiagnosticUnderlineError = { undercurl = true, sp = c.error_bg },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn_fg },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info_fg },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint_fg },

    -- Health
    healthError = { fg = "#ff0000" },
    healthSuccess = { fg = "#73daca" },
    healthWarning = { fg = "#d08000" },
}

local link_colors = {
    -- Basic highlight groups
    StatusLineTermNC = colors.StatusLineNC,
    VertSplit = colors.StatusLineNC,
    LineNr = colors.StatusLineNC,
    -- CursorLineNr = colors.StatusLineNC,
    TabLine = colors.StatusLineNC,
    StatusLineTerm = colors.StatusLine,
    Float = colors.Number,
    Character = colors.Number,
    ModeMsg = colors.Normal,
    WildMenu = colors.Todo,
    CursorLine = colors.CursorColumn,
    ColorColumn = colors.CursorColumn,
    Delimiter = colors.Special,
    Conceal = colors.Special,
    IncSearch = colors.Search,
    MatchParen = colors.Search,
    ErrorMsg = colors.Error,
    FoldColumn = colors.Folded,
    Question = colors.Typedef,
    htmlUnderline = colors.Underlined,

    -- More diagnostic groups
    LspCodeLens = colors.Comment,
    DiagnosticUnnecessary = colors.Ignore,
    DiagnosticVirtualTextError = colors.Error,
    DiagnosticVirtualTextWarn = colors.WarningMsg,



    -- Treesitter
    -- From https://github.com/nvim-treesitter/nvim-treesitter/blob/master/
    -- Identifiers
    ["@variable"] = colors.Normal, -- various variable names
    ["@variable.builtin"] = colors.Special, -- built-in variable names (e.g. `this`)
    ["@variable.parameter"] = colors.Variable, -- parameters of a function
    ["@variable.parameter.builtin"] = colors.Comment, -- special parameters (e.g. `_`, `it`)
    ["@variable.member"] = colors.Variable, -- object and struct fields
    ["@constant"] = colors.Constant, -- constant identifiers
    ["@constant.builtin"] = colors.Constant, -- built-in constant values
    ["@constant.macro"] = colors.PreProc, -- constants defined by the preprocessor
    ["@module"] = colors.StorageClass, -- modules or namespaces
    ["@module.builtin"] = colors.Include, -- built-in modules or namespaces
    ["@label"] = colors.Label, -- GOTO and other labels (e.g. `label:` in C), including heredoc labels

    -- Literals
    ["@string"] = colors.String, -- string literals
    ["@string.documentation"] = colors.String, -- string documenting code (e.g. Python docstrings)
    ["@string.regexp"] = colors.Special, -- regular expressions
    ["@string.escape"] = colors.Special, -- escape sequences
    ["@string.special"] = colors.Special, -- other special strings (e.g. dates)
    ["@string.special.symbol"] = colors.Special, -- symbols or atoms
    ["@string.special.url"] = colors.htmlLink, -- URIs (e.g. hyperlinks)
    ["@string.special.path"] = colors.Special, -- filenames
    ["@character"] = colors.Number, -- character literals
    ["@character.special"] = colors.Special, -- special characters (e.g. wildcards)
    ["@boolean"] = colors.Boolean, -- boolean literals
    ["@number"] = colors.Number, -- numeric literals
    ["@number.float"] = colors.Number, -- floating-point number literals

    -- Types
    ["@type"] = colors.Type, -- type or class definitions and annotations
    ["@type.builtin"] = colors.TypeBuilt, -- built-in types
    ["@type.definition"] = colors.Typedef, -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
    ["@attribute"] = colors.Label, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
    ["@attribute.builtin"] = colors.Label, -- builtin annotations (e.g. `@property` in Python)
    ["@property"] = colors.Label, -- the key in key/value pairs

    -- Functions
    ["@function"] = colors.Function, -- function definitions
    ["@function.builtin"] = colors.Function, -- built-in functions
    ["@function.call"] = colors.FunctionCall, -- function calls
    ["@function.macro"] = colors.PreProc, -- preprocessor macros
    ["@function.method"] = colors.Method, -- method definitions
    ["@function.method.call"] = colors.MethodCall, -- method calls
    ["@constructor"] = colors.Structure, -- constructor calls and definitions
    ["@operator"] = colors.Operator, -- symbolic operators (e.g. `+` / `*`)

    -- Keywords
    ["@keyword"] = colors.Keyword, -- keywords not fitting into specific categories
    ["@keyword.coroutine"] = colors.Repeat, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
    ["@keyword.function"] = colors.Keyword, -- the `function`/`def` keyword (distinct from the function name)
    ["@keyword.operator"] = colors.Operator, -- operators that are English words (e.g. `and` / `or`)
    ["@keyword.import"] = colors.Include, -- keywords for including or exporting modules (e.g. `import` / `from` in Python)
    ["@keyword.type"] = colors.Keyword, -- the `class`/`struct`/`enum` keyword (distinct from the type name)
    ["@keyword.modifier"] = colors.Label, -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
    ["@keyword.repeat"] = colors.Repeat, -- keywords related to loops (e.g. `for` / `while`)
    ["@keyword.return"] = colors.Keyword, -- keywords like `return` and `yield`
    ["@keyword.debug"] = colors.Exception, -- keywords related to debugging
    ["@keyword.exception"] = colors.Exception, -- keywords related to exceptions (e.g. `throw` / `catch`)
    ["@keyword.conditional"] = colors.Conditional, -- keywords related to conditionals (e.g. `if` / `else`)
    ["@keyword.conditional.ternary"] = colors.Operator, -- ternary operator (e.g. `?` / `:`)
    ["@keyword.directive"] = colors.Statement, -- various preprocessor directives & shebangs
    ["@keyword.directive.define"] = colors.Statement, -- preprocessor definition directives

    -- Punctuation
    ["@punctuation.delimiter"] = colors.Special, -- delimiters (e.g. `;` / `.` / `,`)
    ["@punctuation.bracket"] = colors.Special, -- brackets (e.g. `()` / `{}` / `[]`)
    ["@punctuation.special"] = colors.Special, -- special symbols (e.g. `{}` in string interpolation)

    -- Comments
    ["@comment"] = colors.Comment, -- line and block comments
    ["@comment.documentation"] = { fg = "#dac0df" }, -- comments documenting code
    ["@comment.error"] = colors.Error, -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
    ["@comment.warning"] = colors.WarningMsg, -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
    ["@comment.todo"] = colors.Todo, -- todo-type comments (e.g. `TODO`, `WIP`)
    ["@comment.note"] = colors.MoreMsg, -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)

    -- Markup - Mainly for markup languages.
    ["@markup.strong"] = colors.Strong, -- bold text
    ["@markup.italic"] = colors.Emphasis, -- italic text
    ["@markup.strikethrough"] = { strikethrough = true }, -- struck-through text
    ["@markup.underline"] = colors.Underlined, -- underlined text (only for literal underline markup!)
    ["@markup.heading"] = colors.Title, -- headings, titles (including markers)
    ["@markup.heading.1"] = colors.Title, -- top-level heading
    ["@markup.heading.2"] = colors.Title2, -- section heading
    ["@markup.heading.3"] = colors.Title3, -- subsection heading
    ["@markup.heading.4"] = colors.Title4, -- and so on
    ["@markup.heading.5"] = colors.Title4, -- and so forth
    ["@markup.heading.6"] = colors.Title4, -- six levels ought to be enough for anybody
    ["@markup.quote"] = colors.Quote, -- block quotes
    ["@markup.math"] = colors.Special, -- math environments (e.g. `$ ... $` in LaTeX)
    ["@markup.link"] = colors.htmlLink, -- text references, footnotes, citations, etc.
    ["@markup.link.label"] = colors.Label, -- link, reference descriptions
    ["@markup.link.url"] = colors.htmlLink, -- URL-style links
    ["@markup.raw"] = colors.String, -- literal or verbatim text (e.g. inline code)
    ["@markup.raw.block"] = colors.String, -- literal or verbatim text as a stand-alone block
    ["@markup.list"] = colors.StorageClass, -- list markers
    ["@markup.list.checked"] = colors.MoreMsg, -- checked todo-style list markers
    ["@markup.list.unchecked"] = colors.WarningMsg, -- unchecked todo-style list markers
    ["@diff.plus"] = colors.diffAdded, -- added text (for diff files)
    ["@diff.minus"] = colors.diffRemoved, -- deleted text (for diff files)
    ["@diff.delta"] = colors.diffLine, -- changed text (for diff files)
    ["@tag"] = colors.Label, -- XML-style tag names (and similar)
    ["@tag.builtin"] = colors.Label, -- builtin tag names (e.g. HTML5 tags)
    ["@tag.attribute"] = colors.Label, -- XML-style tag attributes
    ["@tag.delimiter"] = colors.Special, -- XML-style tag delimiters

    wdiffOld = colors.diffRemoved,
    wdiffNew = colors.diffAdded,


}

local M = {}

M.load = function()
    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name then vim.cmd("hi clear") end
    vim.o.termguicolors = true
    vim.g.colors_name = "southernlights"

    for k, v in pairs(colors) do
        vim.api.nvim_set_hl(0, k, v)
    end
    for k, v in pairs(link_colors) do
        vim.api.nvim_set_hl(0, k, v)
    end

    -- Let listeners (e.g. the markdown theme in lua/md.lua) re-apply their
    -- overrides after the base theme is (re)loaded, including on :ReloadTheme.
    vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "southernlights", modeline = false })
end

return M
