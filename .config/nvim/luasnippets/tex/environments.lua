---@diagnostic disable: undefined-global

local in_comment = function()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
  return not in_mathzone() * not in_comment()
end

local in_list = function()
  return vim.fn["vimtex#env#is_inside"]("itemize")[1] + vim.fn["vimtex#env#is_inside"]("enumerate")[1] ~= 0
end

-- local line_begin = function()
--   local cur_line = vim.api.nvim_get_current_line()
--   return #cur_line == #string.match(cur_line, "%s*[^%s]+%s?")
-- end

local ls = require("luasnip")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

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


local rsdecorator = {
  wordTrig = false,
  condition = in_mathzone,
  trigEngine = "ecma",
  snippetType = "snippet",
}

local ps = ls.parser.parse_snippet
local rsps = ls.extend_decorator.apply(ls.parser.parse_snippet, rsdecorator)

return nil,
    {
      -- General environment
      s({ trig = "beg", name = "begin/end" },
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
        {
          condition = function()
            return line_begin() or in_mathzone()
          end,
        }
      ),

      -- Equations
      s("ali", get_env("align", "."), { condition = in_text }),
      s("ali", get_env("aligned", "."), { condition = in_mathzone * line_begin }),
      s("eqn", get_env("equation", "."), { condition = in_text }),
      s("case", get_env("cases", "."), { condition = in_mathzone }),

      -- Lists
      ps(
        { trig = "item", snippetType = "snippet" },
        "\\begin{itemize}\n  \\item $0\n\\end{itemize}",
        { condition = in_text * line_begin }
      ),
      s("enum", {
        t("\\begin{enumerate}"),
        c(1, {
          t(),
          t("[label=(\\alph*)]"),
          t("[label=(\\roman*)]"),
          t("[label=(\\arabic*)]"),
        }),
        t({ "", "  \\item " }),
        i(0),
        t({ "", "\\end{enumerate}" }),
      }, { condition = in_text * line_begin }),
      s({ trig = "- ", name = "point" }, t("\\item "), { condition = line_begin * in_list }),

      -- Proof environment
      s("pf", get_env("proof"), { condition = in_text * line_begin }),
      -- Note environment
      s("nt", {
        t("\\begin{note}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{note}" }),
      }, { condition = in_text * line_begin }),
      -- Definition environment
      s("defn", {
        t("\\begin{definition}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{definition}" }),
      }, { condition = in_text * line_begin }),
      -- Example environment
      s("ex", {
        t("\\begin{example}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{example}" }),
      }, { condition = in_text * line_begin }),
      -- Theorem environment
      s("thm", {
        t("\\begin{theorem}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{theorem}" }),
      }, { condition = in_text * line_begin }),

      -- Problem environment
      s("pb", {
        t("\\begin{problem}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{problem}" }),
      }, { condition = in_text * line_begin }),
      -- Lemma environment
      s("lem", {
        t("\\begin{lemma}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{lemma}" }),
      }, { condition = in_text * line_begin }),
      -- Algorithm environment
      s("algo", {
        t({
          "\\begin{algorithm}",
          "\t\\DontPrintSemicolon",
          "\t\\caption{",
        }),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{algorithm}" }),
      }, { condition = in_text * line_begin }),
      -- Matrices
      s({ trig = "([pbv])mat_(%d)(%d)", regTrig = true }, {
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
      }, { condition = in_mathzone }),
    }
