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

return nil, {
	s({ trig = " te ", name = "there exists" }, t(" there exists ")),
	s({ trig = " st ", name = "such that" }, t(" such that ")),
	s({ trig = " iff ", name = "if and only if" }, t(" if and only if ")),
	s({ trig = " wrt ", name = "with regard to" }, t(" w.r.t. ")),
	s({ trig = "\\beg([ ,])", name = "for example", trigEngine = "ecma" }, { f(function(_, snip)
		return "e.g." .. snip.captures[1
		]
	end)
	}),
}
