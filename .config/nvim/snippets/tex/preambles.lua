---@diagnostic disable: undefined-global

local in_text = function()
    return not in_mathzone() and not in_comment()
end

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    -- Checks if the current line consists of whitespace and then the snippet
    -- TODO: Fix limitation that the snippet cannot contain whitespace itself
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

local ls = require("luasnip")
local ps = ls.extend_decorator.apply(ls.parser.parse_snippet)

return {
    ps({ trig = "pac", name = "package", snippetType = "snippet" }, "\\usepackage{${1}}$0"),
    -- LaTeX: Assignment preamble
    s(
        { trig = "article", name = "article template", snippetType = "snippet"},
        fmt(
            [[
            \documentclass{{article}}
            \usepackage{{mytex}}

            \title{{{}}}
            \author{{{}}}
            \date{{}}

            \begin{{document}}
              \maketitle

              {}
            \end{{document}}
        ]],
            {
                i(1, "Title"),
                i(2, "Author"),
                i(0),
            }
        ),
        { condition = in_text and begins_line }
    ),
    -- LaTeX: Table of contents
    s("toc", {
        t({ "\\tableofcontents", "\\newpage", "" }),
    }, { condition = in_text and begins_line }),
    -- LaTeX: Notes preamble
    s(
        "notes",
        fmt(
            [[
            \documentclass[class=article, crop=false]{{standalone}}
            \input{{../../Preamble}}

            \fancyhf{{}}
            \lhead{{Kyle Chui}}
            \rhead{{Page \thepage}}
            \pagestyle{{fancy}}

            \begin{{document}}
              {}
            \end{{document}}
        ]],
            {
                i(0),
            }
        ),
        { condition = in_text and begins_line }
    ),
},
    nil
