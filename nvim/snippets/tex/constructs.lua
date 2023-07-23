local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
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
  -- FRACTION
  s(
    { trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\frac{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([^%a])//", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\frac{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SQUARE ROOT
  s(
    { trig = "([^%a])rtt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<><><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[\sqrt{<>}]], { d(1, get_visual) }),
        fmta([[\sqrt[<>]{<>}]], { i(1), d(2, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HAT
  s(
    { trig = "(%a?)hat", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \hat{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- OVERLINE
  s(
    { trig = "(%a?)bar", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \overline{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- UNDERLINE
  s(
    { trig = "(%a?)udr", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \underline{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- TILDE
  s(
    { trig = "(%a?)tilde", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \widetilde{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- DOT
  s(
    { trig = "(%a?)dot", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \dot{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- DOUBLE DOT
  s(
    { trig = "(%a?)ddot", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \ddot{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- CANCEL
  s(
    { trig = "(%a?)#", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \calcel{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- ABSOLUTE VALUE
  s(
    { trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\abs{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- BINOMIAL SYMBOL
  s(
    { trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\binom{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
