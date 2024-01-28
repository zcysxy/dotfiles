---@diagnostic disable: undefined-global


--[[ local MATH_MODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

-- TS isn't updating the syntax tree on edit
local ts_utils = require("nvim-treesitter.ts_utils")
local in_math = function()
    local cur = ts_utils.get_node_at_cursor()
    while cur do
        if MATH_MODES[cur:type()] then
            return true
        end
        cur = cur:parent()
    end
    return false
end ]]

local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_align = function()
  return vim.fn["vimtex#env#is_inside"]("align")[1] ~= 0
end

local ls = require("luasnip")

local decorator = {
  wordTrig = false,
  condition = in_mathzone,
}
local rsdecorator = {
  wordTrig = false,
  condition = in_mathzone,
  trigEngine = "ecma",
  snippetType = "snippet",
}

local ps = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) -- parse snippet
local s = ls.extend_decorator.apply(ls.snippet, decorator)
local rsps = ls.extend_decorator.apply(ls.parser.parse_snippet, rsdecorator)


--[[
  Snippets
--]]

-- Greek letters
local GREEK_LETTERS = {
  a = "alpha",
  b = "beta",
  c = "chi",
  C = "Chi",
  d = "delta",
  D = "Delta",
  e = "epsilon",
  g = "gamma",
  G = "Gamma",
  i = "iota",
  k = "kappa",
  l = "lambda",
  L = "Lambda",
  m = "mu",
  n = "nu",
  o = "omega",
  O = "Omega",
  p = "phi",
  P = "Phi",
  r = "rho",
  s = "sigma",
  S = "Sigma",
  t = "theta",
  T = "Theta",
  x = "xi",
  X = "Xi",
  z = "zeta"
}
local GREEK_COMMANDs =
"(alpha|beta|[cC]hi|[dD]elta|epsilon|eta|[gG]amma|iota|kappa|[lL]ambda|mu|nu|[oO]mega|[pP]hi|[Pp]i|[rR]ho|[sS]igma|[tT]heta|tau|Xi)"
local greek = {
  s({ trig = "[;@](%a)", regTrig = true, }, {
    f(function(_, snip)
      if GREEK_LETTERS[snip.captures[1]] then
        return "\\" .. GREEK_LETTERS[snip.captures[1]]
      end
      return snip.trigger
    end),
  }),
}

-- Commands
local COMMANDS = "(sin|cos|tan|log|ln|exp|ell|nabla|max|sup)"
local commands = {
  s({ trig = "(?<!\\\\)" .. COMMANDS, trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\" .. snip.captures[1]
    end),
  }),
  s({ trig = "(?<!\\\\)" .. GREEK_COMMANDs, trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\" .. snip.captures[1]
    end),
  }),

  ps({ trig = "lab", name = "label", snippetType = "snippet" }, "\\label{${1:eq}:$2}$0"),
}

-- Subscripts
local subscripts = {
  ps({ trig = "td", name = "subscript" }, "_{$1}$0 "),
  ps({ trig = "__", name = "subscript" }, "_{$1}$0 "),
  s(
    { trig = "(%a)(%d)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "_" .. snip.captures[2]
    end)
  ),
  s(
    { trig = "(%a_)(%d+)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "{" .. snip.captures[2] .. "}"
    end)
  ),
  s(
    { trig = "([ijkdtn])\\1", name = "letter subscript", trigEngine = "ecma" },
    f(function(_, snip)
      return "_" .. snip.captures[1]
    end)
  )
}

-- Superscripts
local superscripts = {
  ps({ trig = "tp", name = "superscript" }, "^{$1}$0 "),
  ps({ trig = "^^", name = "superscript" }, "^{$1}$0 "),
  ps({ trig = "^-", name = "negative sup" }, "^{-$1}$0 "),
  ps({ trig = "rd", name = "superscript" }, "^{($1)}$0 "),
  s(
    { trig = "(%a^)(%d+)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "{" .. snip.captures[2] .. "}"
    end)
  ),
  ps({ trig = "sq", name = "squre" }, "^{2}"),
  ps({ trig = "(?<=[\\w\\d^_]+)inv", name = "inverse", trigEngine = "ecma" }, "^{-1}$0 "),
  ps({ trig = "TT", name = "transpose" }, "^{T}"),
  ps({ trig = "dag", name = "dagger" }, "^\\dagger"),
}

