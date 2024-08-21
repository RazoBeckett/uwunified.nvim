local api = vim.api
local colors = require("palette")

local M = {}

M.stylings = {
    i = 'italic',
    italic = 'italic',
    b = 'bold',
    bold = 'bold',
    bi = 'bold,italic',
    bold_italic = 'bold,italic',
    underline = 'underline',
    u = 'underline',
    reverse = 'reverse',
    r = 'reverse',
    rb = 'reverse,bold',
}

function M.highlight(group, style)
    local gui = style.gui and 'gui=' .. style.gui or 'gui=NONE'
    local fg = style.fg and 'guifg=' .. style.fg or 'guifg=NONE'
    local bg = style.bg and 'guibg=' .. style.bg or 'guibg=NONE'
    local sp = style.sp and 'guisp=' .. style.sp or ''
    api.nvim_command('hi ' .. group .. ' ' .. gui .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
    if (style.link) then
        vim.cmd(string.format('highlight! link %s %s', group, style.link))
    end
end

function M.load_colors()
    local styles = M.stylings
    local syntax = {
        -- UI Elements
        LineNr = { fg = colors.blue1 },
        CursorLine = { bg = colors.cursorline },
        CursorLineNr = { fg = colors.rainbow[6] },
        Visual = { fg = colors.none, bg = colors.bg_visual },
        WinSeparator = { fg = colors.border, bg = colors.none },
        SignColumn = { fg = colors.fg_gutter },
        ColorColumn = { bg = colors.bg_highlight },
        CursorColumn = { bg = colors.bg_highlight },
        PmenuSel = { bg = colors.bg_search },
        Cursor = { fg = colors.bg, bg = colors.fg },
        IncSearch = { fg = colors.bg, bg = colors.orange },
        MatchParen = { fg = colors.fg, bg = colors.bg_visual, gui = styles.underline },
        Pmenu = { fg = colors.fg, bg = colors.bg_float },
        Search = { fg = colors.bg, bg = colors.blue },
        DiffAdd = { fg = colors.none, bg = colors.diff.add },
        DiffChange = { fg = colors.none, bg = colors.diff.change },
        DiffDelete = { fg = colors.red },
        DiffText = { fg = colors.none, bg = colors.diff.text },
        ErrorMsg = { fg = colors.bg, bg = colors.red },
        WarningMsg = { fg = colors.bg, bg = colors.yellow },
        StatusLine = { fg = colors.fg, bg = colors.fg_gutter },
        -- Text types
        Constant = { fg = colors.cyan },
        Boolean = { link = "Constant" },
        Character = { link = "Constant" },
        Float = { link = "Constant" },
        Number = { link = "Constant" },
        String = { fg = colors.green1 },
        Function = { fg = colors.blue },
        Comment = { fg = colors.white3, gui = styles.italic },
        NonText = { fg = colors.dark3 },
        Normal = { fg = colors.fg, bg = colors.bg },
        Conditional = { fg = colors.blue, gui = styles.bold },
        Define = { fg = colors.purple },
        Directory = { fg = colors.blue },
        Folded = { fg = colors.comment, bg = colors.bg_highlight },
        Identifier = { fg = colors.orange },
        Keyword = { fg = colors.magenta },
        Label = { fg = colors.orange },
        Operator = { fg = colors.orange },
        PreProc = { fg = colors.purple },
        SpecialComment = { fg = colors.comment },
        Special = { fg = colors.teal },
        SpecialKey = { fg = colors.bg_visual },
        Statement = { fg = colors.red },
        StorageClass = { fg = colors.teal },
        Tag = { fg = colors.yellow },
        Title = { fg = colors.fg_dark, gui = styles.bold },
        Todo = { fg = colors.bg, bg = colors.todo },
        Type = { fg = colors.yellow },
        Underlined = { fg = colors.fg, gui = styles.underline },
        Whitespace = { fg = colors.bg },
        -- Diagnostics
        DiagnosticError = { fg = colors.red, bg = colors.bg_float },
        DiagnosticHint = { fg = colors.cyan, bg = colors.bg_float },
        DiagnosticInfo = { fg = colors.blue, bg = colors.bg_float },
        DiagnosticWarn = { fg = colors.yellow, bg = colors.bg_float },
        DiagnosticUnnecessary = { fg = colors.comment, gui = styles.underline },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignHint = { link = "DiagnosticHint" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticVirtualTextError = { fg = colors.red },
        DiagnosticVirtualTextHint = { fg = colors.cyan },
        DiagnosticVirtualTextInfo = { fg = colors.blue },
        DiagnosticVirtualTextWarn = { fg = colors.yellow },

        -- Plugin Support
        -- Git Gutter
        GitGutterAdd = { fg = colors.git.add },
        GitGutterChange = { fg = colors.git.change },
        GitGutterDelete = { fg = colors.git.delete },
        GitSignsCurrentLineBlame = { fg = colors.comment },
        fugitiveStagedSection = { fg = colors.teal },
        fugitiveUnstagedSection = { fg = colors.red },
        diffOldFile = { fg = colors.orange },
        diffNewFile = { fg = colors.green },
        diffAdded = { link = "DiffAdd" },
        diffRemoved = { fg = colors.red },
        gitDiff = { fg = colors.dark5 },
        GitSignsAdd = { link = "GitGutterAdd" },
        GitSignsChange = { link = "GitGutterChange" },
        GitSignsDelete = { link = "GitGutterDelete" },

        -- Treesitter syntax highlights
        ["@variable"] = { fg = colors.fg_dark, gui = styles.none },

        ["@attribute.zig"] = { fg = colors.blue },
        ["@type.qualifier"] = { fg = colors.blue1 },
        ["@keyword"] = { link = "Keyword" },
        ["@keyword.return"] = { link = "Keyword", gui = styles.italic },
        ["@keyword.repeat"] = { link = "Keyword" },
        ["@keyword.conditional"] = { link = "Keyword" },
        ["@keyword.exception.zig"] = { link = "Operator" },
        ["@keyword.Function"] = { gui = styles.italic },
        ["@lsp.type.comment.documentation"] = { fg = colors.fg_gutter },
        ["@punctuation"] = { link = "Special" },

        -- Semantic highlights
        ["@lsp.type.operator.zig"] = { link = "Operator" },
        ["@lsp.type.namespace"] = { fg = colors.blue2 },
        ["@lsp.type.property"] = { fg = colors.white2 },
        ["@lsp.type.parameter"] = { fg = colors.green2 },
        ["@lsp.type.variable"] = { fg = colors.blue2, gui = styles.none },
        ["@lsp.type.label"] = { fg = colors.fg_sidebar },
        -- ["@lsp.mod.declaration"] = { gui = styles.italic },
        -- ["@function.call"] = { gui = styles.italic },
        ["@lsp.type.errorTag"] = { link = "Type", gui = styles.bold }
    }

    for group, style in pairs(syntax) do
        M.highlight(group, style)
    end
end

function M.colorscheme()
    vim.o.background = "dark"
    vim.o.termguicolors = true
    M.load_colors()
end

return M
