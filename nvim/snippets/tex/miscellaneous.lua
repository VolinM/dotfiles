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
  s({ trig = "ooo", snippetType = "autosnippet", wordTrig = false }, {
    t("\\infty"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ptt", snippetType = "autosnippet", wordTrig = false }, {
    t("\\partial"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "c..", snippetType = "autosnippet" }, {
    t("\\cdots"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "v..", snippetType = "autosnippet" }, {
    t("\\vdots"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "d..", snippetType = "autosnippet" }, {
    t("\\ddots"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "...", snippetType = "autosnippet" }, {
    t("\\dots"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "NN", snippetType = "autosnippet" }, {
    t("\\N"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ZZ", snippetType = "autosnippet" }, {
    t("\\Z"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "QQ", snippetType = "autosnippet" }, {
    t("\\Q"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "RR", snippetType = "autosnippet" }, {
    t("\\R"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "CC", snippetType = "autosnippet" }, {
    t("\\C"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "OO", snippetType = "autosnippet" }, {
    t("\\O"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "Re", snippetType = "autosnippet" }, {
    t("\\Re"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "Im", snippetType = "autosnippet" }, {
    t("\\Im"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ll", snippetType = "autosnippet" }, {
    t("\\ell"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ł", snippetType = "autosnippet" }, {
    t("\\Lagr"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "þ", snippetType = "autosnippet" }, {
    t("\\Lapl"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "đ", snippetType = "autosnippet" }, {
    t("\\Fourier"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "AA", snippetType = "autosnippet" }, {
    t("\\forall"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "EE", snippetType = "autosnippet" }, {
    t("\\exists"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "/EE", snippetType = "autosnippet" }, {
    t("\\nexists"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ang", snippetType = "autosnippet" }, {
    t("\\angle"),
  }, { condition = tex.in_mathzone }),
}

return M
