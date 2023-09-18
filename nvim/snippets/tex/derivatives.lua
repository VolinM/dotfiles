local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
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
  -- DIFFERENTIAL
  s(
    { trig = "dff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, {
        fmta([[\dd{<>}]], { i(1) }),
        fmta([[\dd[]{<>}]], { i(1) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "d,,", wordTrig = true, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, {
        fmta([[\dd{<>}]], { i(1) }),
        fmta([[\dd[3]{<>}]], { i(1) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TOTAL DERIVATIVE (only denominator)
  s(
    { trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TOTAL DERIVATIVE (numerator and denominator)
  s(
    { trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{<>}{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TOTAL DERIVATIVE (numerator and denominator, higher order)
  s(
    { trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv[<>]{<>}{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "2"),
      d(2, get_visual),
      i(3),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE (only denominator)
  s(
    { trig = "([^%a])pD", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE (numerator and denominator)
  s(
    { trig = "([^%a])pdd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE (numerator and denominator, higher order)
  s(
    { trig = "([^%a])ppd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv[<>]{<>}{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "2"),
      d(2, get_visual),
      i(3),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE (numerator and denominator, higher order mixed)
  s(
    { trig = "([^%a])pdm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}{<>}{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
      i(3),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
