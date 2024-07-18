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
  return vim.fn["vimtex#env#is_inside"]("align")[1] + vim.fn["vimtex#env#is_inside"]("aligned")[1] ~= 0
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local ls = require("luasnip")
local snippet_events = require('luasnip.util.events')
-- local utils = require("snippets.util.utils")

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
    [snippet_events.enter] = remove_auto_close_char,
  },
}

local get_env = function(name, close)
  close = close or ""
  return fmt([[
    \begin{<>}
      <><>
    <>\end{<>}
  ]],
    { name, f(function(args, snip)
      local res, env = {}, snip.env
      for _, val in ipairs(env.LS_SELECT_RAW) do table.insert(res, val) end
      return res
    end, {}), i(0), close, name },
    { delimiters = '<>' })
end

local decorator = {
  wordTrig = false,
  condition = in_mathzone,
}
local ams_decorator = vim.tbl_extend("force", decorator, { condition = in_mathzone and in_align })
local rsdecorator = {
  wordTrig = false,
  condition = in_mathzone,
  trigEngine = "ecma",
  snippetType = "snippet",
}

local ps = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) -- parse snippet
local ms = ls.extend_decorator.apply(ls.snippet, decorator)
local ams = ls.extend_decorator.apply(ls.snippet, ams_decorator)
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
"(alpha|beta|[cC]hi|[dD]elta|epsilon|eta|[gG]amma|iota|kappa|[lL]ambda|mu|nu|[oO]mega|[pP]hi|[Pp]i|[Pp]si|[rR]ho|[sS]igma|[tT]heta|tau|Xi)"
local greek = {
  ms({ trig = "[;@](%a)", regTrig = true, }, {
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
  ms({ trig = "(?<!\\\\)" .. COMMANDS, trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\" .. snip.captures[1]
    end),
  }),
  ms({ trig = "(?<!\\\\)" .. GREEK_COMMANDs, trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\" .. snip.captures[1]
    end),
  }),

  ps({ trig = "lab", name = "label", snippetType = "snippet" }, "\\label{${1:eq}:$2}$0"),
}

