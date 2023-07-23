local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

-- https://www.cmor-faculty.rice.edu/~heinken/latex/symbols.pdf

local M = {
  s({ trig = "star", snippetType = "autosnippet", wordTrig = false }, {
    t("\\star"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "·", snippetType = "autosnippet", wordTrig = false }, {
    t("\\cdot"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "circ", snippetType = "autosnippet", wordTrig = false }, {
    t("\\circ"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "xx", snippetType = "autosnippet" }, {
    t("\\times "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "div", snippetType = "autosnippet", wordTrig = false }, {
    t("\\div"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "O*", snippetType = "autosnippet", wordTrig = false }, {
    t("\\circledast"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "+-", snippetType = "autosnippet", wordTrig = false }, {
    t("\\pm"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "-+", snippetType = "autosnippet", wordTrig = false }, {
    t("\\-+"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "O..", snippetType = "autosnippet", wordTrig = false }, {
    t("\\odot"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "O--", snippetType = "autosnippet", wordTrig = false }, {
    t("\\ominus"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "O++", snippetType = "autosnippet", wordTrig = false }, {
    t("\\oplus"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "Oxx", snippetType = "autosnippet", wordTrig = false }, {
    t("\\otimes"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "Bxx", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Box"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "IN", snippetType = "autosnippet", wordTrig = false }, {
    t("\\cap"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "UU", snippetType = "autosnippet", wordTrig = false }, {
    t("\\cup"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "==", snippetType = "autosnippet", wordTrig = false }, {
    t("\\equiv"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "cong", snippetType = "autosnippet", wordTrig = false }, {
    t("\\cong"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "!=", snippetType = "autosnippet", wordTrig = false }, {
    t("\\neq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "~~", snippetType = "autosnippet", wordTrig = false }, {
    t("\\sim"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "~=", snippetType = "autosnippet", wordTrig = false }, {
    t("\\simeq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "app", snippetType = "autosnippet", wordTrig = false }, {
    t("\\approx"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "prop", snippetType = "autosnippet", wordTrig = false }, {
    t("\\propto"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "<=", snippetType = "autosnippet", wordTrig = false }, {
    t("\\leq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = ">=", snippetType = "autosnippet", wordTrig = false }, {
    t("\\geq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "<<", snippetType = "autosnippet", wordTrig = false }, {
    t("\\ll"),
  }, { condition = tex.in_mathzone }),
  s({ trig = ">>", snippetType = "autosnippet", wordTrig = false }, {
    t("\\gg"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "/<", snippetType = "autosnippet" }, {
    t("\\nless"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "/>", snippetType = "autosnippet" }, {
    t("\\ngtr"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "prec", snippetType = "autosnippet", wordTrig = false }, {
    t("\\prec"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "succ", snippetType = "autosnippet", wordTrig = false }, {
    t("\\succ"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "||", snippetType = "autosnippet", wordTrig = false }, {
    t("\\pearallel"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "_|", snippetType = "autosnippet", wordTrig = false }, {
    t("\\perp"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "subb", snippetType = "autosnippet", wordTrig = false }, {
    t("\\subset"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "sube", snippetType = "autosnippet", wordTrig = false }, {
    t("\\subseteq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "supp", snippetType = "autosnippet", wordTrig = false }, {
    t("\\supset"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "supe", snippetType = "autosnippet", wordTrig = false }, {
    t("\\supseteq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "!in", snippetType = "autosnippet", wordTrig = false }, {
    t("\\notin"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "€", snippetType = "autosnippet", wordTrig = false }, {
    t("\\in"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ni", snippetType = "autosnippet", wordTrig = false }, {
    t("\\ni"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¨*", snippetType = "autosnippet", wordTrig = false }, {
    t("\\therefore"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¨.", snippetType = "autosnippet", wordTrig = false }, {
    t("\\because"),
  }, { condition = tex.in_mathzone }),
}

return M