-- Relations
local relations = {
  s({ trig = "<=" }, t("\\le")),
  s({ trig = ">=" }, t("\\geq")),
  s({ trig = "=== " }, t("\\equiv ")),
  s({ trig = ":=" }, t("\\coloneqq")),
  s({ trig = "~=" }, t("\\cong")),
  s({ trig = "(!=|<>)", trigEngine = "ecma" }, t("\\neq")),
  s({ trig = "(sim|~~)", trigEngine = "ecma" }, t("\\sim")),
  s({ trig = "=>" }, t("\\implies")),
  s({ trig = "->" }, t("\\to")),
  s({ trig = "|>", wordTrig = false, priority = 2000 }, t("\\mapsto")),
  s({ trig = "==>", wordTrig = false, priority = 2000 }, t("\\Rightarrow")),
  s({ trig = "===>", wordTrig = false, priority = 3000 }, t("\\Longrightarrow")),
  -- iff
  ps({ trig = "iff" }, "\\iff"),
  ps({ trig = "subs", name = "subset" }, "\\subset "),
  ps({ trig = "sups", name = "subset equal" }, "\\supset "),
  ps({ trig = "\\\\\\", name = "set minues" }, "\\setminus "),
  ps({ trig = "<<" }, "\\ll "),
  ps({ trig = ">>" }, "\\gg "),
}

-- Symbols
local symbols = {
  ps({trig = "xx"}, "\\times "),
  ps({trig = "ox"}, "\\otimes "),
  ps({trig = "o+"}, "\\oplus "),
  ps({trig = "**"}, "\\cdot "),
  ps({trig = "..."}, "\\dots"),
  ps({trig = "ooo"}, "\\infty"),
}

-- Operations
local operations = {
  ps({trig = "binom"}, "\\binom{$1}{$2}$0"),
  ps({trig = "sr"}, "\\sqrt{$1}$0"),
  s(".b", t("\\dotsb")),
  s(".c", t("\\dotsc")),
}


-- Math fonts
local MATHBB_LETTERS = "(R|N|Z|Q|C|E)"
local math_fonts = {
  ps({ trig = "mbb", name = "blackboard" }, "\\mathbb{$1}$0"),
  ps({ trig = "mrm", name = "roman" }, "\\mathrm{$1}$0"),
  ps({ trig = "mcal", name = "calligraphy" }, "\\mathcal{$1}$0"),
  ps({ trig = "mscr", name = "script" }, "\\mathscr{$1}$0"),
  s({ trig = "(?<!\\\\)" .. MATHBB_LETTERS .. "\\1", trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\mathbb{" .. snip.captures[1] .. "}"
    end),
  }),
  ps({ trig = "11", name = "indicator" }, "\\mathbbm{1}"),
  s(
    { trig = "\\b([A-Z])cal", name = "calligraphy", trigEngine = "ecma" }, {
      f(function(_, snip)
        return "\\mathcal{" .. snip.captures[1] .. "}"
      end)
    }),
  s(
    { trig = "\\b(\\w*)rm", name = "roman", trigEngine = "ecma" }, {
      f(function(_, snip)
        return "\\mathrm{" .. snip.captures[1] .. "}"
      end)
    }),
  s(
    { trig = "\\b(\\w*)opn", name = "operatorname", trigEngine = "ecma" }, {
      f(function(_, snip)
        return "\\operatorname{" .. snip.captures[1] .. "}"
      end)
    }),
  -- Math text
  ps({ trig = "ftt", snippetType = "snippet", priority = 2000 }, "\\texttt{$1}$0"),
  ps({ trig = "te", snippetType = "snippet" }, "\\text{$1}$0"),
}

