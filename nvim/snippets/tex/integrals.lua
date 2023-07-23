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
  -- INTEGRAL
  s(
    { trig = "([^%a])int", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[{<>}]], { d(1, get_visual) }),
        fmta([[_{<>}^{<>}{<>}]], { i(1), i(2), d(3, get_visual) }),
        fmta([[_{-\infty}^{\infty}{<>}]], { d(1, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DOUBLE INTEGRAL
  s(
    { trig = "([^%a])iint", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\iint<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[{<>}]], { d(1, get_visual) }),
        fmta([[_{<>}^{<>}{<>}]], { i(1), i(2), d(3, get_visual) }),
        fmta([[_{-\infty}^{\infty}{<>}]], { d(1, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TRIPLE INTEGRAL
  s(
    { trig = "([^%a])iiint", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\iiint<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[{<>}]], { d(1, get_visual) }),
        fmta([[_{<>}^{<>}{<>}]], { i(1), i(2), d(3, get_visual) }),
        fmta([[_{-\infty}^{\infty}{<>}]], { d(1, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CLOSED INTEGRAL
  s(
    { trig = "([^%a])oint", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\oint<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[{<>}]], { d(1, get_visual) }),
        fmta([[_{<>}{<>}]], { i(1), d(2, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CLOSED DOUBLE INTEGRAL
  s(
    { trig = "([^%a])oiint", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\oiint<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[{<>}]], { d(1, get_visual) }),
        fmta([[_{<>}{<>}]], { i(1), d(2, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
