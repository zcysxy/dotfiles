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

local GREEK_LETTERS = {}
GREEK_LETTERS["a"] = "alpha"
GREEK_LETTERS["b"] = "beta"
GREEK_LETTERS["c"] = "chi"
GREEK_LETTERS["C"] = "Chi"
GREEK_LETTERS["d"] = "delta"
GREEK_LETTERS["D"] = "Delta"
GREEK_LETTERS["e"] = "epsilon"
GREEK_LETTERS["g"] = "gamma"
GREEK_LETTERS["G"] = "Gamma"
GREEK_LETTERS["i"] = "iota"
GREEK_LETTERS["k"] = "kappa"
GREEK_LETTERS["l"] = "lambda"
GREEK_LETTERS["L"] = "Lambda"
GREEK_LETTERS["m"] = "mu"
GREEK_LETTERS["n"] = "nu"
GREEK_LETTERS["o"] = "omega"
GREEK_LETTERS["O"] = "Omega"
GREEK_LETTERS["p"] = "phi"
GREEK_LETTERS["P"] = "Phi"
GREEK_LETTERS["r"] = "rho"
GREEK_LETTERS["s"] = "sigma"
GREEK_LETTERS["S"] = "Sigma"
GREEK_LETTERS["t"] = "theta"
GREEK_LETTERS["T"] = "Theta"
GREEK_LETTERS["x"] = "xi"
GREEK_LETTERS["X"] = "Xi"
GREEK_LETTERS["z"] = "zeta"

local COMMANDS = "(sin|cos|tan|log|ln|exp|ell|nabla|max|sup)"
local GREEK_COMMANDs =
"(alpha|beta|[cC]hi|[dD]elta|epsilon|eta|[gG]amma|iota|kappa|[lL]ambda|mu|nu|[oO]mega|[pP]hi|[Pp]i|[rR]ho|[sS]igma|[tT]heta|tau|Xi)"
local MATHBB_LETTERS = "(R|N|Z|Q|C|E)"

return nil,
    {
      -- Greek letters
      s({ trig = "[;@](%a)", regTrig = true, }, {
        f(function(_, snip)
          if GREEK_LETTERS[snip.captures[1]] then
            return "\\" .. GREEK_LETTERS[snip.captures[1]]
          end
          return snip.trigger
        end),
      }),

      -- Commands
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


      -- Subscripts
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
      ),

      -- Superscripts
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

      -- Relations
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

      -- Symbols
      ps("xx", "\\times "),
      ps("ox", "\\otimes "),
      ps("o+", "\\oplus "),
      ps("**", "\\cdot "),
      ps("...", "\\dots"),
      ps("ooo", "\\infty"),

      -- Operations
      ps("binom", "\\binom{$1}{$2}$0"),
      ps("sr", "\\sqrt{$1}$0"),
      -- Binary operator dots
      s(".b", t("\\dotsb")),
      -- Comma-separating dots
      s(".c", t("\\dotsc")),
      -- Square root

      -- Math fonts
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


      -- Decorations
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

      -- Surroundings
      ps("set", "\\set{ $1 }$0"),
      ps("tup", "\\tup{ $1 }$0"),
      ps("norm", "\\norm{ $1 }$0"),
      ps("abs", "\\abs{ $1 }$0"),
      ps("bracket", "\\bracket{$1}{$2}$0"),
      ps("ket", "\\ket{$1}$0"),
      ps("floor", "\\left\\lfloor $1 \\right\\rfloor$0"),
      ps("ceil", "\\left\\lceil $1 \\right\\rceil$0"),
      ps("paren", "\\paren{ $1 }$0"),
      ps("vec", "\\vec{ $1 }$0"),
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

      -- Auto-aligned equals
      s(
        { trig = "([^&])=", regTrig = true },
        f(function(_, snip)
          return snip.captures[1] .. "&="
        end)
      ),

      -- Expressions
      rsps({ trig = "\\\\?sum" }, "\\sum_{${1:n=1}}^{${2:\\infity}}$0"),
      rsps({ trig = "\\\\?prod" }, "\\prod_{${1:n=1}}^{${2:\\infity}}$0"),
      rsps({ trig = "\\\\?cup" }, "\\bigcup_{${1:n=1}}^{${2:\\infity}}$0"),
      rsps({ trig = "\\\\?cap" }, "\\bigcap_{${1:n=1}}^{${2:\\infity}}$0"),
      rsps({ trig = "\\\\?lim" }, "\\lim_{${1:n} \\to ${2:\\infity}}$0"),
      rsps({ trig = "\\\\?limsup" }, "\\limsup_{${1:n} \\to ${2:\\infity}}$0"),
      rsps({ trig = "\\\\?int" }, "\\int_{${1:0}}^{${2:\\infity}} $0 \\, \\mathrm{d}${3:x}"),

      -- Functions
      s({ trig = "(%w):", regTrig = true }, {
        d(1, function(_, snip)
          return sn(1, {
            t(snip.captures[1] .. "\\colon "),
            i(1, "\\R"),
            t("\\to "),
            i(2, "\\R"),
          })
        end),
      }),

      -- Derivatives
      s({ trig = "part" }, {
        t("\\frac{\\partial "),
        i(1, " "),
        t("}{\\partial "),
        i(2, "x"),
        t("}"),
      }),
      -- diff
      s({ trig = "diff", wordTrig = false, priority = 2000 }, {
        t("\\frac{\\mathrm{d} "),
        i(1, " "),
        t("}{\\mathrm{d} "),
        i(2, "x"),
        t("}"),
      }),

      -- Fractions
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

      -- Visuals
      s({trig = "UU", name = "underbrace", snippetType = "snippet"} , {
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
      s({trig = "U", name = "underset", snippetType = "snippet"} , {
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
      s({trig = "OO", name = "overbrace", snippetType = "snippet"} , {
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
      s({trig = "O", name = "overset", snippetType = "snippet"} , {
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
