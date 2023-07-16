local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

local helpers = require("utils.luasnip-helper")
local get_visual = helpers.get_visual

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
  s({ trig = "q" }, {
    t("\\quad "),
  }),
  s({ trig = "qq", snippetType = "autosnippet" }, {
    t("\\qquad "),
  }),
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
  s({ trig = "inff", snippetType = "autosnippet" }, {
    t("\\infty"),
  }),
  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\item "),
  }, { condition = line_begin }),
  s(
    { trig = "%--", snippetType = "autosnippet" },
    { t("% --------------------------------------------- %") },
    { condition = line_begin }
  ),
  -- HLINE WITH EXTRA VERTICAL SPACE
  s({ trig = "hl" }, { t("\\hline {\\rule{0pt}{2.5ex}} \\hspace{-7pt}") }, { condition = line_begin }),
}

return M