-- Subscripts
local subscripts = {
  ps({ trig = "td", name = "subscript" }, "_{$1}$0"),
  ps({ trig = "__", name = "subscript" }, "_{$1}$0"),
  ms(
    { trig = "(%a)(%d)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "_" .. snip.captures[2]
    end)
  ),
  ms(
    { trig = "(%a_)(%d+)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "{" .. snip.captures[2] .. "}"
    end)
  ),
  ms(
    { trig = "(?<!\\\\)([ijkdtn])\\1", name = "letter subscript", trigEngine = "ecma" },
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
  ms(
    { trig = "(%a^)(%d+)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "{" .. snip.captures[2] .. "}"
    end)
  ),
  ps({ trig = "sq", name = "squre" }, "^{2}"),
  ps({ trig = "(?<=[\\w\\d^_]+)inv", name = "inverse", trigEngine = "ecma" }, "^{-1}$0 "),
  ps({ trig = "TT", name = "transpose" }, "^{T}"),
  ps({ trig = "_dag", name = "ddagger" }, "^\\ddagger"),
  ps({ trig = "dag", name = "dagger" }, "^\\dagger"),
}

-- Relations
local relations = {
  ms({ trig = "<=" }, t("\\le")),
  ms({ trig = ">=" }, t("\\geq")),
  ms({ trig = "=== " }, t("\\equiv ")),
  ms({ trig = ":=" }, t("\\coloneqq")),
  ms({ trig = "~=" }, t("\\cong")),
  ms({ trig = "(!=|<>)", trigEngine = "ecma" }, t("\\neq")),
  ms({ trig = "(sim|~~)", trigEngine = "ecma" }, t("\\sim")),
  ms({ trig = "=>" }, t("\\implies")),
  ms({ trig = "->" }, t("\\to")),
  ms({ trig = "|>", wordTrig = false, priority = 2000 }, t("\\mapsto")),
  ms({ trig = "==>", wordTrig = false, priority = 2000 }, t("\\Rightarrow")),
  ms({ trig = "===>", wordTrig = false, priority = 3000 }, t("\\Longrightarrow")),
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
  ps({ trig = "xx" }, "\\times "),
  ps({ trig = "ox" }, "\\otimes "),
  ps({ trig = "o+" }, "\\oplus "),
  ps({ trig = "**" }, "\\cdot "),
  ps({ trig = "..." }, "\\dots"),
  ps({ trig = "ooo" }, "\\infty"),
}

-- Operations
local operations = {
  ps({ trig = "binom" }, "\\binom{$1}{$2}$0"),
  ps({ trig = "sr" }, "\\sqrt{$1}$0"),
  ms(".b", t("\\dotsb")),
  ms(".c", t("\\dotsc")),
}


-- Math fonts
local MATHBB_LETTERS = "(R|N|Z|Q|C|E)"
local math_fonts = {
  ps({ trig = "mbb", name = "blackboard" }, "\\mathbb{$1}$0"),
  ps({ trig = "mrm", name = "roman" }, "\\mathrm{$1}$0"),
  ps({ trig = "mcal", name = "calligraphy" }, "\\mathcal{$1}$0"),
  ps({ trig = "mscr", name = "script" }, "\\mathscr{$1}$0"),
  ms({ trig = "(?<!\\\\)" .. MATHBB_LETTERS .. "\\1", trigEngine = "ecma" }, {
    f(function(_, snip)
      return "\\mathbb{" .. snip.captures[1] .. "}"
    end),
  }),
  ps({ trig = "11", name = "indicator" }, "\\mathbbm{1}"),
  ms(
    { trig = "\\b([A-Z])cal", name = "calligraphy", trigEngine = "ecma" }, {
      f(function(_, snip)
        return "\\mathcal{" .. snip.captures[1] .. "}"
      end)
    }),
  ms(
    { trig = "\\b(\\w*)rm", name = "roman", trigEngine = "ecma" }, {
      f(function(_, snip)
        return "\\mathrm{" .. snip.captures[1] .. "}"
      end)
    }),
  ms(
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
  ps({ trig = "set" }, "\\left\\{ $1 \\right\\\\}$0"),
  ps({ trig = "tup" }, "\\tup{ $1 }$0"),
  ps({ trig = "norm" }, "\\norm{ $1 }$0"),
  ps({ trig = "abs" }, "\\abs{ $1 }$0"),
  ps({ trig = "bracket" }, "\\bracket{$1}{$2}$0"),
  ps({ trig = "ket" }, "\\ket{$1}$0"),
  ps({ trig = "floor" }, "\\left\\lfloor $1 \\right\\rfloor$0"),
  ps({ trig = "ceil" }, "\\left\\lceil $1 \\right\\rceil$0"),
  ps({ trig = "paren" }, "\\paren{ $1 }$0"),
  -- ps({ trig = "vec" }, "\\vec{ $1 }$0"),
  ms(
    { trig = "(lr|@|;)(\\(|\\[|<|\\||\\\\\\||\\{)", trigEngine = "ecma", name = "Big parens" },
    d(1, function(_, snip)
      local left = snip.captures[2]
      local right = left
      if left == "(" then
        right = ")"
      elseif left == "<" then
        right = ">"
      elseif left == "{" then
        left = "\\{"
        right = "\\}"
      elseif left == "[" then
        left = "["
        right = "]"
      end

      return sn(
        1,
        fmt([[\left{} {} \right{}]], { t(left), i(1), t(right) })
      )
    end),
    { callbacks = remove_auto_close_char_callback }
  ),
  ms({ trig = "(\\(|\\||\\\\\\||\\[|\\{|<)", trigEngine = "ecma", name = "visual parens" }, {
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
  ms(
	{ trig = "(\\?%a+)bar", regTrig = true }, {
    f(function(_, snip)
      return "\\bar{" .. snip.captures[1] .. "}"
    end),
  }),
  ms({ trig = "bar" }, { t("\\bar{"), i(1), t("}"), }),
  ms({ trig = "(\\?%a+)Bar", regTrig = true }, {
    f(function(_, snip)
      return "\\overline{" .. snip.captures[1] .. "}"
    end),
  }),
  ms({ trig = "Bar" }, { t("\\overline{"), i(1), t("}"), }),
  ms({ trig = "(\\?%a+)([tT])il", regTrig = true }, {
    f(function(_, snip)
      local tilde = "\\tilde{"
      if snip.captures[2] == "T" then
        tilde = "\\widetilde{"
      end
      return tilde .. snip.captures[1] .. "}"
    end),
  }),
  ms({ trig = "([tT])il", regTrig = true }, {
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
  ms({ trig = "(\\?%a+)(brev)", regTrig = true }, {
    f(function(_, snip)
      return "\\breve{" .. snip.captures[1] .. "}"
    end),
  }),
  ms({ trig = "(\\?%a+)([hH])at", regTrig = true }, {
    f(function(_, snip)
      local hat = "\\hat{"
      if snip.captures[2] == "H" then
        hat = "\\widehat{"
      end
      return hat .. snip.captures[1] .. "}"
    end),
  }),
  ms({ trig = "([hH])at", regTrig = true }, {
    f(function(_, snip)
      local hat = "\\hat{"
      if snip.captures[1] == "T" then
        hat = "\\widehat{"
      end
      return hat
    end),
    i(1),
    t("}"),
  }),
  ms({ trig = "(\\?[%a%d^_]+)bm", regTrig = true }, {
    f(function(_, snip)
      return "\\bm{" .. snip.captures[1] .. "}"
    end),
  }),
}

-- Math environments
local math_environments = {
  ms({ trig = "beg", name = "begin/end" },
    fmt(
      [[
            \begin{{{}}}
              {}
            \end{{{}}}
        ]],
      {
        i(1),
        i(0),
        rep(1),
      }
    ),
    { condition = line_begin + in_mathzone }
  ),
  ms("ali", get_env("aligned", "."), { condition = in_mathzone * line_begin }),
  ms("case", get_env("cases", "."), { condition = in_mathzone }),
  ms({ trig = "([pbv])mat_(%d)(%d)", name = "matrices", regTrig = true, priority = 2000 }, {
    d(1, function(_, snip)
      local type = snip.captures[1] .. "matrix"
      local rows, cols = snip.captures[2], snip.captures[3]
      local nodes = {}
      local ts = 1
      table.insert(nodes, t("\\begin{" .. type .. "}"))
      for _ = 1, rows, 1 do
        table.insert(nodes, t({ "", "\t" }))
        for _ = 1, cols, 1 do
          table.insert(nodes, i(ts))
          table.insert(nodes, t(" & "))
          ts = ts + 1
        end
        table.remove(nodes, #nodes)
        table.insert(nodes, t(" \\\\"))
      end
      table.remove(nodes, #nodes)
      table.insert(nodes, t({ "", "\\end{" .. type .. "}" }))
      return sn(1, nodes)
    end),
  }),
}

-- In align
local align = {
  ams(
    { trig = "([^&])=", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "=&"
    end)
  ),
}

-- Expressions
local expressions = {
  rsps({ trig = "\\\\?sum" }, "\\sum_{${1:n=1}}^{${2:\\infty}}$0"),
  rsps({ trig = "\\\\?prod" }, "\\prod_{${1:n=1}}^{${2:\\infty}}$0"),
  rsps({ trig = "\\\\?cup" }, "\\bigcup_{${1:n=1}}^{${2:\\infty}}$0"),
  rsps({ trig = "\\\\?cap" }, "\\bigcap_{${1:n=1}}^{${2:\\infty}}$0"),
  rsps({ trig = "\\\\?lim" }, "\\lim_{${1:n} \\to ${2:\\infty}}$0"),
  rsps({ trig = "\\\\?limsup" }, "\\limsup_{${1:n} \\to ${2:\\infty}}$0"),
  rsps({ trig = "\\\\?int" }, "\\int_{${1:0}}"),
  ms({ trig = "(%w):", name = "functions", regTrig = true }, {
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
  ms({ trig = "part" }, {
    t("\\frac{\\partial "),
    i(1, " "),
    t("}{\\partial "),
    i(2, "x"),
    t("}"),
  }),
  ms({ trig = "diff", wordTrig = false, priority = 2000 }, {
    t("\\frac{\\mathrm{d} "),
    i(1, " "),
    t("}{\\mathrm{d} "),
    i(2, "x"),
    t("}"),
  }),
  ms("//", {
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
  ms({ trig = "(%b())/", regTrig = true }, {
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
  ms({ trig = "(\\frac%b{}%b{})/", regTrig = true }, {
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
  ms({ trig = "(\\%a+%b{})/", regTrig = true }, {
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
  ms({ trig = "([%a%d^_\\!'.]+)/", regTrig = true }, {
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
  ms("/", {
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
  ms({ trig = "UU", name = "underbrace", snippetType = "snippet" }, {
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
  ms({ trig = "U", name = "underset", snippetType = "snippet" }, {
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
  ms({ trig = "OO", name = "overbrace", snippetType = "snippet" }, {
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
  ms({ trig = "O", name = "overset", snippetType = "snippet" }, {
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
vim.list_extend(M, math_environments)
vim.list_extend(M, align)
vim.list_extend(M, expressions)
vim.list_extend(M, fractions)
vim.list_extend(M, visuals)

return nil, M