-- Surroundings
local surroundings = {
  ps({trig = "set"}, "\\left\\{ $1 \\right\\\\}$0"),
  ps({trig = "tup"}, "\\tup{ $1 }$0"),
  ps({trig = "norm"}, "\\norm{ $1 }$0"),
  ps({trig = "abs"}, "\\abs{ $1 }$0"),
  ps({trig = "bracket"}, "\\bracket{$1}{$2}$0"),
  ps({trig = "ket"}, "\\ket{$1}$0"),
  ps({trig = "floor"}, "\\left\\lfloor $1 \\right\\rfloor$0"),
  ps({trig = "ceil"}, "\\left\\lceil $1 \\right\\rceil$0"),
  ps({trig = "paren"}, "\\paren{ $1 }$0"),
  ps({trig = "vec"}, "\\vec{ $1 }$0"),
  s(
    { trig = "(lr|@|;)(\\(|\\[|<|\\||\\\\\\||\\{)", trigEngine = "ecma", name = "Big parens" },
    d(1, function(_, snip)
      local left = snip.captures[2]
      local right = ""
      if left == "|" then
        right = "|"
      elseif left == "<" then
        right = ">"
      elseif left == "\\|" then
        right = "\\|"
      elseif left == "{" then
        left = "\\{"
        right = "\\"
      end

      return sn(
        1,
        fmt([[\left{} {} \right{}]], { t(left), i(1), t(right) })
      )
    end)
  ),
  s({ trig = "(\\(|\\||\\\\\\||\\[|\\{|<)", trigEngine = "ecma", name = "visual parens" }, {
    d(1, function(_, snip)
      local left = snip.captures[1]
      local right = ""
      if left == "|" then
        right = "|"
      elseif left == "<" then
        right = ">"
      elseif left == "\\|" then
        right = "\\|"
      elseif left == "{" then
        left = "\\{"
        right = "\\"
      end
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\left" .. left .. " " .. snip.env.TM_SELECTED_TEXT[1] .. " \\right" .. right),
        })
      end
      return sn(nil, t(snip.captures[1]))
    end),
  }),
}


-- Decorations
local decorations = {
  s({ trig = "(\\?[%a%d^_]+)hat", regTrig = true }, {
    f(function(_, snip)
      return "\\hat{" .. snip.captures[1] .. "}"
    end),
  }),
  s({ trig = "hat" }, { t("\\hat{"), i(1), t("}"), }),
  s({ trig = "(\\?%a+)bar", regTrig = true }, {
    f(function(_, snip)
      return "\\bar{" .. snip.captures[1] .. "}"
    end),
  }),
  s({ trig = "bar" }, { t("\\bar{"), i(1), t("}"), }),
  s({ trig = "(\\?%a+)Bar", regTrig = true }, {
    f(function(_, snip)
      return "\\overline{" .. snip.captures[1] .. "}"
    end),
  }),
  s({ trig = "Bar" }, { t("\\overline{"), i(1), t("}"), }),
  -- tilde
  s({ trig = "(\\?%a+)([tT])il", regTrig = true }, {
    f(function(_, snip)
      local tilde = "\\tilde{"
      if snip.captures[2] == "T" then
        tilde = "\\widetilde{"
      end
      return tilde .. snip.captures[1] .. "}"
    end),
  }),
  s({ trig = "([tT])il", regTrig = true }, {
    f(function(_, snip)
      local tilde = "\\tilde{"
      if snip.captures[1] == "T" then
        tilde = "\\widetilde{"
      end
      return tilde
    end),
    i(1),
    t("}"),
  }),
}

-- In align
local align = {
  s(
    { trig = "([^&])=", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "&="
    end), { condition = in_align }
  ),
}

-- Expressions
local expressions = {
  rsps({ trig = "\\\\?sum" }, "\\sum_{${1:n=1}}^{${2:\\infity}}$0"),
  rsps({ trig = "\\\\?prod" }, "\\prod_{${1:n=1}}^{${2:\\infity}}$0"),
  rsps({ trig = "\\\\?cup" }, "\\bigcup_{${1:n=1}}^{${2:\\infity}}$0"),
  rsps({ trig = "\\\\?cap" }, "\\bigcap_{${1:n=1}}^{${2:\\infity}}$0"),
  rsps({ trig = "\\\\?lim" }, "\\lim_{${1:n} \\to ${2:\\infity}}$0"),
  rsps({ trig = "\\\\?limsup" }, "\\limsup_{${1:n} \\to ${2:\\infity}}$0"),
  rsps({ trig = "\\\\?int" }, "\\int_{${1:0}}^{${2:\\infity}} $0 \\, \\mathrm{d}${3:x}"),
  s({ trig = "(%w):", name = "functions", regTrig = true }, {
    d(1, function(_, snip)
      return sn(1, {
        t(snip.captures[1] .. "\\colon "),
        i(1, "\\R"),
        t("\\to "),
        i(2, "\\R"),
      })
    end),
  }),
}

