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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local M = {
  s({ trig = ",,", snippetType = "autosnippet" }, {
    t("\\, "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "q" }, {
    t("\\quad "),
  }),
  s({ trig = "qq", snippetType = "autosnippet" }, {
    t("\\qquad "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "npp", snippetType = "autosnippet" }, {
    t({ "\\newpage", "" }),
  }, { condition = line_begin }),
  s({ trig = "which", snippetType = "autosnippet" }, {
    t("\\text{ for which } "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "all", snippetType = "autosnippet" }, {
    t("\\text{ for all } "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "and", snippetType = "autosnippet" }, {
    t("\\quad \\text{and} \\quad"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "forall", snippetType = "autosnippet" }, {
    t("\\text{ for all } "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "toc", snippetType = "autosnippet" }, {
    t("\\tableofcontents"),
  }, { condition = line_begin }),
  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\item "),
  }, { condition = line_begin }),
  s(
    { trig = "%--", snippetType = "autosnippet" },
    { t("% --------------------------------------------- %") },
    { condition = line_begin }
  ),
  -- HLINE WITH EXTRA VERTICAL SPACE
  s({ trig = "hr" }, { t("\\hr") }, { condition = line_begin }),
}

return M
