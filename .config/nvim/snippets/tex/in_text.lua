---@diagnostic disable: undefined-global

local in_comment = function()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
  return not in_mathzone() and not in_comment()
end

local ls = require("luasnip")
local snippet_events = require('luasnip.util.events')
-- local utils = require("util.utils")
local remove_auto_close_char = function(snippet)
  local char_list = '[%)%]}>"\']'
  local line_index = snippet.mark:pos_end()[1]
  local character_index = snippet.mark:pos_end()[2] + 1
  local line_content = vim.api.nvim_buf_get_lines(
    0, line_index, line_index + 1, false
  )[1]
  local character = line_content:sub(character_index, character_index)

  if character:find(char_list) and true or false then
    vim.api.nvim_buf_set_text(
      0, line_index, character_index - 1, line_index, character_index, { '' }
    )
  end
end

local remove_auto_close_char_callback = {
  [-1] = {
    -- [snippet_events.enter] = utils.remove_auto_close_char,
    [snippet_events.enter] = remove_auto_close_char,
  },
}

local decorator = {
  condition = in_text,
  wordTrig = false,
}
local snippet_decorator = {
  snippetType = "snippet",
}
vim.tbl_extend("keep", snippet_decorator, decorator)

local ps = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) -- parse snippet
local s = ls.extend_decorator.apply(ls.snippet, decorator)
local ss = ls.extend_decorator.apply(ls.snippet, snippet_decorator)
local sps = ls.extend_decorator.apply(ls.parser.parse_snippet, snippet_decorator)


--[[
  Snippets
--]]

-- Sections
local sections = {
  ss({ trig = "sec", name = "section" }, {
    c(1, {
      t("\\section{"),
      t("\\section*{"),
    }),
    i(0),
    t("}"),
  }),
  ss({ trig = "ssec", name = "subsection" }, {
    c(1, {
      t("\\subsection{"),
      t("\\subsection*{"),
    }),
    i(0),
    t("}"),
  }),
  ss({ trig = "sssec", name = "subsubsection" }, {
    c(1, {
      t("\\subsubsection{"),
      t("\\subsubsection*{"),
    }),
    i(0),
    t("}"),
  }),
  sps({ trig = "para", name = "paragraph" }, "\\paragraph{${1}}$0"),
}

-- Math modes
local math_modes = {
  ps({ trig = "\\bmk", trigEngine = "ecma", }, "$$1$$0"),
  -- LaTeX: Display math mode
  ps({ trig = "(?<=^\\s*)dm", trigEngine = "ecma", }, "\\[\n  $1\n.\\]$0"),
}

-- Text decorations
local text_decorations = {
  ps( { trig = "emph", name = "emphasis", snippetType = "snippet" }, "\\emph{${1}}$0"),
  ps( { trig = "**", name = "emphasis", snippetType = "snippet" }, "\\emph{${1}}$0"),
  sps( { trig = "fbf", name = "boldface" }, "\\textbf{${1}}$0"),
  ps( { trig = "__", name = "boldface" }, "\\textbf{${1}}$0"),
  sps({ trig = "fit", name = "italic" }, "\\textit{${1}}$0"),
  sps( { trig = "ftt", name = "teletype" }, "\\texttt{${1}}$0"),
}

-- Citations
local citations = {
  ps({ trig = "@@", name = "cite" }, "\\cite{${1}}$0"),
  ps({ trig = "@p", name = "paren cite" }, "\\citep{${1}}$0"),
  ps({ trig = "@t", name = "text cite" }, "\\citet{${1}}$0"),

}

-- Other
local other = {
  s(
    { trig = " ([b-hj-zB-HJ-Z])([%p%s])", regTrig = true, wordTrig = false },
    f(function(_, snip)
      return " $" .. snip.captures[1] .. "$" .. snip.captures[2]
    end)
  ),
  s(
    { trig = '"', name = "quotation" },
    { t("``"), i(1), t("''") },
    { callbacks = remove_auto_close_char_callback }
  ),
  s({ trig = "([%d$])th", name = "ordinal nth", regTrig = true, wordTrig = false }, {
    f(function(_, snip)
      return snip.captures[1] .. "\\tsup{th}"
    end),
  }),
  ss({ trig = "img", name = "image" }, {
    t({ "\\begin{center}", "\t\\resizebox{" }),
    i(1, "5"),
    t("in}{!}{\\includegraphics{./"),
    i(2),
    t({ "}}", "\\end{center}" }),
  }),
}

local M = {}
vim.list_extend(M, sections)
vim.list_extend(M, math_modes)
vim.list_extend(M, text_decorations)
vim.list_extend(M, citations)
vim.list_extend(M, other)

return nil, M
