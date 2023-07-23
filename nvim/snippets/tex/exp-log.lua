local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

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

local M = {
  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  s(
    { trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- EXPONENTIAL OPERATOR with big parenthesis
  s(
    { trig = "([^%a%\\])exp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\exp\\left(<>\\right)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- LOGARITHM
  s(
    { trig = "([^%a])ln", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 1500 },
    fmta([[<><><>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[ln{<>}]], { d(1, get_visual) }),
        fmta([[log_{<>}{<>}]], { i(1), d(2, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