-- Derivatives and fractions
local fractions = {
  s({ trig = "part" }, {
    t("\\frac{\\partial "),
    i(1, " "),
    t("}{\\partial "),
    i(2, "x"),
    t("}"),
  }),
  s({ trig = "diff", wordTrig = false, priority = 2000 }, {
    t("\\frac{\\mathrm{d} "),
    i(1, " "),
    t("}{\\mathrm{d} "),
    i(2, "x"),
    t("}"),
  }),
  s("//", {
    d(1, function(_, snip)
      return sn(1, {
        t("\\frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}"),
      })
    end, {}),
  }),
  -- Parenthesis-delimited fractions
  s({ trig = "(%b())/", regTrig = true }, {
    d(1, function(_, snip)
      return sn(
        1,
        fmt(
          [[
                    \frac{{{}}}{{{}}}
                ]],
          {
            t(string.sub(snip.captures[1], 2, #snip.captures[1] - 1)),
            i(1),
          }
        )
      )
    end, {}),
  }),
  -- TODO: Make more generalized
  -- Brace-delimited fractions pt. 1
  s({ trig = "(\\frac%b{}%b{})/", regTrig = true }, {
    d(1, function(_, snip)
      return sn(
        1,
        fmt(
          [[
                    \frac{{{}}}{{{}}}
                ]],
          {
            t(snip.captures[1]),
            i(1),
          }
        )
      )
    end, {}),
  }),
  -- Brace-delimited fractions pt. 2
  s({ trig = "(\\%a+%b{})/", regTrig = true }, {
    d(1, function(_, snip)
      return sn(
        1,
        fmt(
          [[
                    \frac{{{}}}{{{}}}
                ]],
          {
            t(snip.captures[1]),
            i(1),
          }
        )
      )
    end, {}),
  }),
  -- Regexp fractions
  s({ trig = "([%a%d^_\\!'.]+)/", regTrig = true }, {
    d(1, function(_, snip)
      return sn(1, {
        t("\\frac{"),
        t(snip.captures[1]),
        t("}{"),
        i(1),
        t("}"),
      })
    end, {}),
  }),
  -- Visual fractions
  s("/", {
    d(1, function(_, snip)
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\frac{" .. snip.env.TM_SELECTED_TEXT[1] .. "}{"),
          i(1),
          t("}"),
        })
      end
      return sn(nil, t("/"))
    end),
  }),
}

-- Visuals
local visuals = {
  s({ trig = "UU", name = "underbrace", snippetType = "snippet" }, {
    d(1, function(_, snip)
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\underbrace{" .. snip.env.TM_SELECTED_TEXT[1] .. "}_{"),
          i(1),
          t("}"),
        })
      end
      return sn(nil, t("U"))
    end),
  }),
  s({ trig = "U", name = "underset", snippetType = "snippet" }, {
    d(1, function(_, snip)
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\underset{"),
          i(1),
          t("}{" .. snip.env.TM_SELECTED_TEXT[1] .. "}"),
        })
      end
      return sn(nil, t("U"))
    end),
  }),
  s({ trig = "OO", name = "overbrace", snippetType = "snippet" }, {
    d(1, function(_, snip)
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\overbrace{" .. snip.env.TM_SELECTED_TEXT[1] .. "}^{"),
          i(1),
          t("}"),
        })
      end
      return sn(nil, t("O"))
    end),
  }),
  s({ trig = "O", name = "overset", snippetType = "snippet" }, {
    d(1, function(_, snip)
      if snip.env.TM_SELECTED_TEXT[1] then
        return sn(1, {
          t("\\overset{"),
          i(1),
          t("}{" .. snip.env.TM_SELECTED_TEXT[1] .. "}"),
        })
      end
      return sn(nil, t("O"))
    end),
  }),
}

M = {}
vim.list_extend(M, greek)
vim.list_extend(M, commands)
vim.list_extend(M, subscripts)
vim.list_extend(M, superscripts)
vim.list_extend(M, relations)
vim.list_extend(M, symbols)
vim.list_extend(M, operations)
vim.list_extend(M, math_fonts)
vim.list_extend(M, surroundings)
vim.list_extend(M, decorations)
vim.list_extend(M, align)
vim.list_extend(M, expressions)
vim.list_extend(M, fractions)
vim.list_extend(M, visuals)

return nil, M
