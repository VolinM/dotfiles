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
  s({ trig = "<-", snippetType = "autosnippet", wordTrig = false }, {
    t("\\leftarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "=<", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Leftarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "->", snippetType = "autosnippet" }, {
    t("\\rightarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "=>", snippetType = "autosnippet" }, {
    t("\\Rightarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "--<", snippetType = "autosnippet", wordTrig = false }, {
    t("\\longleftarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "==<", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Longleftarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "-->", snippetType = "autosnippet" }, {
    t("\\rightarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "==>", snippetType = "autosnippet" }, {
    t("\\Longrightarrow"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "!>", snippetType = "autosnippet" }, {
    t("\\mapsto"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "iff", snippetType = "autosnippet" }, {
    t("\\iff"),
  }, { condition = tex.in_mathzone }),
}

return M
